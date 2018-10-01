//
//  DatePickerView.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/28.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerView;

@protocol DatePickerViewDelegate <NSObject>

/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer dateView:(DatePickerView *)dateView;

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate;

@end

@interface DatePickerView : UIView

@property (copy, nonatomic) NSString *title;
@property (weak, nonatomic) id <DatePickerViewDelegate> delegate;

/// 显示
- (void)show;

@end
