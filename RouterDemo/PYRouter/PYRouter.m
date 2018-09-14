//
//  TMRouter.m
//  MTRouterDemo
//
//  Created by 董徐维 on 2018/2/1.
//  Copyright © 2018年 董徐维. All rights reserved.
//

#import "PYRouter.h"
#import <UIKit/UIKit.h>

//ignore selector unknown warning
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface PYRouter()

/**路由信息数据字典*/
@property(nonatomic,strong) NSMutableDictionary *plistdata;

@end

@implementation PYRouter

+(id)sharedInstance{
    static dispatch_once_t onceToken;
    static PYRouter * router;
    dispatch_once(&onceToken,^{
        router = [[PYRouter alloc] init];
        //解析路由配置文件，生成路由配置字典。plist文件中的 key 就是对应控制器的简称，这个可以自由定义；而value则是对应控制器的类名，这个必须和你创建的controller一致，否则会报错
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RouterData" ofType:@"plist"];
        router.plistdata = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    });
    return router;
}

-(UIViewController *)getViewController:(NSString *)stringVCName
{
    NSString *viewControllerName = [self.plistdata objectForKey:stringVCName];
    Class class = NSClassFromString(viewControllerName);
    UIViewController *controller = [[class alloc] init];
    return controller;
}

-(UIViewController *)getControllerKey:(NSString *)controllerKey withParam:(NSDictionary *)paramdic
{
    UIViewController *controller = [self getViewController:controllerKey];
    if(controller){
        controller = [self controller:controller withParam:paramdic andVCname:controllerKey];
    }else{
        NSLog(@"未找到此类:%@",controllerKey);
        controller = [[PYRouter sharedInstance] getErrorController];
    }
    return controller;
}

/**
 初始化参数（控制器初始化方法 initParameter:想要拿到参数controller必须实现它)
 @param controller 实例化对象
 @param paramdic 实例化参数
 @param vcName 控制器名字
 @return 初始化之后的controller
 */
-(UIViewController *)controller:(UIViewController *)controller withParam:(NSDictionary *)paramdic andVCname:(NSString *)vcName {
    
    SEL selector = NSSelectorFromString(@"initParameter:");
    if(![controller respondsToSelector:selector]){  //如果没定义初始化参数方法，直接返回，没必要在往下做设置参数的方法
        NSLog(@"未定义初始化方法:%@",@"initParameter:");
        return controller;
    }
    //参数为空是方便查询
    if(!paramdic){
        paramdic = [[NSMutableDictionary alloc] init];
        [paramdic setValue:vcName forKey:@"URLKEY"];
        SuppressPerformSelectorLeakWarning([controller performSelector:selector withObject:paramdic]);
    }else{
        [paramdic setValue:vcName forKey:@"URLKEY"];
    }
    //利用 runtime 动态的添加方法 传递参数
    SuppressPerformSelectorLeakWarning( [controller performSelector:selector withObject:paramdic]);
    return controller;
}
//自定义错误页面 此页面一定确保能够找到，否则会进入死循环
-(UIViewController *)getErrorController{
    NSDictionary *dic = [[NSMutableDictionary alloc] init];
    UIViewController *errorController = [[PYRouter sharedInstance] getControllerKey:@"VC1" withParam:dic];
    return errorController;
}


@end
