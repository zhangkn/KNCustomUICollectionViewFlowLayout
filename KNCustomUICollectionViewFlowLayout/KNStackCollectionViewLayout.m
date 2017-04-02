//
//  KNStackCollectionViewLayout.m
//  KNCustomUICollectionViewFlowLayout
//
//  Created by devzkn on 02/04/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import "KNStackCollectionViewLayout.h"

#define KNarc4random_uniform0_1   arc4random_uniform(100)/100.0


@implementation KNStackCollectionViewLayout

static const  CGFloat KNCollectionViewLineFlowLayoutItemSize = 100;



- (CGSize)collectionViewContentSize{
    return CGSizeMake(500, 500);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *collectionViewLayoutAttributesArray = [NSMutableArray array];
    
    NSInteger section = 0;
    NSInteger count = [self.collectionView numberOfItemsInSection:section];
    
    for (int i =0; i<count; i++) {
        //构建UICollectionViewLayoutAttributes
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        UICollectionViewLayoutAttributes *collectionViewLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        //只需显示前5个
        if (i>5) {
            collectionViewLayoutAttributes.hidden = YES;
        }else{
            
            collectionViewLayoutAttributes.size =  CGSizeMake(KNCollectionViewLineFlowLayoutItemSize, KNCollectionViewLineFlowLayoutItemSize);
            
            
            collectionViewLayoutAttributes.center = CGPointMake(self.collectionView.bounds.size.width*0.5, self.collectionView.bounds.size.height*0.5);
            
            // 设置角度
            int direction = (i %2) ? 1: -1;
            
            collectionViewLayoutAttributes.transform = CGAffineTransformMakeRotation(direction *(KNarc4random_uniform0_1*M_PI_4));
        
        
            collectionViewLayoutAttributes.zIndex = count-i;//在z 方向上的位置，越大，月靠前
        
        }
        
        [collectionViewLayoutAttributesArray addObject:collectionViewLayoutAttributes];
        
    }
    
    
    return collectionViewLayoutAttributesArray;
}


@end
