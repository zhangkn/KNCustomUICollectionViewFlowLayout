
//

#import "HMShop.h"
#import "MJExtension.h"

@implementation HMShop


+(NSMutableArray *)shops{
    
    return  [HMShop objectArrayWithFilename:@"1.plist"];


}

- (CGFloat)heightForItemWidth:(CGFloat)width{
    return (self.h/self.w)*width;
}

@end
