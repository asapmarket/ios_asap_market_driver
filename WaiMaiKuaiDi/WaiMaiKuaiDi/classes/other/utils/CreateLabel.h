//
//  CreateLabel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateLabel : NSObject

+ (UILabel *)createLabelWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;

@end
