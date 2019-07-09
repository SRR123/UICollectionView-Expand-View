//
//  SRRCollectionReusableView.h
//  ExpandViewForCollection
//
//  Created by 孙瑞瑞 on 2019/7/9.
//  Copyright © 2019 孙瑞瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRRCollectionReusableView : UICollectionReusableView

@property(nonatomic,strong) UIImageView *bgImgV;

@property(nonatomic,strong) UIButton *registrationBtn;//登记

@property(nonatomic,strong) UIButton *detailBtn;

@property(nonatomic,strong) UIButton *shareBtn;

@property(nonatomic,strong) UILabel *vacancyLB;

-(void)setLabelTextWithDays:(NSString *)days;

@property(nonatomic,strong) void(^clickRegistrationBtnAction)(void);
@property(nonatomic,strong) void(^clickDetailBtnAction)(void);
@property(nonatomic,strong) void(^clickShareBtnAction)(void);

@end

NS_ASSUME_NONNULL_END
