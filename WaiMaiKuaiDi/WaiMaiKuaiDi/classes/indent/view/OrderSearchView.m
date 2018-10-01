//
//  OrderSearchView.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/29.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderSearchView.h"

@interface OrderSearchView ()<UITextFieldDelegate>

@end


@implementation OrderSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
        leftView.backgroundColor = [UIColor clearColor];
        //添加图片
        UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7, 11, 11.5)];
        headView.image = [UIImage imageNamed:@"search"];
        [leftView addSubview:headView];
        
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 12, SCREEN_WIDTH-20, 25)];
        _searchTextField.leftView = leftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.delegate = self;
        _searchTextField.backgroundColor = ThemeBgColor;
        _searchTextField.placeholder = NSLocalizedString(kSearchPlaceholder,nil);
        _searchTextField.layer.borderColor = [UIColor hexStringToColor:@"#eeeeee"].CGColor;
        _searchTextField.font = [UIFont systemFontOfSize:11];
        _searchTextField.layer.borderWidth = 0.5f;
        _searchTextField.layer.cornerRadius = 12.5f;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        [self addSubview:_searchTextField];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(keyboardWillHide)
         
                                                     name:UIKeyboardWillHideNotification
         
                                                   object:nil];
        
    }
    return self;
}

//UITextField的代理方法，点击键盘return按钮退出键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    if ([self.delegate respondsToSelector:@selector(returnButtonClick:)]) {
//        [self.delegate returnButtonClick:textField.text];
//    }
    return YES;
}

- (void)keyboardWillHide{
    if ([self.delegate respondsToSelector:@selector(returnButtonClick:)]) {
        [self.delegate returnButtonClick:_searchTextField.text];
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
