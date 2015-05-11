
#import "DetailController.h"

@interface DetailController (ENPopUp)

@property (nonatomic, retain) UIViewController *en_popupViewController;
- (void)presentPopUpViewController:(UIViewController *)popupViewController with:(NSString*)postid;
- (void)presentPopUpViewController:(UIViewController *)popupViewController completion:(void (^)(void))completionBlock;
- (void)dismissPopUpViewController;
- (void)dismissPopUpViewControllerWithcompletion:(void (^)(void))completionBlock;

@end
