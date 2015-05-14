//
//  LoginController.m
//  NewsReader
//
//  Created by Sean Chain on 2/17/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "LoginController.h"
#import "Func.h"
#import "FirstViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "VPImageCropperViewController.h"
#import "ZuSimpelColor.h"

@interface LoginController ()
#define ORIGINAL_MAX_WIDTH 640.0f
@property (nonatomic, strong) UIImageView *portraitImageView;


@end

@implementation LoginController


@synthesize idoremail;
@synthesize passwd;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self isValidUser]) {
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    else{
        [passwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
        [self.view addSubview:self.portraitImageView];
        [self loadPortrait];
        self.view.backgroundColor = bgcolor;
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 20)];
        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 18, 18)];
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 20)];
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 18, 18)];
        [imgView1 setImage:[UIImage imageNamed:@"user.png"]];
        [imgView2 setImage:[UIImage imageNamed:@"key.png"]];
        [paddingView1 addSubview:imgView1];
        [paddingView2 addSubview:imgView2];
        self.idoremail.leftView = paddingView1;
        idoremail.leftViewMode = UITextFieldViewModeAlways;
        self.passwd.leftView = paddingView2;
        passwd.leftViewMode = UITextFieldViewModeAlways;
        self.idoremail.borderStyle = UITextBorderStyleNone;
        self.passwd.borderStyle = UITextBorderStyleNone;
        UIView *topBorder = [[UIView alloc]
                             initWithFrame:CGRectMake(10,
                                                      0,
                                                      passwd.frame.size.width - 20,
                                                      1.0f)];
        topBorder.backgroundColor = doubi;
        [passwd addSubview:topBorder];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.isValidUser) {
        [super viewDidAppear:NO];
        sleep(3);
        [self performSegueWithIdentifier:@"tabbar" sender:self];
    }
}



- (void)textFieldDidChange: (UITextField *) TextField{
    NSString *user = idoremail.text;
    NSLog(@"%@", user);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://www.chensihang.com/CSHiOS/pic_val.php" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:[user dataUsingEncoding:NSUTF8StringEncoding] name:@"idoremail"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", response);
        if ([response isEqual:user]) {
            [self getPic:user];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAILURE : %@ --> %@", operation.responseString, error);
    }];
    
    
}

- (void)getPic:(NSString*)response{
    NSString *urlstr = [NSString stringWithFormat:@"http://www.chensihang.com/CSHiOS/portraits/%@.jpg", response];
    NSLog(@"%@", urlstr);
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.portraitImageView.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
}

- (BOOL)isValidUser
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud valueForKey:@"user"]) {
        return YES;
    }
    else
        return NO;
}

- (IBAction)login:(id)sender
{
    NSString *user = idoremail.text;
    NSString *password = passwd.text;
    NSString *url = @"http://www.chensihang.com/CSHiOS/login.php";
    NSString *poststr = [NSString stringWithFormat:@"idoremail=%@&password=%@", user, password];
    NSString *res = [Func webRequestWith:url and:poststr];
    NSLog(@"%@", res);
    if ([res isEqualToString:@"success"]) {
        NSLog(@"Login successfully");
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:user forKey:@"user"];
        [userDefaults setObject:password forKey:@"password"];
        //[userDefaults synchronize];
        [self performSegueWithIdentifier:@"tabbar" sender:self];
    }
    else{
        [Func showAlert:res];
    }
}

- (IBAction)keyboarddown:(id)sender
{
    [self.idoremail resignFirstResponder];
    [self.passwd resignFirstResponder];
}


- (IBAction)loginIssue:(id)sender
{
    //这个功能未来完成
    NSLog(@"problem login");
}

- (void)loadPortrait {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        UIImage *protraitImg = [UIImage imageNamed:@"portrait.jpg"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.portraitImageView.image = protraitImg;
        });
    });
}


#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 90.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 8;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _portraitImageView.layer.shadowOpacity = 0.5;
        _portraitImageView.layer.shadowRadius = 2.0;
        _portraitImageView.layer.borderWidth = 0;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor blackColor];
    }
    return _portraitImageView;
}


@end
