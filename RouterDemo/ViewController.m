//
//  ViewController.m
//  RouterDemo
//
//  Created by gongpengyang on 2018/9/14.
//  Copyright © 2018年 gongpengyang. All rights reserved.
//

#import "ViewController.h"
#import "PYRouter.h"

@interface ViewController ()
@property (nonatomic, copy) void (^textBlock)(NSString *msg);
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 50)];
    [button setTitle:@"访问vc1(未定义页面)" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tag = 0;
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 110, 200, 50)];
    [button2 setTitle:@"访问vc2(从后往前传值)" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.tag = 1;
    [button2 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

-(void)back:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:{
            UIViewController *controller = [[PYRouter sharedInstance] getControllerKey:@"FALSEVC"  withParam:nil];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case 1:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            //可以将block加入字典，当做一个回调取值
            self.textBlock = ^(NSString *msg){
                NSLog(@"从VC2中获取的数据是-------%@",msg);
            };
            
            [dic setObject:self.textBlock forKey:@"block"];
            
            UIViewController *controller = [[PYRouter sharedInstance] getControllerKey:@"VC2"  withParam:dic];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
