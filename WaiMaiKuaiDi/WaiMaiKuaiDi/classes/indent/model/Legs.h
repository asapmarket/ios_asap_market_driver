//
//  Legs.h
//
//  Created by   on 2017/8/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StartLocation;

@interface Legs : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *steps;
@property (nonatomic, strong) StartLocation *startLocation;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
