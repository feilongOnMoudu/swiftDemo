//
//  AFNetwokingUtil.h
//  SwiftUtil
//
//  Created by 宋飞龙 on 17/3/13.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RESPONSEOBJECT)(id responseObject);
typedef void(^ERROR)(NSError *error);

@interface AFNetwokingUtil : NSObject

//get json
+ (void)getJson:(NSString *)url
 withParameters:(NSDictionary *)parameters
        success:(RESPONSEOBJECT)success
        failure:(ERROR)failure;

//post json
+ (void)postJson:(NSString *)url
  withParameters:(NSDictionary *)parameters
         success:(RESPONSEOBJECT)success
         failure:(ERROR)failure;

@end
