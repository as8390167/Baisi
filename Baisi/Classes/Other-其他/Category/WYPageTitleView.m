//
//  WYPageTitleView.m
//  Baisi
//
//  Created by WY on 2017/4/2.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYPageTitleView.h"

@interface WYPageTitleView()

/** scrollView */
@property(nonatomic,weak)UIScrollView *scrollView;

/** 标题label数组 */
@property(nonatomic,strong)NSMutableArray<UILabel *> *titleLabels;

/** 当前标题索引 */
@property(nonatomic,assign)int currentIndex;

/** 标题下方线 */
@property(nonatomic,weak)UIView *scrollLine;

@end

@implementation WYPageTitleView

-(NSMutableArray<UILabel *> *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

-(UIColor *)selectTitleColor{
    if (!_selectTitleColor) {
        return [UIColor redColor];
    }
    return _selectTitleColor;
}

-(UIColor *)textColor{
    if (!_textColor) {
        return [UIColor darkGrayColor];
    }
    return _textColor;
}

-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.bounces = NO;
        scrollView.alwaysBounceHorizontal = YES;
        scrollView.frame = self.bounds;
        scrollView.contentSize = CGSizeMake(self.width, 0);
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(UIView *)scrollLine
{
    if (!_scrollLine) {
        UIView *scrollLine = [[UIView alloc] init];
        
        scrollLine.backgroundColor = self.selectTitleColor;
        [self.scrollView addSubview:scrollLine];
        _scrollLine = scrollLine;
    }
    return _scrollLine;
}

-(UIFont *)titleFont{
    if (!_titleFont) {
        return [UIFont systemFontOfSize:16.0];
    }
    return _titleFont;
}

-(void)setTitles:(NSArray<NSString *> *)titles
{
    _titles = titles;
    
    [self setupTitleLabel];
    
    [self setupBottomMenuAndScrollLine];
}

-(void)setupTitleLabel
{
    CGFloat labelH = self.height - 2;
    CGFloat labelW = 0;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat totalWidth = 0;
    for (int i = 0; i < self.titles.count; i ++) {
        
        NSString *title = self.titles[i];
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.tag = i;
        label.font =  [UIFont systemFontOfSize:16];
        label.textColor = self.textColor;
        label.textAlignment = NSTextAlignmentCenter;
        if ([self isAvgWidth:title]) {
            labelW = self.width / self.titles.count;
        }else{
            CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : self.titleFont}];
            labelW = titleSize.width + 2 * 10;
        }
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        labelX += labelW;
        
        [self.scrollView addSubview:label];
        [self.titleLabels addObject:label];
        
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:gesture];
        totalWidth += labelW;
    }
    
    self.scrollView.contentSize = CGSizeMake(totalWidth, 0);
}

-(void)setupBottomMenuAndScrollLine
{
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    CGFloat lineH = 0.5;
    bottomLine.frame = CGRectMake(0, self.height - lineH, self.width, lineH);
    [self addSubview:bottomLine];
    
    if (self.titleLabels.count == 0) {
        return;
    }
    UILabel *firstLabel = [self.titleLabels firstObject];
    firstLabel.textColor = self.selectTitleColor;
    self.scrollLine.frame = CGRectMake(0, self.scrollLine.y = self.height - 2, [self getLabelTextWidth:firstLabel], 2);
    self.scrollLine.centerX = firstLabel.centerX;
}

-(BOOL)isAvgWidth:(NSString *)title
{
    CGFloat avgLabelW = self.width / self.titles.count;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : self.titleFont}];
    CGFloat labelW = titleSize.width + 2 * 10;
    if (avgLabelW > labelW) {
        return true;
    }else{
        return false;
    }
}


-(void)titleLabelClick:(UITapGestureRecognizer *)tapGes
{
    
    if (![tapGes.view isKindOfClass:[UILabel class]]) {
        return;
    }
    UILabel *currentLabel = (UILabel *)tapGes.view;
    if (self.currentIndex == currentLabel.tag) {
        return;
    }
    UILabel *preLabel = self.titleLabels[self.currentIndex];
    preLabel.textColor = self.textColor;
    currentLabel.textColor = self.selectTitleColor;
    
    self.currentIndex = (int)currentLabel.tag;
    //CGFloat scrollLineX = currentLabel.x;
    [UIView animateWithDuration:0.25 animations:^{
        //self.scrollLine.x = scrollLineX;
        self.scrollLine.width = [self getLabelTextWidth:currentLabel]; //currentLabel.width;
        self.scrollLine.centerX = currentLabel.centerX;
    }];
    
    CGFloat offsetX = currentLabel.centerX - self.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.width;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    if ([_delegate respondsToSelector:@selector(pageTitleView:selectIndex:)]) {
        [_delegate pageTitleView:self selectIndex:_currentIndex];
    }
}

-(void)setTitleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex
{
    UILabel *sourceLabel = self.titleLabels[sourceIndex];
    UILabel *targetLabel = self.titleLabels[targetIndex];
    if (progress == 1.0) {
        sourceLabel.textColor = self.textColor;
        targetLabel.textColor = self.selectTitleColor;
    }else{
        return;
    }
    //CGFloat moveTotalX = targetLabel.x - sourceLabel.x;
    //CGFloat moveX = moveTotalX * progress;
    //self.scrollLine.x = sourceLabel.x + moveX;
    [UIView animateWithDuration:0.25 animations:^{
        //self.scrollLine.x = scrollLineX;
        self.scrollLine.centerX = targetLabel.centerX; //targetLabel.width;
        self.scrollLine.width = [self getLabelTextWidth:targetLabel];
    }];
    
    CGFloat offsetX = targetLabel.centerX - self.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.width;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    self.currentIndex = targetIndex;
}

-(CGFloat)getLabelTextWidth:(UILabel *)label{
    
    NSString *text = label.text;
   return [text sizeWithAttributes:@{NSFontAttributeName : label.font}].width;
}
@end
