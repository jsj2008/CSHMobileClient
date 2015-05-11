

@import UIKit;

#import "YALContextMenuCell.h"

@interface ContextMenuCell : UITableViewCell <YALContextMenuCell>

@property (strong, nonatomic) IBOutlet UIImageView *menuImageView;
@property (strong, nonatomic) IBOutlet UILabel *menuTitleLabel;

@end
