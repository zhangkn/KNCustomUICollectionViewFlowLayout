//
//  KNWaterFlowLayout.m
//  KNCustomUICollectionViewFlowLayout
//
//  Created by devzkn on 02/04/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import "KNWaterFlowLayout.h"


@interface KNWaterFlowLayout ()


/**
 存储每一列的最大Y值，即高度
 */
@property (nonatomic,strong) NSMutableDictionary *maxYDic;

@property (nonatomic,strong) NSMutableArray *collectionViewLayoutAttributesArray;



@end

/**
 瀑布流：
 列间距固定
 Item 高度不一样
 从高度小的Item  开始排列
 */
@implementation KNWaterFlowLayout


//static const  CGFloat KNColumnMargin = 10;
//static const  CGFloat KNRowMargin = KNColumnMargin ;



- (NSMutableArray *)collectionViewLayoutAttributesArray{
    if (_collectionViewLayoutAttributesArray == nil) {
        _collectionViewLayoutAttributesArray = [NSMutableArray array];
        
    }
    return _collectionViewLayoutAttributesArray;
}

- (NSMutableDictionary *)maxYDic{
    if (_maxYDic == nil) {
        _maxYDic = [NSMutableDictionary dictionary];
        
    }
    return _maxYDic;
}

- (void)setColumnCount:(CGFloat)columnCount{
    _columnCount = columnCount;
    
    //额外的操作
    //初始化MaxYDic
    [self setupmaxYDicWithcolumnCount:columnCount];
}

- (void) setupmaxYDicWithcolumnCount:(CGFloat) columnCount{
    
    for (int i = 0; i<columnCount; i++) {
        [self.maxYDic setObject:[NSNumber numberWithFloat:self.sectionInset.top] forKey:[NSString stringWithFormat:@"%d",i ]];
    }

    
}

- (instancetype)init{
    if (self =[super init]) {
        
        self.rowMargin = 10;
        self.columnMargin = self.rowMargin;
        //设置默认值
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnCount = 3;
    }
    return self;
}

/**
 重新布局
 */
- (void)prepareLayout{
    [super prepareLayout];

//清空旧Item 的UICollectionViewLayoutAttributes
    [self.collectionViewLayoutAttributesArray removeAllObjects];
    self.collectionViewLayoutAttributesArray = [self setuplayoutAttributesForElements];
  
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'no UICollectionViewLayoutAttributes instance for -layoutAttributesForItemAtIndexPath: <NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}' *** First throw call
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self setUpLayoutAttributesForItemAtIndexPath:indexPath];
}



- (CGSize)collectionViewContentSize{
    return CGSizeMake(0, [self maxHeightInColumn]+self.sectionInset.bottom);
}

/**
 
 cell \head\foot
 
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.collectionViewLayoutAttributesArray;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)setuplayoutAttributesForElements{
    [self setupmaxYDicWithcolumnCount:self.columnCount];//初始化存储最大高度的字典
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
    
    //0. 计算最短的列数
    NSString *minColumn = [self minHeightColumn];
    
    //计算Item 的宽度
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right- ((self.columnCount-1)*self.columnMargin))/self.columnCount;//这个值可抽取
    
    
    //计算Item的高度
    //需要根据模型的宽高比
    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(waterFlowLayout:heightForItemAtIndexPath:ForItemWidth:)]) {
       height= [self.delegate waterFlowLayout:self heightForItemAtIndexPath:indexPath ForItemWidth:width];
    }
    
    
    CGFloat y =  [self.maxYDic[minColumn] floatValue] + self.rowMargin;
    CGFloat x = ([minColumn intValue])*(width+self.columnMargin)+ self.sectionInset.left;
    CGRect ItemRect = CGRectMake(x, y, width, height);
    
    //更新self maxYDic  中对应列数的 对应的高度
    self.maxYDic[minColumn] = [NSNumber numberWithFloat:CGRectGetMaxY(ItemRect)];
    
    
    
    
    
    
    UICollectionViewLayoutAttributes *collectionViewLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
//    collectionViewLayoutAttributes.size = ItemRect.size;
    collectionViewLayoutAttributes.frame =ItemRect;
    
    
 
    

    return collectionViewLayoutAttributes;
}


- (NSString*) minHeightColumn{
    __block NSString *minColumn = @"0";//默认第一列的高度最小
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSString  *keyColumn, NSNumber *objHeight, BOOL * _Nonnull stop) {
        
        if (objHeight.floatValue < [self.maxYDic[minColumn] floatValue]) {
            minColumn  = keyColumn;
        }
        
    }];
    return minColumn;
}

- (CGFloat) maxHeightInColumn{
    __block CGFloat maxHeight =0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSString  *keyColumn, NSNumber *objHeight, BOOL * _Nonnull stop) {
        
        if (objHeight.floatValue > maxHeight) {
            maxHeight  = objHeight.floatValue;
        }
        
    }];
    
    return maxHeight;
}



@end
