//
//  PreferenceController.h
//  沉思·航
//
//  Created by Sean Chain on 5/14/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferenceController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userid;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *qq;
@property (weak, nonatomic) IBOutlet UITextField *weibo;
@property (weak, nonatomic) IBOutlet UITextView *desc;

@property (nonatomic, strong) id indexpath;
@end
