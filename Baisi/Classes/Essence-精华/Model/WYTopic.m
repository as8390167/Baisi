//
//  WYTopic.m
//  Baisi
//
//  Created by SW on 2017/4/5.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYTopic.h"
#import "NSDate+Extension.h"

@implementation WYTopic
{
    CGFloat _cellHeight;
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{ @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id"
            };
}

-(NSString *)create_time{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }

}

-(CGFloat)cellHeight{
    
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake(WYScreenW - 2 * WYTopicCellMargin , MAXFLOAT);
        CGFloat textH = [_text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WYTopicCellFont} context:nil].size.height;
        _cellHeight = WYTopicCellTextY + textH + WYTopicCellMargin;
        if (self.type == WYTopicTypePicture) {
            
            //NSLog(@"宽:%f,高%f",_width,_height);
            //显示的图片的宽度
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= WYTopicCellPictureMaxH) {
                pictureH = WYTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            CGFloat pictureX = WYTopicCellMargin;
            CGFloat pictureY = WYTopicCellTextY + textH + WYTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + WYTopicCellMargin;
        }
        _cellHeight += WYTopicCellBottomBarH + WYTopicCellMargin;
        
    }
    return _cellHeight;
}

@end
