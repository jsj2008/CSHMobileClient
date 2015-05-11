
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NJWeibo;
@interface JHWeiboFrame : NSObject

/**
 *  头像的frame
 */
@property (nonatomic, assign) CGRect iconF;
/**
 *  昵称的frame
 */
@property (nonatomic, assign) CGRect nameF;
/**
 *  vip的frame
 */
@property (nonatomic, assign) CGRect vipF;
/**
 *  正文的frame
 */
@property (nonatomic, assign) CGRect introF;
/**
 *  配图的frame
 */
@property (nonatomic, assign) CGRect pictrueF;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect titleF;

/**
 *  模型数据
 */
@property (nonatomic, strong) NJWeibo *weibo;

@end
