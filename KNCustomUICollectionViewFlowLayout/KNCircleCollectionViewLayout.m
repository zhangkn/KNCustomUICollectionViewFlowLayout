//
//  KNCircleCollectionViewLayout.m
//  KNCustomUICollectionViewFlowLayout
//
//  Created by devzkn on 02/04/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import "KNCircleCollectionViewLayout.h"



/**
 环形不绝
 */
@implementation KNCircleCollectionViewLayout



static const  CGFloat KNCollectionViewLineFlowLayoutItemSize = 50;


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'no UICollectionViewLayoutAttributes instance for -layoutAttributesForItemAtIndexPath: <NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}' *** First throw call
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self setUpLayoutAttributesForItemAtIndexPath:indexPath];
}

/**
 
 cell \head\foot
 
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *collectionViewLayoutAttributesArray = [NSMutableArray array];
    
    NSInteger section = 0;
    NSInteger count = [self.collectionView numberOfItemsInSection:section];
    for (int i =0; i<count; i++) {
        //构建UICollectionViewLayoutAttributes
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        UICollectionViewLayoutAttributes *collectionViewLayoutAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [collectionViewLayoutAttributesArray addObject:collectionViewLayoutAttributes];
        
    }
    
    
    return collectionViewLayoutAttributesArray;
}


#pragma mark - ********  构建 indexPath 对应的 UICollectionViewLayoutAttributes  

/**
 所有图片的中心点都在圆弧上
 //1. 计算圆心center的中心点
 //2. 知道item 的center 距离圆心的center的角度，即可计算item 的center
 
 */
- (UICollectionViewLayoutAttributes *)setUpLayoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *collectionViewLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
   
    collectionViewLayoutAttributes.size =  CGSizeMake(KNCollectionViewLineFlowLayoutItemSize, KNCollectionViewLineFlowLayoutItemSize);
    //计算Item的center  根据角度计算
    NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
    //1. 每个Item之间的角度
    CGFloat directionAngle = M_PI*2/count;
    
    //2. 计算当前Item的角度
    CGFloat itemAngle =directionAngle *indexPath.item;
    
    
    
    collectionViewLayoutAttributes.center =[self setupItemCenterWithItemAngle:itemAngle];
    return collectionViewLayoutAttributes;
}

- (CGPoint) setupItemCenterWithItemAngle:(CGFloat)itemAngle{
    CGFloat radious = 100;//半径
    CGPoint center = CGPointMake(self.collectionView.bounds.size.width*0.5, self.collectionView.bounds.size.height*0.5);//中心点
    return CGPointMake(center.x + radious*cosf(itemAngle) , center.y- radious*sinf(itemAngle));;
    
}


@end
