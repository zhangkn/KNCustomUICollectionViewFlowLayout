//
//  ViewController.m
//  KNCustomUICollectionViewFlowLayout
//
//  Created by devzkn on 25/03/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import "ViewController.h"
#import "KNCollectionViewCell.h"

#import "KNCollectionViewLineFlowLayout.h"
#import "KNStackCollectionViewLayout.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *images;

@property (nonatomic,weak)  UICollectionView *collectionView;



@end

@implementation ViewController

//
//- (instancetype)init
//{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];//2017-01-03 17:11:29.702 DKMeituanHD[2329:230000] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'UICollectionView must be initialized with a non-nil layout parameter'
//    
//    //设置cell大小
//    
//    [layout setItemSize:CGSizeMake(DKDealCellSize, DKDealCellSize)];
//    //设置分组上下左右的内边距
//    CGFloat inset = 15;
//    [layout setSectionInset:UIEdgeInsetsMake(inset, inset, inset, inset)];//The margins used to lay out content in a section
//    //设置cell间的间距（根据横竖屏进行适配）
//    
//    self = [super initWithCollectionViewLayout:layout];
//    if (self) {
//    }
//    return self;
//}

static NSString *const cellId = @"KNCollectionViewCell";//static   防止其他文件访问，const 防止值被修改


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[KNStackCollectionViewLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init] animated:YES];

        
    }else{
//        [self.collectionView setCollectionViewLayout:[[KNCollectionViewLineFlowLayout alloc]init] animated:YES];
        [self.collectionView setCollectionViewLayout:[[KNStackCollectionViewLayout alloc]init] animated:YES];

    }
}


- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {

        UICollectionView *tmp = [[UICollectionView alloc]initWithFrame: CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:[[KNStackCollectionViewLayout alloc]init]];
        _collectionView =tmp;
        tmp.delegate = self;
        tmp.dataSource = self;
//        tmp.collectionViewLayout = [[KNCollectionViewLineFlowLayout alloc]init];
        
//        tmp.collectionViewLayout = [[KNStackCollectionViewLayout alloc]init];

        
        
        [self.view addSubview: _collectionView];

    }
    return _collectionView;
}

- (NSMutableArray *)images{
    
    if (_images == nil) {
        _images = [NSMutableArray array];
        
        for (int i =1; i<21; i++) {
            [_images addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KNCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
    
    
    
    
}




#pragma mark - ******** UICollectionViewDataSource

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KNCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        //此处永远不会进来
    }
    cell.imageName = self.images[indexPath.row];
//    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //改变模型数据，即可改变视图
    
    [self.images removeObjectAtIndex:indexPath.item];
//    [self.collectionView reloadData];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    
}





@end
