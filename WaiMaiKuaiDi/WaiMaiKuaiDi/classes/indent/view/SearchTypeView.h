//
//  SearchTypeView.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchTypeView;

@protocol SearchTypeViewDelegate <NSObject>

- (void)typeTitleClickWithTitle:(NSString *)title index:(NSInteger)index view:(SearchTypeView *)view;

@end

@interface SearchTypeView : UIView

@property (nonatomic, weak) id<SearchTypeViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array;

@end
