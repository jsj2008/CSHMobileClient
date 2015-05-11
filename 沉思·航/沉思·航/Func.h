//
//  Func.h
//  NewsReader
//
//  Created by Sean Chain on 2/17/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Func : NSObject

+ (NSString *)webRequestWith:(NSString *)url and:(NSString*)postInfo;
+ (void)showAlert:(NSString *)str;
+(void)postRequestWithText:(NSString*)text withID:(NSString*)postid;

@end
