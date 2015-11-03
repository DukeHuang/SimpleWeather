//
//  WXManager.h
//  SimpleWeather
//
//  Created by Duke on 10/27/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import "WXClient.h"
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import "WXCondition.h"
#import <TSMessage.h>
#import "WXHourlyForecast.h"

@interface WXManager : NSObject

@property(nonatomic,strong,readwrite) WXCondition *currentCondition;
@property(nonatomic,strong,readwrite) CLLocation *currentLocation;
@property(nonatomic,strong,readwrite) NSArray *hourlyForecast;
@property(nonatomic,strong,readwrite) NSArray *dailyForecast;
@property(nonatomic,strong,readwrite) NSString *cityName;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
@property (nonatomic, strong) WXClient *client;


+(instancetype)sharedManager;
-(void)findCurrentLocation;

@end
