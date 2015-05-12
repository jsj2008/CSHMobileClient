//
//  ThirdViewController.m
//  沉思·航
//
//  Created by Sean Chain on 3/10/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "ThirdViewController.h"
#import "ZuSimpelColor.h"
#import "ASFTableView.h"
#import "ScoreController.h"
#import "Func.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

@synthesize idoremail;
@synthesize password;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 20)];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 20)];
    self.idoremail.leftView = paddingView1;
    idoremail.leftViewMode = UITextFieldViewModeAlways;
    self.password.leftView = paddingView2;
    password.leftViewMode = UITextFieldViewModeAlways;
    self.idoremail.borderStyle = UITextBorderStyleNone;
    self.password.borderStyle = UITextBorderStyleNone;
    UIView *topBorder = [[UIView alloc]
                         initWithFrame:CGRectMake(10,
                                                  0,
                                                  password.frame.size.width - 20,
                                                  1.0f)];
    topBorder.backgroundColor = doubi;
    [password addSubview:topBorder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ScoreController *sc = [segue destinationViewController];
    [sc setValue:[self getScoreJson] forKey:@"json"];
}


- (id)getScoreJson{
    NSString *zjh = idoremail.text;
    NSString *mm = password.text;
    NSString *info = @"allsem";
    NSString *urlstr = [NSString stringWithFormat:@"http://www.chensihang.com/iostest/iosjwc.php?zjh=%@&mm=%@&scorechecktype=%@", zjh, mm, info];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSString *response = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    response = [response stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@", response);
    if ([response isEqualToString:@"fail"]) {
        //此时用户输入的用户名和密码并不正确。
        [Func showAlert:@"密码输入错误，请重试！"];
    }
    NSData *jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    return jsonObject;
}
@end
