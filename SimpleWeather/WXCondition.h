//
//  WXCondition.h
//  SimpleWeather
//
//  Created by Duke on 10/27/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import <Mantle.h>
@import CoreGraphics;
#define apikey @"e85d42a3899e3566035a1455f3f84cea"

@class Coord,Main,Wind,Sys,Clouds,Weather;

@interface WXCondition : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *base;

@property (nonatomic, assign) NSInteger wxcondition_id;

@property (nonatomic, assign) NSInteger dt;

@property (nonatomic, strong) Main *main;

@property (nonatomic, strong) Coord *coord;

@property (nonatomic, strong) Wind *wind;

@property (nonatomic, strong) Sys *sys;

@property (nonatomic, strong) NSArray<Weather *> *weather;

@property (nonatomic, assign) NSInteger visibility;

@property (nonatomic, strong) Clouds *clouds;

@property (nonatomic, assign) NSInteger cod;

@property (nonatomic, copy) NSString *name;

-(NSString *)imageName;

@end

@interface Coord : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) CGFloat lon;

@property (nonatomic, assign) CGFloat lat;

@end

@interface Main : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger humidity;

@property (nonatomic, strong) NSNumber *temp_max;

@property (nonatomic, strong) NSNumber *temp_min;

@property (nonatomic, strong) NSNumber *temp;

@property (nonatomic, assign) NSInteger pressure;

@end

@interface Wind : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger speed;

@end

@interface Sys : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger sys_id;

@property (nonatomic, assign) CGFloat message;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger sunset;

@property (nonatomic, assign) NSInteger sunrise;

@end

@interface Clouds : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger all;

@end

@interface Weather : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger weather_id;

@property (nonatomic, copy) NSString *main;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *weather_description;

@end

