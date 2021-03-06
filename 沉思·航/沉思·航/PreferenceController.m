//
//  PreferenceController.m
//  沉思·航
//
//  Created by Sean Chain on 5/14/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "PreferenceController.h"
#import "Func.h"
#import "AFHTTPRequestOperationManager.h"

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

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    NSLog(@"back to parent controller");
    [self saveValueToDB];
}

- (void)saveValueToDB
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"id":userid.text, @"tel":tel.text, @"qq":qq.text, @"weibo":weibo.text, @"des":desc.text};
    [manager POST:@"http://chensihang.com/usermanagement/infoupdate.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}



@end
