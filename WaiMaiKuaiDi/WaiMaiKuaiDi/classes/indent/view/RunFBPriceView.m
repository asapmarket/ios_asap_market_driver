//
//  RunFBPriceView.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/29.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunFBPriceView.h"

@interface RunFBPriceView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *priceTextField;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *verityButton;

@end

@implementation RunFBPriceView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(20, (SCREEN_HEIGHT-200)/2.0-50, SCREEN_WIDTH-40, 200)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        [self addSubview:_bgView];
        
        _titleLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentCenter];
        _titleLabel.frame = CGRectMake(0, 10, SCREEN_WIDTH-40, 40);
        _titleLabel.text = NSLocalizedString(@"CommodityPrices", nil);
        [_bgView addSubview:_titleLabel];
        
        _priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, SCREEN_WIDTH-80, 40)];
        _priceTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _priceTextField.layer.borderWidth = 1;
        _priceTextField.delegate = self;
        _priceTextField.layer.cornerRadius = 10;
        _priceTextField.placeholder = NSLocalizedString(@"TotalPrice", nil);
        _priceTextField.font = [UIFont systemFontOfSize:15.0f];
        _priceTextField.textAlignment = NSTextAlignmentLeft;
        _priceTextField.textColor = [UIColor hexStringToColor:@"#999999"];
        _priceTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _priceTextField.returnKeyType =UIReturnKeyDone;
        _priceTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
        [_bgView addSubview:_priceTextField];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(20, 140, (SCREEN_WIDTH-120)/2.0, 35);
        _cancelButton.backgroundColor = ButtonColor;
        [_cancelButton setTitle:NSLocalizedString(kCancel,nil) forState:UIControlStateNormal];
        _cancelButton.layer.cornerRadius = 8;
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cnacelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_cancelButton];
        
        _verityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _verityButton.frame = CGRectMake(20+40+(SCREEN_WIDTH-120)/2.0, 140, (SCREEN_WIDTH-120)/2.0, 35);
        _verityButton.backgroundColor = ButtonColor;
        [_verityButton setTitle:NSLocalizedString(kConfirm,nil) forState:UIControlStateNormal];
        _verityButton.layer.cornerRadius = 8;
        [_verityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_verityButton addTarget:self action:@selector(verityBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_verityButton];
        
    }
    return self;
}

- (void)cnacelBtnClick{
    [self removeFromSuperview];
}

- (void)verityBtnClick{
    if (self.verityButtonBlock) {
        self.verityButtonBlock(_priceTextField.text);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
