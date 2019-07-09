//
//  SRRCollectionViewCell.m
//  ExpandViewForCollection
//
//  Created by 孙瑞瑞 on 2019/7/9.
//  Copyright © 2019 孙瑞瑞. All rights reserved.
//

#import "SRRCollectionViewCell.h"
#import "Masonry.h"

@implementation SRRCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self.contentView addSubview:self.textLB];
        __weak typeof(self) Wself = self;
        [self.textLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(Wself.contentView);
        }];
    }
    return self;
}

-(UILabel *)textLB{
    if (!_textLB) {
        _textLB = [[UILabel alloc]init];
        _textLB.numberOfLines = 0;
        _textLB.textColor = [UIColor whiteColor];
        _textLB.backgroundColor = [self randomColor];
        _textLB.font = [UIFont systemFontOfSize:20];
        _textLB.textAlignment = NSTextAlignmentCenter;
    }
    return _textLB;
}
-(UIColor *)randomColor{
    
    NSInteger aRedValue = arc4random() %255;
    NSInteger aGreenValue = arc4random() %255;
    NSInteger aBlueValue = arc4random() %255;
    UIColor*randColor = [UIColor colorWithRed:aRedValue /255.0f green:aGreenValue /255.0f blue:aBlueValue /255.0f alpha:1.0f];
    return randColor;
    
}


@end
