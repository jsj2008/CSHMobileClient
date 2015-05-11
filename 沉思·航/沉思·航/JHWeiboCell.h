
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class JHWeiboFrame;

@interface JHWeiboCell : UITableViewCell

/** 接受外界传入的模型 */
//@property (strong , nonatomic) NJWeibo *weibo;

@property (strong , nonatomic) JHWeiboFrame *weiboFrame;

+(instancetype) cellWithTableView:(UITableView *)tableView;

@end
