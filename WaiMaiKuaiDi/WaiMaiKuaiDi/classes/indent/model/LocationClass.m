//
//  LocationClass.m
//
//  Created by   on 2017/8/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "LocationClass.h"
#import "Routes.h"


NSString *const kLocationClassStatus = @"status";
NSString *const kLocationClassRoutes = @"routes";


@interface LocationClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationClass

@synthesize status = _status;
@synthesize routes = _routes;


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
            self.status = [self objectOrNilForKey:kLocationClassStatus fromDictionary:dict];
    NSObject *receivedRoutes = [dict objectForKey:kLocationClassRoutes];
    NSMutableArray *parsedRoutes = [NSMutableArray array];
    if ([receivedRoutes isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRoutes) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRoutes addObject:[Routes modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRoutes isKindOfClass:[NSDictionary class]]) {
       [parsedRoutes addObject:[Routes modelObjectWithDictionary:(NSDictionary *)receivedRoutes]];
    }

    self.routes = [NSArray arrayWithArray:parsedRoutes];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kLocationClassStatus];
    NSMutableArray *tempArrayForRoutes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.routes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRoutes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRoutes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRoutes] forKey:kLocationClassRoutes];

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

    self.status = [aDecoder decodeObjectForKey:kLocationClassStatus];
    self.routes = [aDecoder decodeObjectForKey:kLocationClassRoutes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kLocationClassStatus];
    [aCoder encodeObject:_routes forKey:kLocationClassRoutes];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationClass *copy = [[LocationClass alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.routes = [self.routes copyWithZone:zone];
    }
    
    return copy;
}


@end
