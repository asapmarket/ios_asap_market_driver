//
//  OrderSearchView.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/29.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderSearchViewDelegate <NSObject>

- (void)returnButtonClick:(NSString *)text;

@end

@interface OrderSearchView : UIView

@property (nonatomic, weak)id<OrderSearchViewDelegate>delegate;
@property (nonatomic, strong) UITextField *searchTextField;


@end
