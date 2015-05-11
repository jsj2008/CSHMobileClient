//
//  FirstViewController.h
//  沉思·航
//
//  Created by Sean Chain on 3/9/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBStoreHouseRefreshControl.h"

@class CBStoreHouseRefreshControl;

@interface FirstViewController : UITableViewController

@property (strong, nonatomic) CBStoreHouseRefreshControl *storeHouseRefreshControl;


@end

