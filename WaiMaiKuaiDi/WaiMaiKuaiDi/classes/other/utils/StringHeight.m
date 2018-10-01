//
//  StringHeight.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "StringHeight.h"

@implementation StringHeight

+ (CGFloat)heightFromString:(NSString*)text withFont:(CGFloat)font constraintToWidth:(CGFloat)width
{
    if (text && font) {
        CGRect rect  = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
        
        return rect.size.height;
    }
    return 0;
}

@end
