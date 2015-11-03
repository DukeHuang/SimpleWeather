//
//  WXHourlyForecast.h
//  SimpleWeather
//
//  Created by Duke on 10/29/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import <Mantle.h>
@import CoreGraphics;
//
@class City_Hourly,Coord_Hourly,Sys_Hourly,List_Hourly,Wind_Hourly,Main_Hourly,Sys_Hourly_1,Clouds_Hourly,Weather_Hourly;
@interface WXHourlyForecast : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) CGFloat message;

@property (nonatomic, copy) NSString *cod;

@property (nonatomic, strong) City_Hourly *city;

@property (nonatomic, assign) NSInteger cnt;

@property (nonatomic, strong) NSArray<List_Hourly *> *list;


@end

@interface City_Hourly : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger city_Hourly_id;

@property (nonatomic, strong) Coord_Hourly *coord;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger population;

@property (nonatomic, strong) Sys_Hourly *sys;

@end

@interface Coord_Hourly : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) CGFloat lon;

@property (nonatomic, assign) CGFloat lat;

@end

@interface Sys_Hourly : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger population;

@end

@interface List_Hourly : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) Clouds_Hourly *clouds;

@property (nonatomic, strong) Wind_Hourly *wind;

@property (nonatomic, assign) NSInteger dt;

@property (nonatomic, copy) NSString *dt_txt;

@property (nonatomic, strong) Main_Hourly *main;

@property (nonatomic, strong) NSArray<Weather_Hourly *> *weather;

@property (nonatomic, strong) Sys_Hourly_1 *sys;

- (NSString *)imageName:(NSString *)icon;

@end

@interface Wind_Hourly : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) CGFloat speed;

@property (nonatomic, assign) CGFloat deg;

@end

@interface Main_Hourly : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger humidity;

@property (nonatomic, assign) CGFloat temp_min;

@property (nonatomic, assign) CGFloat temp_kf;

@property (nonatomic, assign) CGFloat temp_max;

@property (nonatomic, strong) NSNumber *temp;

@property (nonatomic, assign) CGFloat pressure;

@property (nonatomic, assign) CGFloat sea_level;

@property (nonatomic, assign) CGFloat grnd_level;

@end

@interface Sys_Hourly_1 : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *pod;

@end

@interface Clouds_Hourly : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger all;

@end

@interface Weather_Hourly : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger weather_Hourly_id
;

@property (nonatomic, copy) NSString *main;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *weather_Hourly_description;

@end


