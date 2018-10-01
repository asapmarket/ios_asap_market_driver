//
//  Legs.m
//
//  Created by   on 2017/8/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Legs.h"
#import "Steps.h"
#import "StartLocation.h"


NSString *const kLegsSteps = @"steps";
NSString *const kLegsStartLocation = @"start_location";


@interface Legs ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Legs

@synthesize steps = _steps;
@synthesize startLocation = _startLocation;


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
    NSObject *receivedSteps = [dict objectForKey:kLegsSteps];
    NSMutableArray *parsedSteps = [NSMutableArray array];
    if ([receivedSteps isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSteps) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSteps addObject:[Steps modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSteps isKindOfClass:[NSDictionary class]]) {
       [parsedSteps addObject:[Steps modelObjectWithDictionary:(NSDictionary *)receivedSteps]];
    }

    self.steps = [NSArray arrayWithArray:parsedSteps];
            self.startLocation = [StartLocation modelObjectWithDictionary:[dict objectForKey:kLegsStartLocation]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSteps = [NSMutableArray array];
    for (NSObject *subArrayObject in self.steps) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSteps addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSteps addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSteps] forKey:kLegsSteps];
    [mutableDict setValue:[self.startLocation dictionaryRepresentation] forKey:kLegsStartLocation];

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

    self.steps = [aDecoder decodeObjectForKey:kLegsSteps];
    self.startLocation = [aDecoder decodeObjectForKey:kLegsStartLocation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_steps forKey:kLegsSteps];
    [aCoder encodeObject:_startLocation forKey:kLegsStartLocation];
}

- (id)copyWithZone:(NSZone *)zone
{
    Legs *copy = [[Legs alloc] init];
    
    if (copy) {

        copy.steps = [self.steps copyWithZone:zone];
        copy.startLocation = [self.startLocation copyWithZone:zone];
    }
    
    return copy;
}


@end
