//
//  HACoreAPI.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-09.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "CoreAPI.h"
#import "AFNetworking.h"
#import "AFImageDownloader.h"
#import "AFAutoPurgingImageCache.h"
#import "HACore.h"
#import <AliyunOSSiOS/OSSService.h>
#import "HAConstHeader.h"
#import "HAApp.h"

@interface CoreAPI () {
    
    AFHTTPSessionManager *manager;
    AFHTTPSessionManager *absolute;
    OSSClient *ossClient;
    
    NSString *PROTOCOL;
    NSString *BASE_URL;
    NSString *API;
    
    NSString *OSS_ENDPOINT;
    NSString *OSS_ACCESS_KEY_ID;
    NSString *OSS_ACCESS_KEY_SECRET;
    NSString *OSS_BUCKET_NAME;
    NSString *OSS_DOMAIN;
}

@end

@implementation CoreAPI

// MARK: - INIT

- (instancetype)init {
    if (self = [super init]) {
        
        _debug = NO;
        
        if (_debug == NO) {
            // PRODUCTION VERSION
            PROTOCOL = [[HACore core] valueForConfWithKey:@"core-net-is-secure-transport"];
            BASE_URL = [[HACore core] valueForConfWithKey:@"core-net-domain"];
            API = [[HACore core] valueForConfWithKey:@"core-net-api-path"];
        } else {
            // DEVELOP VERSION
            PROTOCOL = [[HACore core] valueForConfWithKey:@"core-net-is-secure-transport-dev"];
            BASE_URL = [[HACore core] valueForConfWithKey:@"core-net-domain-dev"];
            API = [[HACore core] valueForConfWithKey:@"core-net-api-path-dev"];
        }
        
        OSS_ENDPOINT = [[HACore core] valueForConfWithKey:@"core-net-oss-endpoint"];
        OSS_ACCESS_KEY_ID = [[HACore core] valueForConfWithKey:@"core-net-oss-access-key-id"];
        OSS_ACCESS_KEY_SECRET = [[HACore core] valueForConfWithKey:@"core-net-oss-access-key-secret"];
        OSS_BUCKET_NAME = [[HACore core] valueForConfWithKey:@"core-net-oss-bucket-name"];
        OSS_DOMAIN = [[HACore core] valueForConfWithKey:@"core-net-oss-domain"];
        
        [self initialManager];
        
        // CREDENTIAL
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc]
                                                initWithPlainTextAccessKey:OSS_ACCESS_KEY_ID
                                                secretKey:OSS_ACCESS_KEY_SECRET];
        
        // INITIAL CLIENT
        ossClient = [[OSSClient alloc] initWithEndpoint:OSS_ENDPOINT credentialProvider:credential];
    }
    return self;
}

- (void)initialManager {
    // INITIAL MANAGER
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithFormat:@"%@%@", PROTOCOL, BASE_URL]];
    absolute = [[AFHTTPSessionManager alloc] init];
    
    // SETUP JSON FORMAT
    AFHTTPResponseSerializer *responseSerializer = manager.responseSerializer;
    NSMutableSet *types = [responseSerializer.acceptableContentTypes mutableCopy];
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    [types addObject:@"json/text"]; // OR OTHERS
    [types addObject:@"text/plain"];
    //	[types addObject:@"text/html"];
    responseSerializer.acceptableContentTypes = types;
    manager.responseSerializer = responseSerializer;
    
    AFHTTPRequestSerializer *requestSerializer = manager.requestSerializer;
    [requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    // "Accept-Language" = "zh-Hans-CN;q=1";
    // "User-Agent" = "HuaaoTemplate/1.0.0 (iPhone; iOS 10.1; Scale/2.00)";
    manager.requestSerializer = requestSerializer;
}

