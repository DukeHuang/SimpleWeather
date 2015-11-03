//
//  WXCondition.m
//  SimpleWeather
//
//  Created by Duke on 10/27/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import "WXCondition.h"
#import "MTLModel+NullableScalar.h"

@implementation WXCondition
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"wxcondition_id":@"id",
             };
}
+ (NSValueTransformer *)mainJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Main class]];
}
+ (NSValueTransformer *)coordJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Coord class]];
}
+ (NSValueTransformer *)windJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Wind class]];
}
+ (NSValueTransformer *)sysJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Sys class]];
}
+ (NSValueTransformer *)cloudsJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Clouds class]];
}
+ (NSValueTransformer *)weatherJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Weather class]];
}

+(NSDictionary *)imageMap {
    static NSDictionary *_imageMap = nil;
    if (!_imageMap) {
        _imageMap = @ {
            @"01d" : @"weather-clear",
            @"02d" : @"weather-few",
            @"03d" : @"weather-few",
            @"04d" : @"weather-broken",
            @"09d" : @"weather-shower",
            @"10d" : @"weather-rain",
            @"11d" : @"weather-tstorm",
            @"13d" : @"weather-snow",
            @"50d" : @"weather-mist",
            @"01n" : @"weather-moon",
            @"02n" : @"weather-few-night",
            @"03n" : @"weather-few-night",
            @"04n" : @"weather-broken",
            @"09n" : @"weather-shower",
            @"10n" : @"weather-rain-night",
            @"11n" : @"weather-tstorm",
            @"13n" : @"weather-snow",
            @"50n" : @"weather-mist",
        };
        
    }
    return _imageMap;
}
-(NSString *)imageName {
    return [WXCondition imageMap][self.weather[0].icon];
}

@end


@implementation Coord
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}

@end


@implementation Main
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
+ (NSValueTransformer *)temp_maxJSONTransformer {
    return [self  temperatureJSONTransformer];
}
+ (NSValueTransformer *)temp_minJSONTransformer {
    return [self  temperatureJSONTransformer];

}
+ (NSValueTransformer *)tempJSONTransformer {
    return [self  temperatureJSONTransformer];
}

+ (NSValueTransformer *)temperatureJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id fahrenheit ) {
        CGFloat f = ((NSNumber *)fahrenheit).floatValue;
        return [NSNumber numberWithFloat:f-273.15];
    }];
}

@end


@implementation Wind
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
@end


@implementation Sys
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sys_id":@"id",
             };
}

@end


@implementation Clouds
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
@end


@implementation Weather
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"weather_id":@"id",
             @"weather_description":@"description",
             };
}

@end



