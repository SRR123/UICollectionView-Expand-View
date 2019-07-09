//
//  ViewController.m
//  ExpandViewForCollection
//
//  Created by 孙瑞瑞 on 2019/7/9.
//  Copyright © 2019 孙瑞瑞. All rights reserved.
//

#import "ViewController.h"
#import "SRRCollectionReusableView.h"
#import "SRRCollectionViewCell.h"
#import "Masonry.h"

#define kItem_Number 3
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kViewBgColor  [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1/1.0]

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collection;

@property(nonatomic,strong) NSMutableArray *dataSource;

@property(nonatomic,strong) NSIndexPath *selectIndex;

@property(nonatomic,assign) BOOL isSelect;//是否是展开状态

@property(nonatomic,strong) NSMutableArray *sectionAry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isSelect = NO;
    self.dataSource = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    [self.view addSubview:self.collection];
    __weak typeof(self) Wself = self;
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(Wself.view);
    }];
}
-(void)footerBtnClickActionWithFooterView:(SRRCollectionReusableView *)footerView{
    __weak typeof(self) Wself = self;
    
    footerView.clickShareBtnAction = ^{
        [Wself alertCellClickActionWithTitle:@"点击了房源分享"];
    };
    footerView.clickDetailBtnAction = ^{
         [Wself alertCellClickActionWithTitle:@"点击了房源详情"];
    };
    footerView.clickRegistrationBtnAction = ^{
          [Wself alertCellClickActionWithTitle:@"点击了租客登记"];
    };
}
-(void)alertCellClickActionWithTitle:(NSString *)title{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ %ld",title,self.selectIndex.row + self.selectIndex.section * kItem_Number] message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *submit_action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alert addAction:submit_action];
    [self presentViewController:alert animated:true completion:nil];
}
#define CollectionItemEdgeInsets UIEdgeInsetsMake(3, 3, 3, 3)
#define CollectionInsetForSection UIEdgeInsetsMake(5, 5, 0, 5)

#pragma mark - 视图内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeViewCollectionViewHeader" forIndexPath:indexPath];
        
        return headerView;
        
    }else if (kind == UICollectionElementKindSectionFooter) {
        // 底部试图
        SRRCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeViewCollectionViewFooter" forIndexPath:indexPath];
        footerView.backgroundColor = kViewBgColor;
        if (self.isSelect) {
            if (self.selectIndex.row == 0) {
                footerView.bgImgV.image = [UIImage imageNamed:@"bottomBgLeftImg_LLHouse"];
            }else if(self.selectIndex.row == 1) {
                footerView.bgImgV.image = [UIImage imageNamed:@"bottomBgImg_LLHouse"];
            }else{
                footerView.bgImgV.image = [UIImage imageNamed:@"bottomBgRightImg_LLHouse"];
            }
        }
        [self footerBtnClickActionWithFooterView:footerView];
        //         footerView.clipsToBounds = YES;
        [footerView setLabelTextWithDays:@"10"];
        
        return footerView;
    }else {
        return nil;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //这里要知道如果返回数是8, 分区下标就是0 ~~ 7
    
    //如果能整除, 就返回正常结果
    if (self.dataSource.count % kItem_Number == 0) {
        return self.dataSource.count / kItem_Number;
    }
    //如果不能整除就在结果上加1, 例如25个数据, 每行3个, 则需要25 / 3 + 1行
    return self.dataSource.count / kItem_Number + 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //如果数组中有元素的时候走下面方法
    if (self.dataSource.count > 0) {
        
        //找到最后一个分区
        if (section == self.dataSource.count / kItem_Number) {
            
            //如果能被每行的个数整除
            if (self.dataSource.count % kItem_Number == 0) {
                //返回每行的个数
                return kItem_Number;
            }
            
            //不然返回元素个数对每行个数的取余数
            return self.dataSource.count % kItem_Number;
        }
        
//        NSLog(@"%ld####%ld", self.dataSource.count / kItem_Number, self.dataSource.count % kItem_Number);
        
        //其他情况返回正常的个数
        return kItem_Number;
    }
    
    //这个没啥用, 代码只有第一次, 数据未加载出来的时候走这个
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SRRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCellID" forIndexPath:indexPath];
    cell.textLB.text = [NSString stringWithFormat:@"%ld",indexPath.row + indexPath.section * kItem_Number];
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    self.selectIndex = indexPath;
    [self JudgeSelected:indexPath];
    
    [self.collection reloadData];
}
#pragma mark - UICollectionViewDelegate 选中执行

- (void)JudgeSelected:(NSIndexPath *)indexPath
{
    
    //始终保持数组中只有一个元素或则无元素
    if (self.sectionAry.count > 1)
    {
        [self.sectionAry removeObjectAtIndex:0];
    }
    
    //如果这此点击的元素存在于数组中则状态置为NO,并将此元素移除数组
    /*
     这里之所以置为NO的时候把元素移除是因为, 如果不移除, 下次点击的时候代码走到这里里面还是有一个元素, 而且是上次的元素, 不会走else的代码
     */
    if ([self.sectionAry containsObject:indexPath])
    {
        self.isSelect = NO;
        [self.sectionAry removeObject:indexPath];
    }else{
        //当数组为空的时候或者点击的非上次元素的时候走这里
        self.isSelect = YES;
        [self.sectionAry addObject:indexPath];
    }
}
//动态设置区尾的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.sectionAry.count == 0 || self.isSelect == NO) {
        
        return CGSizeMake(0, 0);
    }
    if (section == self.selectIndex.section) {
        
        return CGSizeMake(kScreenWidth, 0.15*kScreenWidth+60);
    }else{
        return CGSizeMake(0, 0);
    }
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 40);
    }else{
        return CGSizeMake(0, 0);
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float widthCell = kScreenWidth - CollectionInsetForSection.left * 2 - CollectionItemEdgeInsets.left * 4;
    return CGSizeMake(widthCell / 3.0, widthCell / 3.0);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return CollectionInsetForSection;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CollectionItemEdgeInsets.top;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CollectionItemEdgeInsets.right;
}


- (UICollectionView *)collection
{
    //  设置 layOut
    if (!_collection) {
        //  设置 layOut
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;  //滚动方向
        _collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.alwaysBounceVertical = true;// 竖直弹性
        [_collection registerClass:[SRRCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCellID"];
        _collection.backgroundColor = [UIColor whiteColor];
        
        //设置headerView大小
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 50);
        //设置footerView大小
        layout.footerReferenceSize = CGSizeMake(kScreenWidth, 120);
        [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeViewCollectionViewHeader"];
        [_collection registerClass:[SRRCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeViewCollectionViewFooter"];
        
    }
    return _collection;
}

- (NSMutableArray *)sectionAry
{
    
    if (!_sectionAry) {
        self.sectionAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _sectionAry;
}

@end
