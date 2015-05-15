//
//  SecondViewController.m
//  沉思·航
//
//  Created by Sean Chain on 3/9/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "SecondViewController.h"
#import "ZuSimpelColor.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *tintColor = [NSKeyedArchiver archivedDataWithRootObject:maroon];
    [ud setValue:tintColor forKey:@"scheme"];
    NSLog(@"%@", [NSKeyedUnarchiver unarchiveObjectWithData:[ud valueForKey:@"scheme"]]);
}
@end
