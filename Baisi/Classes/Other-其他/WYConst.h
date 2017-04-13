//
//  WYConst.h
//  Baisi
//
//  Created by SW on 2017/3/30.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WYTopicTypeAll = 1,
    WYTopicTypePicture = 10,
    WYTopicTypeWord = 29,
    WYTopicTypeVoice = 31,
    WYTopicTypeVideo = 41
} WYTopicType;
UIKIT_EXTERN CGFloat const WYTabBarH;
UIKIT_EXTERN CGFloat const WYTitlesViewH;
UIKIT_EXTERN CGFloat const WYTitlesViewY;


/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const WYTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const WYTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const WYTopicCellBottomBarH;
