//
//  WXDailyForecast.m
//  SimpleWeather
//
//  Created by Duke on 10/27/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import "WXDailyForecast.h"

@implementation WXDailyForecast
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
+ (NSValueTransformer *)cityJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[City_Daily class]];
}
+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[List_Daily class]];
}

@end
@implementation City_Daily
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"city_daily_id":@"id"
             };
}
+ (NSValueTransformer *)coordJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Coord_Daily class]];
}

@end


@implementation Coord_Daily
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}


@end


@implementation List_Daily
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
+ (NSValueTransformer *)tempJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Temp_Daily class]];
}

+ (NSValueTransformer *)cloudsJSONTransformer {
    return [MTLValueTransformer
            reversibleTransformerWithForwardBlock:^ id (id JSONDictionary) {
                
                if ([JSONDictionary isKindOfClass:[NSNumber class]]) {
                    JSONDictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:@"all"];
                    
                }
                return [MTLJSONAdapter modelOfClass:Clouds_Daily.class fromJSONDictionary:JSONDictionary error:NULL];
            }
            reverseBlock:^ id (id model) {
                if (model == nil) return nil;
                
                NSAssert([model isKindOfClass:MTLModel.class], @"Expected a MTLModel object, got %@", model);
                NSAssert([model conformsToProtocol:@protocol(MTLJSONSerializing)], @"Expected a model object conforming to <MTLJSONSerializing>, got %@", model);
                
                return [MTLJSONAdapter JSONDictionaryFromModel:model];
            }];
}

+ (NSValueTransformer *)weatherJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Weather_Daily class]];
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
    return [List_Daily imageMap][icon];
}

@end

@implementation Clouds_Daily
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
@end

@implementation Temp_Daily
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
+ (NSValueTransformer *)minJSONTransformer {
    return [self temperatureJSONTransformer];
}
+ (NSValueTransformer *)maxJSONTransformer {
    return [self temperatureJSONTransformer];
}
+ (NSValueTransformer *)temperatureJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id fahrenheit ) {
        CGFloat f = ((NSNumber *)fahrenheit).floatValue;
        return [NSNumber numberWithFloat:f-273.15];
    }];
}
@end


@implementation Weather_Daily
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"weather_Daily_id":@"id",
             @"weather_Daily_description":@"description",
             };
}

@end