- (void)setDebug:(BOOL)debug {
    _debug = debug;
    
    if (_debug == NO) {
        // PRODUCTION VERSION
        PROTOCOL = [[HACore core] valueForConfWithKey:@"core-net-is-secure-transport"];
        BASE_URL = [[HACore core] valueForConfWithKey:@"core-net-domain"];
        API = [[HACore core] valueForConfWithKey:@"core-net-api-path"];
    } else {
        // DEVELOP VERSION
        PROTOCOL = [[HACore core] valueForConfWithKey:@"core-net-is-secure-transport-dev"];
        BASE_URL = [[HACore core] valueForConfWithKey:@"core-net-domain-dev"];
        API = [[HACore core] valueForConfWithKey:@"core-net-api-path-dev"];
    }
    
    [self initialManager];
}

+ (instancetype)core {
    static CoreAPI *coreapi;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreapi = [[CoreAPI alloc] init];
    });
    return coreapi;
}

// MARK: - UTILS

- (NSString *)serverImageURLString:(NSString *)filepath {
    
    // CHECK STRING FIRST
    if (filepath == nil || [filepath isKindOfClass:[NSString class]] == NO || [filepath isEqualToString:@""]) {
        return filepath;
    }
    
    // IF IT'S URL
    if ([filepath hasPrefix:@"http://"] || [filepath hasPrefix:@"https://"]) {
        NSLog(@"IT'S AN URL.");
        return filepath;
    }
    
    if ([filepath hasPrefix:[NSString stringWithFormat:@"//%@", BASE_URL]]) {
        NSLog(@"STRANGE URL.");
        return [NSString stringWithFormat:@"http:%@", filepath];
    }
    
    return [[NSString stringWithFormat:@"%@%@/upload/%@", PROTOCOL, BASE_URL, filepath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)serverPrefix {
    return [[PROTOCOL stringByAppendingString:BASE_URL] stringByAppendingString:API];
}

- (NSString *)domainPrefix {
    return [PROTOCOL stringByAppendingString:BASE_URL];
}

// MARK: - NETWORK REQUEST

// MARK: | GET

- (NSURLSessionDataTask *)GETURLString:(NSString *)URLString
                        withParameters:(NSDictionary *)params
                               success:(void (^)(id))success
                                 error:(void (^)(NSString *, NSString *, id))apierror
                               failure:(void (^)(NSError *))failure {
    NSURLSessionDataTask *dataTask = [manager GET:[API stringByAppendingString:URLString] parameters:params progress:^(NSProgress *downloadProgress) {
        // PROGRESS
    } success:^(NSURLSessionDataTask *task, id resp) {
        if ([resp isKindOfClass:[NSDictionary class]] == NO) {
            apierror(@"-1", @"PARSE ERROR", resp);
            NSLog(@"\n\nREQUEST(GET) PARSE ERROR\n\tAPI\t\t%@\n\n", URLString);
        }
        if ([[resp allKeys] containsObject:@"resultCode"] && [resp[@"resultCode"] isEqualToString:CodeSuccess] ) {
            // SUCCESS
            success(resp);
            NSLog(@"\n\nREQUEST(GET) SUCCESS\n\tAPI\t%@\n", URLString);
        } else {
            // API ERROR
            NSLog(@"\n\nREQUEST(GET) ERROR\n\tAPI\t\t%@\n\tCode\t%@\n\tMessage\t%@\n\n", URLString, resp[@"resultCode"], resp[@"errorMsg"]);
            NSString *code = resp[@"resultCode"];
            if ([code isEqualToString:CodeErrorException]) {
                // TOKEN LOSE NEED LOGIN
                [[HAApp current] logout];
            }
            apierror(code, resp[@"errorMsg"], resp);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // REQUEST FAILED
        failure(error);
        NSLog(@"\n\nREQUEST(GET) FAILED\n\tAPI\t%@\n", URLString);
    }];
    return dataTask;
}

- (NSURLSessionDataTask *)GETAbsoluteURLString:(NSString *)URLString
                                withParameters:(NSDictionary *)params
                                       success:(void (^)(id))success
                                       failure:(void (^)(NSError *))failure {
    
    if (![URLString hasPrefix:@"http://"] && ![URLString hasPrefix:@"https://"]) {
        NSLog(@"\n\nREQUEST(Absolute GET) ERROR\n\tNOT A CORRECT URL STRING\n\t%@", URLString);
        return nil;
    }
    NSURLSessionDataTask *dataTask = [absolute GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        // IN PROGRESS
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    return dataTask;
}

/**
 GET网络请求，返回网页字符串
 
 @param URLString 网络URL地址
 @param params 请求参数
 @param success 网络请求成功块
 @param apierror 网络请求出错块
 @param failure 网络请求失败块
 @return 网络请求任务
 */
- (NSURLSessionDataTask *)GETPageFromURLString:(NSString *)URLString withParameters:(NSDictionary *)params success:(void (^)(id))success error:(void (^)(NSString *, NSString *, id))apierror failure:(void (^)(NSError *))failure {
    
    NSURLSessionConfiguration *sconf = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *tmgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithFormat:@"%@%@", PROTOCOL, BASE_URL] sessionConfiguration:sconf];
    
    NSURLSessionDataTask *datatask = [tmgr GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    return datatask;
}

- (void)GETImageWithURLString:(NSString *)URLString success:(void (^)(UIImage *))success failure:(void (^)(NSError *))failure {
    
    if (URLString == nil || [URLString isEqualToString:@""] || URLString.length == 0) {
        NSLog(@"\n\nREQUEST(DOWNLOAD IMAGE) WRONG\n\tURL\tEMPTH\n");
        failure(nil);
        return;
    }
    
    AFImageDownloader *imgd = [AFImageDownloader defaultInstance];
    [imgd downloadImageForURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self serverImageURLString:URLString]]] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
        success(responseObject);
        NSLog(@"\n\nREQUEST(DOWNLOAD IMAGE) SUCCESS\n\tURL\t%@\n", request.URL.absoluteString);
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"\n\nREQUEST(DOWNLOAD IMAGE) FAILED\n\tURL\t%@\n", request.URL.absoluteString);
    }];
}

