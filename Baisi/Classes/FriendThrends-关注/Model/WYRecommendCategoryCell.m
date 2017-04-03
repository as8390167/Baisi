//
//  WYRecommendCategoryCell.m
//  Baisi
//
//  Created by WY on 2017/4/2.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYRecommendCategoryCell.h"
#import "WYRecommendCategory.h"

@interface WYRecommendCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;


@end

@implementation WYRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCategories:(WYRecommendCategory *)categories
{
    _categories = categories;
    
    self.categoryLabel.text = categories.name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.indicatorView.hidden = !selected;
    self.categoryLabel.textColor = selected ? self.indicatorView.backgroundColor : WYRGBColor(78, 78, 78);
}

@end
