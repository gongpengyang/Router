//
//  TMRouter.h
//  MTRouterDemo
//
//  Created by 董徐维 on 2018/2/1.
//  Copyright © 2018年 董徐维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PYRouter : NSObject

+(id)sharedInstance;

/**
 获取控制器
 @param controllerKey 控制器对应的字典中对应的key
 @return 返回控制器实例
 */
-(UIViewController *)getViewController:(NSString *)controllerKey;

/**
 返回一个初始化参数之后的控制器
 @param controllerKey 控制器名字
 @param paramdic 初始化参数
 @return 控制器实例
 */
-(UIViewController *)getControllerKey:(NSString *)controllerKey withParam:(NSDictionary *)paramdic;
@end
