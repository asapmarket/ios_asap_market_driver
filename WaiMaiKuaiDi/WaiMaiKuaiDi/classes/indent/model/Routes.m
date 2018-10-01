//
//  Routes.m
//
//  Created by   on 2017/8/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Routes.h"
#import "Legs.h"


NSString *const kRoutesLegs = @"legs";


@interface Routes ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Routes

@synthesize legs = _legs;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedLegs = [dict objectForKey:kRoutesLegs];
    NSMutableArray *parsedLegs = [NSMutableArray array];
    if ([receivedLegs isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLegs) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLegs addObject:[Legs modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLegs isKindOfClass:[NSDictionary class]]) {
       [parsedLegs addObject:[Legs modelObjectWithDictionary:(NSDictionary *)receivedLegs]];
    }

    self.legs = [NSArray arrayWithArray:parsedLegs];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForLegs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.legs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLegs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLegs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLegs] forKey:kRoutesLegs];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.legs = [aDecoder decodeObjectForKey:kRoutesLegs];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_legs forKey:kRoutesLegs];
}

- (id)copyWithZone:(NSZone *)zone
{
    Routes *copy = [[Routes alloc] init];
    
    if (copy) {

        copy.legs = [self.legs copyWithZone:zone];
    }
    
    return copy;
}


@end
