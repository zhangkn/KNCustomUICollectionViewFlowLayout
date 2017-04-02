//
//  KNWaterViewController.m
//  KNCustomUICollectionViewFlowLayout
//
//  Created by devzkn on 02/04/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import "KNWaterViewController.h"
#import "KNWaterFlowLayout.h"
#import "KNShopCollectionViewCell.h"
#import "HMShop.h"
@interface KNWaterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,KNWaterFlowLayoutDelegate>

@property (nonatomic,strong) NSMutableArray *shops;

@property (nonatomic,weak)  UICollectionView *collectionView;

@end

@implementation KNWaterViewController



static NSString *const cellId = @"KNShopCollectionViewCell";//static   防止其他文件访问，const 防止值被修改



#pragma mark - ******** UICollectionViewDataSource

- (CGFloat)waterFlowLayout:(KNWaterFlowLayout *)waterFlowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath   ForItemWidth:(CGFloat)width{
    return [self.shops[indexPath.item] heightForItemWidth:width];
}



- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        KNWaterFlowLayout *waterFlowLayout =[[KNWaterFlowLayout  alloc]init];
        waterFlowLayout.delegate =self;
        
        UICollectionView *tmp = [[UICollectionView alloc]initWithFrame: self.view.bounds collectionViewLayout:waterFlowLayout];
        _collectionView =tmp;
        tmp.delegate = self;
        tmp.dataSource = self;
        //        tmp.collectionViewLayout = [[KNCollectionViewLineFlowLayout alloc]init];
        
        //        tmp.collectionViewLayout = [[KNStackCollectionViewLayout alloc]init];
        
        
        
        [self.view addSubview: _collectionView];
        
    }
    return _collectionView;
}

- (NSMutableArray *)shops{
    
    if (_shops == nil) {
        _shops = [NSMutableArray array];
        
//        for (int i =1; i<21; i++) {
//            [_shops addObject:[NSString stringWithFormat:@"%d",i]];
//        }
        //创建加载模型数据
        
        _shops = [HMShop shops];
        
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect frame = self.view.frame;
//    frame.origin.y =20;
//    self.view.frame = frame;
    // Do any additional setup after loading the view, typically from a nib.
    
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KNShopCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
    
    
}




#pragma mark - ******** UICollectionViewDataSource

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KNShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        //此处永远不会进来
    }
    //模型数据的设置
    cell.shop = self.shops[indexPath.row];
    
    //    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shops.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //改变模型数据，即可改变视图
    
    [self.shops removeObjectAtIndex:indexPath.item];
    //    [self.collectionView reloadData];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    
}


@end
