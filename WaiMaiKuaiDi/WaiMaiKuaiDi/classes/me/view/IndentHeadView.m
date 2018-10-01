//
//  IndentHeadView.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import "IndentHeadView.h"

@implementation IndentHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor hexStringToColor:@"#259ff5"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    UIImage *image = [UIImage imageNamed:@"order_code"];
    
    CGFloat imageX = (SCREEN_WIDTH-(title.length*15+image.size.width))/2.0;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, (self.bounds.size.height-image.size.height)/2.0, image.size.width, image.size.height)];
    imageV.image = image;
    [self addSubview:imageV];
    
    CGFloat titleX = imageX + image.size.width;
    _titleLabel.frame = CGRectMake(titleX, 0, title.length*15, 49);
    _titleLabel.text = title;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
