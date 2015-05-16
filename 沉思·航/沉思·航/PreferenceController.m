//
//  PreferenceController.m
//  沉思·航
//
//  Created by Sean Chain on 5/14/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "PreferenceController.h"
#import "Func.h"

@implementation PreferenceController

@synthesize indexpath;
@synthesize userid;
@synthesize qq;
@synthesize email;
@synthesize weibo;
@synthesize tel;
@synthesize desc;


- (void)viewDidLoad
{
    userid.enabled = NO;
    email.enabled = NO;
    NSLog(@"%@", indexpath);
    [self getJsonFromWeb];
    
}

- (void)getJsonFromWeb
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *user = [ud valueForKey:@"user"];
    NSString *postinfo = [NSString stringWithFormat:@"user=%@", user];
    NSString *url = [NSString stringWithFormat:@"http://www.chensihang.com/CSHiOS/getMobileJSON.php"];
    id res = [Func webRequestWith:url and:postinfo];
    NSLog(@"%@", res);
    id json = [NSJSONSerialization JSONObjectWithData:[res dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    json = json[0];
    // NSString *email1 = [json objectForKey:@"email"];
    userid.text = user;
    email.text = json[@"email"];
    tel.text = json[@"tel"];
    qq.text = json[@"qq"];
    desc.text = json[@"des"];
    weibo.text = json[@"weibo"];
}

@end
