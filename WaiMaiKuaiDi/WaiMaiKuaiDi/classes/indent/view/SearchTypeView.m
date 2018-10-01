//
//  SearchTypeView.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SearchTypeView.h"
#import "CreateButton.h"

@implementation SearchTypeView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor hexStringToColor:@"#2196f3"].CGColor;
        self.layer.cornerRadius = 5;
        for (int i=0; i<array.count; i++) {
            MultiParamButton *btn = [CreateButton creatButtonWithFrame:CGRectMake(0, 10 + 35*i, self.bounds.size.width, 35) title:array[i] backCoclor:[UIColor whiteColor] tittleColor:[UIColor hexStringToColor:@"#333333"] font:[UIFont systemFontOfSize:15] target:self action:@selector(titleButtonClick:)];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            btn.tag = 10000+i;
            [self addSubview:btn];
            
            if (i == 0){
                [btn setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
            }
        }
    }
    
    return self;
}

- (void)titleButtonClick:(UIButton *)btn{
    NSInteger index = btn.tag - 10000;
    
    if ([self.delegate respondsToSelector:@selector(typeTitleClickWithTitle:index:view:)]) {
        [self.delegate typeTitleClickWithTitle:btn.titleLabel.text index:index view:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
