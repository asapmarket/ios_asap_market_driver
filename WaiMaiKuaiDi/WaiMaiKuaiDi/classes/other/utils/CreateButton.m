//
//  CreateButton.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/28.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CreateButton.h"

@implementation CreateButton

+ (MultiParamButton *)creatButtonWithFrame:(CGRect)frame title:(NSString *)title backCoclor:(UIColor *)backColor tittleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action{
    MultiParamButton *button = [MultiParamButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backColor];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
