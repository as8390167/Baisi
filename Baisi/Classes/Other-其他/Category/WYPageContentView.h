//
//  WYPageContentView.h
//  Baisi
//
//  Created by WY on 2017/4/2.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYPageContentView;
@protocol WYPageContentViewDelegate <NSObject>

-(void)pageContentView:(WYPageContentView *)contentView progress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex;

@end

@interface WYPageContentView : UIView

/** 代理 */
@property(nonatomic,weak)id<WYPageContentViewDelegate> delegate;

-(void)parentVC:(UIViewController *)parentVC childVCs:(NSArray<UIViewController *>*)childVCs;

-(void)setCurrentIndex:(int)currentIndex;
@end
