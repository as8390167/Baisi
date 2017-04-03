//
//  WYPageContentView.m
//  Baisi
//
//  Created by WY on 2017/4/2.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYPageContentView.h"



@interface WYPageContentView()<UICollectionViewDelegate,UICollectionViewDataSource>

/** 子控制器数组 */
@property(nonatomic,strong)NSArray *childVCs;

/** 所有子控制器的父控制器 */
@property(nonatomic,weak)UIViewController *parentVC;

/** 开始偏移X */
@property(nonatomic,assign)CGFloat startOffsetX;

/** flag */
@property(nonatomic,assign)BOOL isForbidScrollDelegate;



/** collectionView */
@property(nonatomic,weak)UICollectionView *collectionView;
@end

static NSString *WYContentCellID = @"ContentCellID";
@implementation WYPageContentView


-(void)parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs
{
    self.parentVC = parentVC;
    self.childVCs = childVCs;
    for (UIViewController *vc in childVCs) {
        [self.parentVC addChildViewController:vc];
    }
    [self.collectionView reloadData];
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.bounces = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:WYContentCellID];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVCs.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WYContentCellID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *childVC = _childVCs[indexPath.item];
    childVC.view.frame = cell.contentView.bounds;
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:childVC.view];
    
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isForbidScrollDelegate = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isForbidScrollDelegate) {
        return ;
    }
    
    CGFloat progress = 0;
    int sourceIndex = 0;
    int targetIndex = 0;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollviewW = scrollView.width;
    if (currentOffsetX > self.startOffsetX) {
        
        progress = (currentOffsetX / scrollviewW) - floor(currentOffsetX / scrollviewW);
        sourceIndex = (int)(currentOffsetX / scrollviewW);
        targetIndex = sourceIndex + 1;
        
        if (targetIndex >= self.childVCs.count) {
            
            targetIndex = (int)self.childVCs.count - 1;
        }
        if (currentOffsetX - self.startOffsetX == scrollviewW) {
            
            progress = 1;
            targetIndex = sourceIndex;
            sourceIndex = targetIndex - 1;
        }
    }else{
        
        progress = 1 - ((currentOffsetX / scrollviewW) - floor(currentOffsetX / scrollviewW));
        targetIndex = (int)(currentOffsetX / scrollviewW);
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= self.childVCs.count - 1) {
            sourceIndex = (int)(self.childVCs.count) - 1;
        }
    }
    if ([_delegate respondsToSelector:@selector(pageContentView:progress:sourceIndex:targetIndex:)]) {
        [_delegate pageContentView:self progress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    }
}

-(void)setCurrentIndex:(int)currentIndex
{
    self.isForbidScrollDelegate = YES;
    CGFloat offsetX = currentIndex * self.collectionView.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}
@end
