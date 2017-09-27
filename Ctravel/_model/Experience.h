//
//  Experience.h
//  Ctravel
//
//  Created by apple on 2017/9/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Experience : NSObject

+ (instancetype)defaultExperience;

/**
 风格
 */
@property (strong, nonatomic) NSString *style;

/**
 城市
 */
@property (strong, nonatomic) NSString *city;

/**
 标题
 */
@property (strong, nonatomic) NSString *title;

/**
 副标题
 */
@property (strong, nonatomic) NSString *subTitle;

/**
 内容描述
 */
@property (strong, nonatomic) NSString *contentDes;

/**
 目的地
 */
@property (strong, nonatomic) NSString *destination;

/**
 备注
 */
@property (strong, nonatomic) NSString *remark;

/**
 须知
 */
@property (strong, nonatomic) NSString *mustKnow;

/**
 要求
 */
@property (strong, nonatomic) NSString *requirement;

/**
 集合地
 */
@property (strong, nonatomic) NSString *rendezvous;

/**
 活动默认时间开始
 */
@property (strong, nonatomic) NSString *defaultTimeStart;


/**
 活动默认时间结束
 */
@property (strong, nonatomic) NSString *defaultTimeEnd;


/**
 图片
 */
@property (strong, nonatomic) NSString *imageUrl;

/**
 价格
 */
@property (assign, nonatomic) float price;

/**
 体验内容明细
 */
@property (strong, nonatomic) NSString *contentDetail;

/**
 人数
 */
@property (assign, nonatomic) NSInteger peopleCount;


/**
 货币类型
 */
@property (strong, nonatomic) NSString *currencyType;

/**
 服务名称
 */
@property (strong, nonatomic) NSString *serviceName;

@end
