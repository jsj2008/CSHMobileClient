//
//  FirstViewController.m
//  沉思·航
//
//  Created by Sean Chain on 3/9/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize webview;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebPageWithString:@"http://www.chensihang.com/blog"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeCall)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeLeft.delegate = self;
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webview addGestureRecognizer:swipeLeft];
    [webview loadRequest:request];
}

- (void)leftSwipeCall
{
    NSURL *url =[NSURL URLWithString:@"http://www.chensihang.com/blog"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
}

@end
