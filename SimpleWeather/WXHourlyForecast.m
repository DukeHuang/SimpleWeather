//
//  WXHourlyForecast.m
//  SimpleWeather
//
//  Created by Duke on 10/29/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import "WXHourlyForecast.h"

@implementation WXHourlyForecast
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
+ (NSValueTransformer *)cityJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[City_Hourly class]];
}
+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[List_Hourly class]];
}

@end

@implementation City_Hourly

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"city_Hourly_id":@"id",
             };
}
+ (NSValueTransformer *)coordJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Coord_Hourly class]];
}
+ (NSValueTransformer *)sysJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Sys_Hourly class]];
}
@end


@implementation Coord_Hourly
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}


@end


@implementation Sys_Hourly
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
@end


@implementation List_Hourly
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
+ (NSValueTransformer *)cloudsJSONTransformer {
    return [MTLValueTransformer
            reversibleTransformerWithForwardBlock:^ id (id JSONDictionary) {
                if ([JSONDictionary isKindOfClass:[NSNumber class]]) {
                    JSONDictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:@"all"];
                
                }
                return [MTLJSONAdapter modelOfClass:Clouds_Hourly.class fromJSONDictionary:JSONDictionary error:NULL];
            }
            reverseBlock:^ id (id model) {
                if (model == nil) return nil;
                
                NSAssert([model isKindOfClass:MTLModel.class], @"Expected a MTLModel object, got %@", model);
                NSAssert([model conformsToProtocol:@protocol(MTLJSONSerializing)], @"Expected a model object conforming to <MTLJSONSerializing>, got %@", model);
                
                return [MTLJSONAdapter JSONDictionaryFromModel:model];
            }];
}
+ (NSValueTransformer *)windJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Wind_Hourly class]];
}
+ (NSValueTransformer *)mainJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Main_Hourly class]];
}
+ (NSValueTransformer *)sysJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Sys_Hourly_1 class]];
}
+ (NSValueTransformer *)weatherJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Weather_Hourly class]];
}


+ (NSDictionary *)imageMap {
    // 1
    static NSDictionary *_imageMap = nil;
    if (! _imageMap) {
        // 2
        _imageMap = @{
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

// 3
- (NSString *)imageName:(NSString *)icon{
    return [List_Hourly imageMap][icon];
}

@end


@implementation Wind_Hourly
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
@end


@implementation Main_Hourly
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
+ (NSValueTransformer *)tempJSONTransformer {
    return [self temperatureJSONTransformer];
}
+ (NSValueTransformer *)temperatureJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id fahrenheit ) {
        CGFloat f = ((NSNumber *)fahrenheit).floatValue;
        return [NSNumber numberWithFloat:f-273.15];
    }];
}
@end


@implementation Sys_Hourly_1
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
@end


@implementation Clouds_Hourly
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
@end


@implementation Weather_Hourly
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"weather_Hourly_id":@"id",
             @"weather_Hourly_description":@"description",
             };
}




@end


