//
//  SearchViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewButton.h"
#import "SearchTypeView.h"
#import "DatePickerView.h"
#import "TransmitModel.h"

@interface SearchViewController ()<UITextFieldDelegate, SearchTypeViewDelegate, DatePickerViewDelegate>

@property (nonatomic, strong) UIButton *indentButton;
@property (nonatomic, strong) UIButton *start_Time;
@property (nonatomic, strong) UIButton *end_Time;
@property (nonatomic, strong) UIButton *order_Type;
@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) UIImageView *indentImageView;
@property (nonatomic, strong) UIImageView *orderImageView;

@property (nonatomic, strong) SearchTypeView *indentView;
@property (nonatomic, strong) SearchTypeView *orderView;

@property (nonatomic, strong) UITextField *indent_No;
@property (nonatomic, strong) UITextField *phone_No;

@property (nonatomic, strong) NSArray *indentArray;
@property (nonatomic, strong) NSArray *orderArray;

@property (nonatomic, strong) DatePickerView *dateView;
@property (nonatomic, strong) TransmitModel *model;

/**
 传参数据
 */
@property (nonatomic, strong) NSString *state; //订单状态
@property (nonatomic, strong) NSString *start_time; //开始时间
@property (nonatomic, strong) NSString *end_time;  //结束时间
@property (nonatomic, strong) NSString *payment_method; //支付方式
@property (nonatomic, strong) NSString *order_id;  //订单编号
@property (nonatomic, strong) NSString *phone;   //手机号


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kSearch, nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:NSLocalizedString(kReset, nil) titleColor:ButtonColor font:[UIFont systemFontOfSize:13] size:CGSizeMake(30, 13) target:self action:@selector(rightBarButtonItemClick)];
    
    _indentArray = @[NSLocalizedString(kOrderType, nil) ,NSLocalizedString(kOrderSuccess, nil), NSLocalizedString(@"ISFeedBack", nil), NSLocalizedString(kIsTake, nil),NSLocalizedString(kOnRoad, nil),NSLocalizedString(kOrderEnd, nil)];
    
    _orderArray = @[NSLocalizedString(kPayType, nil), @"visa", @"paypal" ,NSLocalizedString(@"CashPayments", nil), NSLocalizedString(@"RewardPoint", nil)];
    _model = [[TransmitModel alloc] init];
    
    [self initView];
}

