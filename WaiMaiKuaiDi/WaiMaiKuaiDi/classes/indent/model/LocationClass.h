//
//  LocationClass.h
//
//  Created by   on 2017/8/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LocationClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *routes;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
