//
//  StartLocation.m
//
//  Created by   on 2017/8/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "StartLocation.h"


NSString *const kStartLocationLat = @"lat";
NSString *const kStartLocationLng = @"lng";


@interface StartLocation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StartLocation

@synthesize lat = _lat;
@synthesize lng = _lng;


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
            self.lat = [[self objectOrNilForKey:kStartLocationLat fromDictionary:dict] doubleValue];
            self.lng = [[self objectOrNilForKey:kStartLocationLng fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kStartLocationLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kStartLocationLng];

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

    self.lat = [aDecoder decodeDoubleForKey:kStartLocationLat];
    self.lng = [aDecoder decodeDoubleForKey:kStartLocationLng];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lat forKey:kStartLocationLat];
    [aCoder encodeDouble:_lng forKey:kStartLocationLng];
}

- (id)copyWithZone:(NSZone *)zone
{
    StartLocation *copy = [[StartLocation alloc] init];
    
    if (copy) {

        copy.lat = self.lat;
        copy.lng = self.lng;
    }
    
    return copy;
}


@end
