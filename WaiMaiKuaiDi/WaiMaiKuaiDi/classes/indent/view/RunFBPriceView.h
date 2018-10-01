//
//  RunFBPriceView.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/29.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunFBPriceView : UIView

@property (nonatomic, copy) void (^verityButtonBlock)(NSString *price);

@end
