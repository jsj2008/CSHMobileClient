
#import <Foundation/Foundation.h>

@protocol YALContextMenuCell <NSObject>

/*!
 @abstract
 Following methods called for cell when animation to be processed
 */
- (UIView *)animatedIcon;
- (UIView *)animatedContent;

@end
