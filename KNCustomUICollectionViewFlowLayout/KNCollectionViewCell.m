//
//  KNCollectionViewCell.m
//  KNCustomUICollectionViewFlowLayout
//
//  Created by devzkn on 25/03/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import "KNCollectionViewCell.h"


@interface KNCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

@implementation KNCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.borderWidth = 2;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 3;
    self.imageView.clipsToBounds = YES;


    
    
    
}

- (void)setImageName:(NSString *)imageName{
    _imageName = [NSString stringWithFormat:@"%@.jpg",[imageName copy]];
    [self.imageView setImage:[UIImage imageNamed:self.imageName]];
}

@end
