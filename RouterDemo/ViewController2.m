//
//  ViewController2.m
//  RouterDemo
//
//  Created by gongpengyang on 2018/9/14.
//  Copyright © 2018年 gongpengyang. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 () {
     void (^block1)(NSString *msg);
}

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    lable.text = @"Controller2";
    lable.textColor = [UIColor redColor];
    lable.center = self.view.center;
    [self.view addSubview:lable];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    [button setTitle:@"back(点击反向传值)" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self.view addSubview:button];
}

-(void) back{
    block1(@"我是VC2的数据");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initParameter:(NSDictionary *)dic
{
    self.title = [dic objectForKey:@"title"];
    
    block1 =  [dic objectForKey:@"block"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
