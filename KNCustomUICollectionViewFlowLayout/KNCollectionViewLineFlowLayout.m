//
//  KNCollectionViewLineFlowLayout.m
//  KNCustomUICollectionViewFlowLayout
//
//  Created by devzkn on 25/03/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import "KNCollectionViewLineFlowLayout.h"

@implementation KNCollectionViewLineFlowLayout

static const  CGFloat KNCollectionViewLineFlowLayoutItemSize = 100;



/**
 核心思想： item的size 与距离中间的距离成正比
 重点：  UICollectionViewLayoutAttributes   布局属性类
 1、 每一个cell（item） 都有着自己的UICollectionViewLayoutAttributes
 即  每一个indexPath（cell） 都有着自己的UICollectionViewLayoutAttributes
 

 @return <#return value description#>
 */
- (instancetype)init{
    
    if (self = [super init]) {
        //初始化
//        setSectionInset
//        setItemSize
        
        
        self.itemSize = CGSizeMake(KNCollectionViewLineFlowLayoutItemSize, KNCollectionViewLineFlowLayoutItemSize);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置水平方向进行滚动
//        UICollectionViewLayoutAttributes
        self.minimumLineSpacing = KNCollectionViewLineFlowLayoutItemSize;//设置行间距，或者列间距-》UICollectionViewScrollDirectionHorizontal
        
        
        
    }
    
    return self;
}



#pragma mark - ******** 设置子控件的frame
// The collection view calls -prepareLayout once at its first layout as the first message to the layout instance.
// The collection view calls -prepareLayout again after layout is invalidated and before requerying the layout information.
/** layout 最好在此初始化item的布局*/
- (void)prepareLayout{
    [super prepareLayout];// Subclasses should always call super if they override.
    //设置第一个和最后一个item的位置居中
    CGFloat sectionInsetWH = (self.collectionView.frame.size.width-KNCollectionViewLineFlowLayoutItemSize)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, sectionInsetWH, 0, sectionInsetWH);
    

    
}




#pragma mark - ******** 设置item 的UICollectionViewLayoutAttributes


/**
 return YES to cause the collection view to requery the layout for geometry information
 @return return value description
 
 当显示的界面的边届改变时，就调用此方法，来决定是否重新布局
 内部会重新调用layoutAttributesForElementsInRect 方法获取所有的cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;//以便时时调用- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect; // return an array layout attributes instances for all the views in the given rect  进行获取item的UICollectionViewLayoutAttributes

}



/**
 return an array layout attributes instances for all the views in the given rect


 @return return value description
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    
    
//    1.return nil;//通过返回能看得见的cell的UICollectionViewLayoutAttributes，以便节省内存
//    2。  技巧二：  利用父类创建好的UICollectionViewLayoutAttributes  ，在其基础上进行修改
//    NSArray *array=   [super layoutAttributesForElementsInRect:rect];//KNCustomUICollectionViewFlowLayout[2275:574417] This is likely occurring because the flow layout subclass KNCollectionViewLineFlowLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
    NSArray *array=   [[super layoutAttributesForElementsInRect:rect] copy];//KNCustomUICollectionViewFlowLayout[2275:574417] This is likely occurring because the flow layout subclass KNCollectionViewLineFlowLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
    //1. 计算屏幕最中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width*0.5;
    
    //2。 计算可见的矩形框
    CGRect visibleRect;
    visibleRect.size = self.collectionView.frame.size;
    visibleRect.origin.x = self.collectionView.contentOffset.x;
    visibleRect.origin.y =self.collectionView.frame.origin.y;
//    visibleRect.origin = self.collectionView.contentOffset;
    
//    NSLog(@"%@",NSStringFromCGRect(visibleRect));
    for (UICollectionViewLayoutAttributes *obj in array) {
        
        // 1)  如果不是可见的，就不进行比例处理
//        if (ABS(obj.center.x-centerX) > self.collectionView.frame.size.width*0.5) {
////            obj.transform3D = CATransform3DMakeScale(1, 1, 1);
//
//            continue;
//        }
        if (!CGRectIntersectsRect(visibleRect, obj.frame)) {//不相交的时候,rect
//            The rectangle (specified in the collection view’s coordinate system) containing the target views.
            continue;
        }
        
        
//        if ( obj.center.x < (centerX+ KNCollectionViewLineFlowLayoutItemSize*0.5) &&  obj.center.x >  (centerX- KNCollectionViewLineFlowLayoutItemSize*0.5)) {
//            obj.transform3D = CATransform3DMakeScale(1.5, 1.5, 1);
//            
//        }
        
        
//        if ( ABS(centerX - obj.center.x) <KNCollectionViewLineFlowLayoutItemSize){
//            obj.transform3D = CATransform3DMakeScale(1.5, 1.5, 1);
//            
//        }
        //2.  差距越大缩放比例越小 即scale 越接近于1
        CGFloat  scale =  1+ 1 - ABS(centerX - obj.center.x)/(self.collectionView.frame.size.width*0.5);// 保证1 - ABS(centerX - obj.center.x)/(self.collectionView.frame.size.width*0.5) 小于1
        obj.transform3D = CATransform3DMakeScale(scale, scale, 1);
        
        
    }
    return array;
    
    
}


@end
