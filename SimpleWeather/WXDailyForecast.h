//
//  WXDailyForecast.h
//  SimpleWeather
//
//  Created by Duke on 10/27/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import "WXCondition.h"
#import <Mantle.h>
@import CoreGraphics;

@class City_Daily,Coord_Daily,List_Daily,Clouds_Daily,Temp_Daily,Weather_Daily;
@interface WXDailyForecast : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber* message;

@property (nonatomic, copy) NSString *cod;

@property (nonatomic, strong) City_Daily *city;

@property (nonatomic, assign) NSInteger cnt;

@property (nonatomic, strong) NSArray<List_Daily *> *list;


@end
@interface City_Daily : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger city_daily_id;

@property (nonatomic, strong) Coord_Daily *coord;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger population;

@end

@interface Coord_Daily : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber* lon;

@property (nonatomic, strong) NSNumber* lat;

@end

@interface List_Daily : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) Clouds_Daily *clouds;

@property (nonatomic, assign) NSInteger humidity;

@property (nonatomic, assign) NSInteger dt;

@property (nonatomic, strong) NSNumber* speed;

@property (nonatomic, strong) Temp_Daily *temp;

@property (nonatomic, strong) NSNumber* pressure;

@property (nonatomic, strong) NSArray<Weather_Daily *> *weather;

@property (nonatomic, assign) NSInteger deg;
- (NSString *)imageName:(NSString *)icon;
@end


@interface Clouds_Daily : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger all;

@end

@interface Temp_Daily : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber* night;

@property (nonatomic, strong) NSNumber* min;

@property (nonatomic, strong) NSNumber* eve;

@property (nonatomic, strong) NSNumber* day;

@property (nonatomic, strong) NSNumber* max;

@property (nonatomic, strong) NSNumber* morn;

@end

@interface Weather_Daily : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger weather_Daily_id;

@property (nonatomic, copy) NSString *main;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *weather_Daily_description;

@end