// MARK: | POST

- (NSURLSessionDataTask *)POSTURLString:(NSString *)URLString
                         withParameters:(NSDictionary *)params
                                success:(void (^)(id))success
                                  error:(void (^)(NSString *, NSString *, id))apierror
                                failure:(void (^)(NSError *))failure {
    
    NSURLSessionDataTask *dataTask = [manager POST:[API stringByAppendingString:URLString] parameters:params progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id resp) {
        
        if ([resp isKindOfClass:[NSDictionary class]] == NO) {
            apierror(@"-1", @"PARSE ERROR", resp);
            NSLog(@"\n\nREQUEST(POST) PARSE ERROR\n\tAPI\t\t%@\n\n", URLString);
        }
        
        if ([[resp allKeys] containsObject:@"resultCode"] && [resp[@"resultCode"] integerValue] == HACodeSuccess) {
            // SUCCESS
            success(resp);
            NSLog(@"\n\nREQUEST(POST) SUCCESS\n\tAPI\t%@\n", URLString);
        } else {
            // API ERROR
            NSLog(@"\n\nREQUEST(POST) ERROR\n\tAPI\t\t%@\n\tCode\t%@\n\tMessage\t%@\n\n", URLString, resp[@"resultCode"], resp[@"errorMsg"]);
            NSString *code = resp[@"resultCode"];
            if ([code isEqualToString:CodeErrorException]) {
                // TOKEN LOSE NEED LOGIN
                [[HAApp current] logout];
            }
            apierror(code, resp[@"errorMsg"], resp);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // REQUEST FAILED
        failure(error);
        NSLog(@"\n\nREQUEST(POST) FAILED\n\tAPI\t%@\n", URLString);
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)POSTImage:(UIImage *)image
                           progress:(void (^)(float, float))progress
                            success:(void (^)(id))success
                           apierror:(void (^)(NSString *, NSString *, id))apierror
                            failure:(void (^)(NSError *))failure {
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@/api/file/fileupload",
                           [[HACore core] valueForConfWithKey:[HACore core].debug ? @"core-net-is-secure-transport-dev" : @"core-net-is-secure-transport"],
                           [[HACore core] valueForConfWithKey:[HACore core].debug ? @"core-net-domain-dev" : @"core-net-domain"]];
    
    NSString *filename = [NSString stringWithFormat:@"ios%@.jpg", [[NSDate date] stringWithFormat:@"yyyyMMddHHmmss" andTimezone:SHANGHAI]];
    NSDictionary *param = @{@"name":filename,};
    
    NSURLSessionDataTask *dataTask = [absolute POST:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1) name:@"file" fileName:filename mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable resp) {
        if ([resp[@"resultCode"] integerValue] == 0) {
            success(resp);
            NSLog(@"\n\nUPLOAD IMAGE(POST) SUCCESS\n\tAPI\t%@\n\tRESULT\t%@\n ", URLString, resp[@"url"]);
        } else {
            apierror(resp[@"resultCode"], resp[@"errorMsg"], resp);
            NSLog(@"\n\nUPLOAD IMAGE(POST) ERROR\n\tAPI\t%@\n\tERROR\tCODE=%@\tMSG=%@\n ", URLString, resp[@"resultCode"], resp[@"errorMsg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"\n\nUPLOAD IMAGE(POST) FAILED\n\tAPI\t%@\n", URLString);
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)POSTFileURL:(NSURL *)fileURL
                             filetype:(NSString *)filetype
                             mimetype:(NSString *)mimetype
                             progress:(void (^)(float, float))progress
                              success:(void (^)(id))success
                             apierror:(void (^)(NSString *, NSString *, id))apierror
                              failure:(void (^)(NSError *))failure {
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@/file/upload/file.do",
                           [[HACore core] valueForConfWithKey:[HACore core].debug ? @"core-net-is-secure-transport-dev" : @"core-net-is-secure-transport"],
                           [[HACore core] valueForConfWithKey:[HACore core].debug ? @"core-net-domain-dev" : @"core-net-domain"]];
    
    NSString *filename = [NSString stringWithFormat:@"ios%@.%@", [[NSDate date] stringWithFormat:@"yyyyMMddHHmmss" andTimezone:SHANGHAI], filetype];
    NSDictionary *param = @{@"name":filename,};
    
    NSURLSessionDataTask *dataTask = [absolute POST:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:fileURL name:@"ios" fileName:filename mimeType:mimetype error:NULL];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable resp) {
        if ([resp[@"resultCode"] isEqualToString:CodeSuccess]) {
            success(resp[@"data"]);
            NSLog(@"\n\nUPLOAD FILE(POST) SUCCESS\n\tAPI\t%@\n\tRESULT\t%@\n ", URLString, resp[@"data"]);
        } else {
            apierror(resp[@"resultCode"], resp[@"errorMsg"], resp);
            NSLog(@"\n\nUPLOAD FILE(POST) ERROR\n\tAPI\t%@\n\tERROR\tCODE=%@\tMSG=%@\n ", URLString, resp[@"resultCode"], resp[@"errorMsg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"\n\nUPLOAD FILE(POST) FAILED\n\tAPI\t%@\n", URLString);
    }];
    
    return dataTask;
}

// MARK: - PUT

- (void)PUTInOSSWithImage:(UIImage *)image
                 progress:(void (^)(float, float))progress
                  success:(void (^)(NSString *))success
                  failure:(void (^)(NSError *))failure {
    
    OSSPutObjectRequest *putreq = [OSSPutObjectRequest new];
    
    putreq.bucketName = OSS_BUCKET_NAME;
    NSString *filepath = [NSString stringWithFormat:@"ios/%@_%04d.jpg",
                          @([[NSDate date] timeIntervalSince1970]),
                          (1 + arc4random() % (1000 - 1))
                          ];
    putreq.objectKey = filepath;
    
    putreq.uploadingData = UIImageJPEGRepresentation(image, 1);
    putreq.contentType = @"image/jpeg";
    
    putreq.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        progress(totalBytesSent / 1024.0f, totalBytesExpectedToSend / 1024.0f);
    };
    
    OSSTask *putFileTask = [ossClient putObject:putreq];
    [putFileTask continueWithBlock:^id (OSSTask *task) {
        
        if (!task.error) {
            NSString *imgURL = [NSString stringWithFormat:@"%@/%@", OSS_DOMAIN, filepath];
            NSLog(@"\n\nOSS UPLOAD IMAGE DATA SUCCESS\nIMAGE URL:\n\t%@", imgURL);
            success(imgURL);
        } else {
            NSLog(@"\n\nOSS UPLOAD IMAGE DATA FAILED\n\tERROR:\n%@", task.error);
            failure(task.error);
        }
        return nil;
    }];
}

- (void)PUTInOSSWithData:(NSData *)binary mimetype:(NSString *)mimetype filetype:(NSString *)filetype progress:(void (^)(float, float))progress success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    if (binary == nil || [mimetype isKindOfClass:[NSString class]] == NO || mimetype == nil || [mimetype isEqualToString:@""]) {
        NSLog(@"\n\nOSS UPLOAD DATA FAILED\n\tERROR: PARAM ERROR, NOT UPLOAD");
        return;
    }
    
    OSSPutObjectRequest *putreq = [OSSPutObjectRequest new];
    
    putreq.bucketName = OSS_BUCKET_NAME;
    NSString *filepath = [NSString stringWithFormat:@"ios/%@_%04d.%@",
                          @([[NSDate date] timeIntervalSince1970]),
                          (1 + arc4random() % (1000 - 1)),
                          filetype
                          ];
    putreq.objectKey = filepath;
    
    putreq.uploadingData = binary;
    putreq.contentType = mimetype;
    
    putreq.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        progress(totalBytesSent / 1024.0f, totalBytesExpectedToSend / 1024.0f);
    };
    
    OSSTask *putFileTask = [ossClient putObject:putreq];
    [putFileTask continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
        
        if (!task.error) {
            NSString *dataURL = [NSString stringWithFormat:@"%@/%@", OSS_DOMAIN, filepath];
            NSLog(@"\n\nOSS UPLOAD DATA SUCCESS\nIMAGE URL:\n\t%@", dataURL);
            success(dataURL);
        } else {
            NSLog(@"\n\nOSS UPLOAD DATA FAILED\n\tERROR:\n%@", task.error);
            failure(task.error);
        }
        return nil;
    }];
}

