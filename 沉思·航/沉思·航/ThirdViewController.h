//
//  ThirdViewController.h
//  沉思·航
//
//  Created by Sean Chain on 3/10/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *idoremail;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)queryScore:(id)sender;

@end
