
//

//

#import <UIKit/UIKit.h>

@interface HMShop : NSObject
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;




+ (NSMutableArray*)shops;
@end
