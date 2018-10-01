//
//  UILabel+New.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UILabel+New.h"

@implementation UILabel (New)

+ (UILabel *)createLabelWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = font;
    label.textColor = color;
    label.textAlignment = textAlignment;
    return label;
}

@end