- (void)rightBarButtonItemClick{
    [_indentButton setTitle:NSLocalizedString(kOrderType, nil) forState:UIControlStateNormal];
    [_indentButton setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
    [_order_Type setTitle:NSLocalizedString(kPayType, nil) forState:UIControlStateNormal];
    [_order_Type setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
    [self recover];
    [_start_Time setTitle:NSLocalizedString(kStartTime, nil) forState:UIControlStateNormal];
    [_order_Type setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
    [_end_Time setTitle:NSLocalizedString(kEndTime, nil) forState:UIControlStateNormal];
    [_end_Time setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
    _indent_No.text = nil;
    _phone_No.text = nil;
    
}

- (void)initView{
    _indentButton = [SearchViewButton initWithFrame:CGRectMake(10, 74, SCREEN_WIDTH-20, 55) title:NSLocalizedString(kOrderType, nil) target:self action:@selector(indentButtonClick:)];
    _indentButton.selected = NO;
    [self.view addSubview:_indentButton];
    
    _indentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_indentButton.frame.size.width-21.5, 24.5, 11.5, 6)];
    _indentImageView.image = [UIImage imageNamed:@"down"];
    [_indentButton addSubview:_indentImageView];
    
    _start_Time = [SearchViewButton initWithFrame:CGRectMake(10, 139, (SCREEN_WIDTH-30)/2, 55) title:NSLocalizedString(kStartTime, nil) target:self action:@selector(startTimeClick)];
    _start_Time.selected = NO;
    [self.view addSubview:_start_Time];
    UIImageView *start = [[UIImageView alloc] initWithFrame:CGRectMake(_start_Time.frame.size.width-25, 20, 15, 15)];
    start.image = [UIImage imageNamed:@"date"];
    [_start_Time addSubview:start];
    
    _end_Time = [SearchViewButton initWithFrame:CGRectMake((SCREEN_WIDTH-30)/2+20, 139, (SCREEN_WIDTH-30)/2, 55) title:NSLocalizedString(kEndTime, nil) target:self action:@selector(endTimeClick)];
    _end_Time.selected = NO;
    [self.view addSubview:_end_Time];
    UIImageView *end = [[UIImageView alloc] initWithFrame:CGRectMake(_start_Time.frame.size.width-25, 20, 15, 15)];
    end.image = [UIImage imageNamed:@"date"];
    [_end_Time addSubview:end];
    
    _order_Type = [SearchViewButton initWithFrame:CGRectMake(10, 204, SCREEN_WIDTH-20, 55) title:NSLocalizedString(kPayType, nil) target:self action:@selector(orderButtonClick:)];
    _indentButton.selected = NO;
    [self.view addSubview:_order_Type];
    
    _orderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_order_Type.frame.size.width-21.5, 24.5, 11.5, 6)];
    _orderImageView.image = [UIImage imageNamed:@"down"];
    [_order_Type addSubview:_orderImageView];
    
    UIView *left1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 55)];
    _indent_No = [[UITextField alloc] initWithFrame:CGRectMake(10, 279, SCREEN_WIDTH-20, 55)];
    _indent_No.delegate = self;
    _indent_No.tag = 2000;
    _indent_No.layer.borderWidth = 0.5;
    _indent_No.layer.borderColor = [UIColor hexStringToColor:@"#2196f3"].CGColor;
    _indent_No.layer.cornerRadius = 5;
    _indent_No.returnKeyType = UIReturnKeyDone;
    _indent_No.leftView = left1;
    _indent_No.leftViewMode = UITextFieldViewModeAlways;
    _indent_No.placeholder = NSLocalizedString(kEnterOrderNO, nil);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(indentNoChange) name:UITextFieldTextDidChangeNotification object:_indent_No];
    
    [self.view addSubview:_indent_No];
    
    UIView *left2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 55)];
    _phone_No = [[UITextField alloc] initWithFrame:CGRectMake(10, 344, SCREEN_WIDTH-20, 55)];
    _phone_No.delegate = self;
    _phone_No.tag = 2001;
    _phone_No.layer.borderWidth = 0.5;
    _phone_No.layer.borderColor = [UIColor hexStringToColor:@"#2196f3"].CGColor;
    _phone_No.layer.cornerRadius = 5;
    _phone_No.keyboardType = UIKeyboardTypeNumberPad;
    _phone_No.leftView = left2;
    _phone_No.leftViewMode = UITextFieldViewModeAlways;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNoChange) name:UITextFieldTextDidChangeNotification object:_phone_No];
    _phone_No.placeholder = NSLocalizedString(kEnterPhoneNO, nil);
    [self.view addSubview:_phone_No];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.frame = CGRectMake(0, SCREEN_HEIGHT-45, SCREEN_WIDTH, 45);
    [_searchButton setTitle:NSLocalizedString(kSearch, nil) forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchButton setBackgroundColor:ButtonColor];
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchButton];
    
    _dateView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    _dateView.delegate = self;
    _dateView.title = NSLocalizedString(kSelectTime, nil);
    [self.view addSubview:_dateView];
    
}

- (void)searchButtonClick{
    _model.order_id = _indent_No.text;
    _model.cust_phone = _phone_No.text;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderViewDidSearch object:_model];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)indentButtonClick:(UIButton *)button{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (_order_Type.isSelected) {
        button.selected = NO;
        [_orderImageView setTransform:CGAffineTransformIdentity];
        if (_orderView) {
            [_orderView removeFromSuperview];
            _orderView.delegate = nil;
        }
        [self setFrameDefault];
    }
    
    if (button.isSelected) {
        button.selected = NO;
        [_indentImageView setTransform:CGAffineTransformIdentity];
        if (_indentView) {
            [_indentView removeFromSuperview];
            _indentView.delegate = nil;
        }
        [self setFrameDefault];
        
    }else{
        button.selected = YES;
        CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI);
        _indentImageView.transform = transform;//旋转
        [self createIndentView];
        [self updateViewWithIndentButtonClick];
    }
    
}

- (void)orderButtonClick:(UIButton *)button{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (_indentButton.isSelected) {
        button.selected = NO;
        [_indentImageView setTransform:CGAffineTransformIdentity];
        if (_indentView) {
            [_indentView removeFromSuperview];
            _indentView.delegate = nil;
        }
        [self setFrameDefault];
    }
    
    if (button.isSelected) {
        button.selected = NO;
        [_orderImageView setTransform:CGAffineTransformIdentity];
        if (_orderView) {
            [_orderView removeFromSuperview];
            _orderView.delegate = nil;
        }
        [self setFrameDefault];
    }else{
        button.selected = YES;
        CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI);
        _orderImageView.transform = transform;//旋转
        [self createOrderView];
        [self updateViewWithOrderButtonClick];
    }
    
}

- (void)startTimeClick{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.tag = 3000;
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
    }];

}

- (void)endTimeClick{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.tag = 4000;
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
    }];
}


