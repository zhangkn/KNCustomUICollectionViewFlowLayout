//
//  KNWaterFlowLayout.h
//  KNCustomUICollectionViewFlowLayout
//
//  Created by devzkn on 02/04/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KNWaterFlowLayout;
@protocol KNWaterFlowLayoutDelegate <NSObject>
@required
- (CGFloat )waterFlowLayout:(KNWaterFlowLayout*)waterFlowLayout  heightForItemAtIndexPath:(NSIndexPath *)indexPath    ForItemWidth:(CGFloat)width;

@end

@interface KNWaterFlowLayout : UICollectionViewLayout


/**
 Item 的分组 距离屏幕边缘的间距
 */
@property (nonatomic,assign) UIEdgeInsets sectionInset;

@property (nonatomic,assign) CGFloat columnMargin;
@property (nonatomic,assign) CGFloat rowMargin;

/**
 列数
 */
@property (nonatomic,assign) CGFloat columnCount;
@property (nonatomic,assign) id<KNWaterFlowLayoutDelegate> delegate;








@end
