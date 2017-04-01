//
//  UIBarButtonItem+Extension.h
//  Baisi
//
//  Created by SW on 2017/3/31.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


+(__kindof UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


@end