- (void)updateViewWithIndentButtonClick{
    CGFloat height = 139;
    
    height += _indentArray.count*35+5;
    
    _start_Time.frame = CGRectMake(10, height, (SCREEN_WIDTH-30)/2, 55);
    _end_Time.frame = CGRectMake((SCREEN_WIDTH-30)/2+20, height, (SCREEN_WIDTH-30)/2, 55);
    height += 65;
    
    _order_Type.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 55);
    
    height += 65;
    
    _indent_No.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 55);
    
    height += 65;
    
    _phone_No.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 55);
    
}

- (void)setFrameDefault{
    CGFloat height = 139;
    
    _start_Time.frame = CGRectMake(10, height, (SCREEN_WIDTH-30)/2, 55);
    _end_Time.frame = CGRectMake((SCREEN_WIDTH-30)/2+20, height, (SCREEN_WIDTH-30)/2, 55);
    height += 65;
    
    _order_Type.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 55);
    
    height += 65;
    
    _indent_No.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 55);
    
    height += 65;
    
    _phone_No.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 55);
    
}

- (void)updateViewWithOrderButtonClick{
    CGFloat height = 279;
    height += _orderArray.count*35;
    _indent_No.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 55);
    
    height += 65;
    
    _phone_No.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 55);
    
}

- (void)createIndentView{
    _indentView = [[SearchTypeView alloc] initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH-20, _indentArray.count*35+15) titleArray:_indentArray];
    _indentView.tag = 1000;
    _indentView.delegate = self;
    [self.view addSubview:_indentView];
    [self.view insertSubview:_indentView belowSubview:_indentButton];
}

- (void)createOrderView{
    _orderView = [[SearchTypeView alloc] initWithFrame:CGRectMake(10, 249, SCREEN_WIDTH-20, _orderArray.count*35+15) titleArray:_orderArray];
    _orderView.tag = 1001;
    _orderView.delegate = self;
    [self.view addSubview:_orderView];
    [self.view insertSubview:_orderView belowSubview:_order_Type];
}


- (void)typeTitleClickWithTitle:(NSString *)title index:(NSInteger)index view:(SearchTypeView *)view{
    if (view.tag == 1000) {
        [_indentButton setTitle:title forState:UIControlStateNormal];
        if (index == 0) {
            [_indentButton setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
        }else{
            [_indentButton setTitleColor:[UIColor hexStringToColor:@"#333333"] forState:UIControlStateNormal];
        }
        if (index > 0){
            if (index == 2) {
                _model.state = [NSString stringWithFormat:@"8"];
            }else{
                _model.state = [NSString stringWithFormat:@"%ld",index];
            }
        }
        [self indentButtonClick:_indentButton];
    }else{
        [_order_Type setTitle:title forState:UIControlStateNormal];
        if (index == 0) {
            [_order_Type setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
        }else{
            [_order_Type setTitleColor:[UIColor hexStringToColor:@"#333333"] forState:UIControlStateNormal];
        }
        [self orderButtonClick:_order_Type];
        if (index > 0) {
            if (index == 3){
                _model.pay_method = [NSString stringWithFormat:@"4"];
            }else if (index == 4){
                _model.pay_method = [NSString stringWithFormat:@"5"];
            }else{
                _model.pay_method = [NSString stringWithFormat:@"%ld",index-1];
            }
        }
    }
    
}

- (void)recover{
    if (_indentButton.isSelected) {
        _indentButton.selected = NO;
        [_indentImageView setTransform:CGAffineTransformIdentity];
        if (_indentView) {
            [_indentView removeFromSuperview];
            _indentView.delegate = nil;
        }
        [self setFrameDefault];
    }
    
    if (_order_Type.isSelected) {
        _order_Type.selected = NO;
        [_orderImageView setTransform:CGAffineTransformIdentity];
        if (_orderView) {
            [_orderView removeFromSuperview];
            _orderView.delegate = nil;
        }
        [self setFrameDefault];
    }
    
}

#pragma DatePickerViewDelegate
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer dateView:(DatePickerView *)dateView{
    if (dateView.tag == 3000) {
        [_start_Time setTitle:timer forState:UIControlStateNormal];
        [_start_Time setTitleColor:[UIColor hexStringToColor:@"#333333"] forState:UIControlStateNormal];
        _model.start_time = timer;
        
    }else{
        [_end_Time setTitle:timer forState:UIControlStateNormal];
        [_end_Time setTitleColor:[UIColor hexStringToColor:@"#333333"] forState:UIControlStateNormal];
        _model.end_time = timer;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

- (void)datePickerViewCancelBtnClickDelegate{
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self recover];
    return YES;
}
//UITextField的代理方法，点击键盘return按钮退出键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)phoneNoChange{
    [self recover];
}

- (void)indentNoChange{
    [self recover];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
