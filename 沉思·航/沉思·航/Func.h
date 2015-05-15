
#import <Foundation/Foundation.h>

@interface Func : NSObject

+ (NSString *)webRequestWith:(NSString *)url and:(NSString*)postInfo;
+ (void)showAlert:(NSString *)str;
+ (void)postRequestWithText:(NSString*)text withID:(NSString*)postid;
@end
