//
//  HACoreAPI.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-09.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import "PreHeader.h"

/**
 核心库 服务API访问模块
 */
@interface CoreAPI : NSObject

// MARK: - INIT

/**
 获取核心库网络模块唯一实例
 
 @return 核心库网络模块单例
 */
+ (instancetype)core;

/**
 Debug状态开关
 */
@property (nonatomic, assign) BOOL debug;

// MARK: - UTILS

/**
 获取Server存储的图片的绝对地址
 
 @param filepath 图片相对路径
 @return 图片绝对地址
 */
- (NSString *)serverImageURLString:(NSString *)filepath;

/**
 获取当前debug状态下的协议与域名+API前缀
 
 @return 字符串结果
 */
- (NSString *)serverPrefix;

/**
 获取当前debug状态下的协议与域名前缀
 
 @return 字符串结果
 */
- (NSString *)domainPrefix;

// MARK: - NETWORK REQUEST

// MARK: GET

/**
 GET网络请求, 目标是该工程的Server API
 
 @param URLString API地址
 @param params API参数
 @param success 网络请求成功块
 @param apierror 网络请求出错块
 @param failure 网络请求失败块
 @return 网络请求任务
 */
- (NSURLSessionDataTask *)GETURLString:(NSString *)URLString
                        withParameters:(NSDictionary *)params
                               success:(void (^)(id ret))success
                                 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
                               failure:(void (^)(NSError *error))failure;


/**
 GET网络请求, 目标是HTTP协议下的任意绝对网址
 
 @param URLString 网络URL地址
 @param params 请求参数
 @param success 网络请求成功块
 @param failure 网络请求失败块
 @return 网络请求任务
 */
- (NSURLSessionDataTask *)GETAbsoluteURLString:(NSString *)URLString
                                withParameters:(NSDictionary *)params
                                       success:(void (^)(id ret))success
                                       failure:(void (^)(NSError *error))failure;


/**
 GET请求图片
 
 @param URLString 网络URL地址
 @param success 网络请求成功块
 @param failure 网络请求失败块
 */
- (void)GETImageWithURLString:(NSString *)URLString
                      success:(void (^)(UIImage *))success
                      failure:(void (^)(NSError *))failure;

// MARK: POST

/**
 POST网络请求, 目标是该工程的Server API
 
 @param URLString API地址
 @param params API参数
 @param success 网络请求成功块
 @param apierror 网络请求出错块
 @param failure 网络请求失败块
 @return 网络请求任务
 */
- (NSURLSessionDataTask *)POSTURLString:(NSString *)URLString
                         withParameters:(NSDictionary *)params
                                success:(void (^)(id ret))success
                                  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
                                failure:(void (^)(NSError *error))failure;

/**
 UPLOAD图片，上传位置为API服务器
 
 @param image UIImage对象
 @param progress 进度
 @param success 网络请求成功块
 @param apierror 网络请求出错块
 @param failure 网络请求失败块
 @return 网络请求任务
 */
- (NSURLSessionDataTask *)POSTImage:(UIImage *)image
                           progress:(void (^)(float completed, float total))progress
                            success:(void (^)(id ret))success
                           apierror:(void (^)(NSInteger code, NSString *msg, id ret))apierror
                            failure:(void (^)(NSError *error))failure;

/**
 UPLOAD磁盘文件，上传目标位置为API服务器
 
 @param fileURL 文件URL
 @param filetype 文件类型名
 @param mimetype mime-type类型名
 @param progress 进度
 @param success 网络请求成功块
 @param apierror 网络请求错误块
 @param failure 网络请求失败块
 @return 网络请求任务
 */
- (NSURLSessionDataTask *)POSTFileURL:(NSURL *)fileURL
                             filetype:(NSString *)filetype
                             mimetype:(NSString *)mimetype
                             progress:(void (^)(float completed, float total))progress
                              success:(void (^)(id ret))success
                             apierror:(void (^)(NSInteger code, NSString *msg, id ret))apierror
                              failure:(void (^)(NSError *error))failure;

// MARK: PUT

/**
 上传图片到OSS服务，并获取文件地址
 
 @param image 图片对象
 @param progress uploading progress
 @param success upload success block
 @param failure upload failure block
 */
- (void)PUTInOSSWithImage:(UIImage *)image
                 progress:(void (^)(float completed, float total))progress
                  success:(void (^)(NSString *imageURL))success
                  failure:(void (^)(NSError *error))failure;

/**
 上传二进制数据到OSS服务，并获取文件地址
 
 @param binary 二进制数据对象
 @param mimetype mimetype name
 @param filetype 文件后缀名
 @param progress uploading progress
 @param success upload success block
 @param failure upload failure block
 */
- (void)PUTInOSSWithData:(NSData *)binary
                mimetype:(NSString *)mimetype
                filetype:(NSString *)filetype
                progress:(void (^)(float completed, float total))progress
                 success:(void (^)(NSString *dataURL))success
                 failure:(void (^)(NSError *error))failure;


/**
 上传文件到OSS服务，并获取文件地址
 
 @param filepath 文件磁盘路径
 @param mimetype mimetype名
 @param filetype 文件后缀名
 @param progress uploading progress
 @param success upload success block
 @param failure upload failure block
 */
- (void)PUTInOSSWithFilePath:(NSString *)filepath
                    mimetype:(NSString *)mimetype
                    filetype:(NSString *)filetype
                    progress:(void (^)(float completed, float total))progress
                     success:(void (^)(NSString *dataURL))success
                     failure:(void (^)(NSError *error))failure;

@end
