//
//  StartLocation.h
//
//  Created by   on 2017/8/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface StartLocation : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
