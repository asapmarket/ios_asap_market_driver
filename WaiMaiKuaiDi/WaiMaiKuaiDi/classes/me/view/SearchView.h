//
//  SearchView.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+ImageTitleV.h"

@protocol SearchViewDelegate <NSObject>

- (void)returnButtonClick:(NSString *)text;

- (void)selectButtonClick;

@end
@interface SearchView : UIView

@property (nonatomic, weak)id<SearchViewDelegate>delegate;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *selButton;

@end