- (void)PUTInOSSWithFilePath:(NSString *)file mimetype:(NSString *)mimetype filetype:(NSString *)filetype progress:(void (^)(float, float))progress success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    if (file == nil || [file isKindOfClass:[NSString class]] == NO || [file isEqualToString:@""]
        || [mimetype isKindOfClass:[NSString class]] == NO || mimetype == nil || [mimetype isEqualToString:@""]) {
        NSLog(@"\n\nOSS UPLOAD DATA FAILED\n\tERROR: PARAM ERROR, NOT UPLOAD");
        return;
    }
    
    OSSPutObjectRequest *putreq = [OSSPutObjectRequest new];
    
    putreq.bucketName = OSS_BUCKET_NAME;
    NSString *filenamepath = [NSString stringWithFormat:@"ios/%@_%04d.%@",
                              @([[NSDate date] timeIntervalSince1970]),
                              (1 + arc4random() % (1000 - 1)),
                              filetype
                              ];
    putreq.objectKey = filenamepath;
    
    putreq.uploadingFileURL = [NSURL URLWithString:file];
    putreq.contentType = mimetype;
    
    putreq.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        progress(totalBytesSent / 1024.0f, totalBytesExpectedToSend / 1024.0f);
    };
    
    OSSTask *putFileTask = [ossClient putObject:putreq];
    [putFileTask continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
        
        if (!task.error) {
            NSString *dataURL = [NSString stringWithFormat:@"%@/%@", OSS_DOMAIN, filenamepath];
            NSLog(@"\n\nOSS UPLOAD DATA SUCCESS\nIMAGE URL:\n\t%@", dataURL);
            success(dataURL);
        } else {
            NSLog(@"\n\nOSS UPLOAD DATA FAILED\n\tERROR:\n%@", task.error);
            failure(task.error);
        }
        return nil;
    }];
    
}

@end
