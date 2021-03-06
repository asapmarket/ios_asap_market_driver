//
//  CreateLabel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CreateLabel.h"

@implementation CreateLabel

+ (UILabel *)createLabelWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = font;
    label.textColor = color;
    label.textAlignment = textAlignment;
    return label;
}

@end
