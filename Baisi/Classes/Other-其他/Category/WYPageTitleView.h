//
//  WYPageTitleView.h
//  Baisi
//
//  Created by WY on 2017/4/2.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYPageTitleView;
@protocol WYPageTitleViewDelegate <NSObject>

-(void)pageTitleView:(WYPageTitleView *)pageTitleView selectIndex:(int)index;

@end

@interface WYPageTitleView : UIView

/** 代理 */
@property(nonatomic,weak)id<WYPageTitleViewDelegate> delegate;

/** 标题数组 */
@property(nonatomic,strong)NSArray<NSString *> *titles;

/** 未选中标题颜色 */
@property(nonatomic,strong)UIColor *textColor;

/** 选中标题颜色 */
@property(nonatomic,strong)UIColor *selectTitleColor;

/** 标题字体大小 */
@property(nonatomic,strong)UIFont *titleFont;

-(void)setTitleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex;
@end
