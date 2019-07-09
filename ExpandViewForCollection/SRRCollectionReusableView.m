//
//  SRRCollectionReusableView.m
//  ExpandViewForCollection
//
//  Created by 孙瑞瑞 on 2019/7/9.
//  Copyright © 2019 孙瑞瑞. All rights reserved.
//

#import "SRRCollectionReusableView.h"
#import "Masonry.h"

#define kCornerRadius 5
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kHouseBtnRedColor [UIColor colorWithRed:246/255.0 green:70/255.0 blue:93/255.0 alpha:1/1.0]
#define kBlueColor [UIColor colorWithRed:103/255.0 green:152/255.0 blue:246/255.0 alpha:1/1.0]


@implementation SRRCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)setLabelTextWithDays:(NSString *)days{
    // 修改富文本中的不同文字的样式
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前已空置%@天",days]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:days].location, [[noteStr string] rangeOfString:days].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    self.vacancyLB.attributedText = noteStr;
}

-(void)registrationBtnAction:(UIButton *)sender{
    if (self.clickRegistrationBtnAction) {
        self.clickRegistrationBtnAction();
    }
}
-(void)detailBtnAction:(UIButton *)sender{
    if (self.clickDetailBtnAction) {
        self.clickDetailBtnAction();
    }
}
-(void)shareBtnAction:(UIButton *)sender{
    if (self.clickShareBtnAction) {
        self.clickShareBtnAction();
    }
}
-(void)createView{
    
    [self addSubview:self.bgImgV];
    [self.bgImgV addSubview:self.registrationBtn];
    [self.bgImgV addSubview:self.detailBtn];
    [self.bgImgV addSubview:self.shareBtn];
    [self.bgImgV addSubview:self.vacancyLB];
    __weak typeof(self) Wself = self;
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Wself).offset(0.02*kScreenWidth);
        make.left.equalTo(Wself).offset(0.03*kScreenWidth);
        make.right.equalTo(Wself).offset(-0.03*kScreenWidth);
        make.bottom.equalTo(Wself);
    }];
    [self.registrationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Wself.bgImgV).offset(0.08*kScreenWidth);
        make.bottom.right.equalTo(Wself.bgImgV).offset(-0.05*kScreenWidth);
        make.width.equalTo(@(0.15*kScreenWidth+60-0.15*kScreenWidth));
    }];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Wself.registrationBtn.mas_left).offset(-0.03*kScreenWidth);
        make.top.bottom.equalTo(Wself.registrationBtn);
        make.width.equalTo(@(0.15*kScreenWidth+60-0.15*kScreenWidth));
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Wself.detailBtn.mas_left).offset(-0.03*kScreenWidth);
        make.top.bottom.equalTo(Wself.registrationBtn);
        make.width.equalTo(@(0.15*kScreenWidth+60-0.15*kScreenWidth));
    }];
    
    [self.vacancyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Wself.registrationBtn);
        make.left.equalTo(Wself.bgImgV).offset(0.05*kScreenWidth);
        make.right.equalTo(Wself.shareBtn.mas_left).offset(-0.03*kScreenWidth);
    }];
    [self.registrationBtn addTarget:self action:@selector(registrationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailBtn addTarget:self action:@selector(detailBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIImageView *)bgImgV{
    if (!_bgImgV) {
        _bgImgV = [[UIImageView alloc]init];
        _bgImgV.userInteractionEnabled = YES;
        _bgImgV.image = [UIImage imageNamed:@"bottomBgImg_LLHouse"];
        //        _bgImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImgV;
}
- (UIButton *)registrationBtn{
    if (!_registrationBtn) {
        _registrationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registrationBtn setTitleColor:kHouseBtnRedColor forState:UIControlStateNormal];
        [_registrationBtn setTitle:@"租客\n登记" forState:UIControlStateNormal];
        _registrationBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _registrationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _registrationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _registrationBtn.layer.borderColor = kHouseBtnRedColor.CGColor;
        _registrationBtn.layer.borderWidth = 1.0;
        _registrationBtn.layer.cornerRadius = kCornerRadius;
        _registrationBtn.layer.masksToBounds = YES;
    }
    return _registrationBtn;
}
-(UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_detailBtn setTitle:@"房源\n详情" forState:UIControlStateNormal];
        _detailBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _detailBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _detailBtn.layer.borderColor = kBlueColor.CGColor;
        _detailBtn.layer.borderWidth = 1.0;
        _detailBtn.layer.cornerRadius = kCornerRadius;
        _detailBtn.layer.masksToBounds = YES;
    }
    return _detailBtn;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_shareBtn setTitle:@"房源\n分享" forState:UIControlStateNormal];
        _shareBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _shareBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _shareBtn.layer.borderColor = kBlueColor.CGColor;
        _shareBtn.layer.borderWidth = 1.0;
        _shareBtn.layer.cornerRadius = kCornerRadius;
        _shareBtn.layer.masksToBounds = YES;
    }
    return _shareBtn;
}
-(UILabel *)vacancyLB{
    if (!_vacancyLB) {
        _vacancyLB = [[UILabel alloc]init];
        _vacancyLB.font = [UIFont systemFontOfSize:16];
        _vacancyLB.numberOfLines = 0;
        _vacancyLB.textColor = [UIColor grayColor];
        
    }
    return _vacancyLB;
}

@end
