//
//  WXManager.m
//  SimpleWeather
//
//  Created by Duke on 10/27/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import "WXManager.h"
#import "WXDailyForecast.h"


@interface WXManager() <CLLocationManagerDelegate>



@end



@implementation WXManager

+(instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken,^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

-(id)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _client = [[WXClient alloc] init];
        
        [[[[RACObserve(self, currentLocation) ignore:nil]
           flattenMap:^(CLLocation *newLocation) {
            return [RACSignal merge:@[
                                      [self updateCurrentConditions],
                                      [self updateHourlyforecast],
                                      [self updateDailyForecast]
                                      ]];
            
        }]
          deliverOn:RACScheduler.mainThreadScheduler] subscribeError:^(NSError *error) {
            [TSMessage showNotificationWithTitle:@"Error" subtitle:@"There was a problem fetching the latest weatehr" type:TSMessageNotificationTypeError];
        }];
    }
    return self;
}

-(void)findCurrentLocation {
    self.isFirstUpdate = YES;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
}

#pragma mark- CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (self.isFirstUpdate) {
        self.isFirstUpdate = NO;
        return;
    }
    CLLocation *location = [locations lastObject];
    
    if (location.horizontalAccuracy > 0) {
        self.currentLocation = location;
        [self.locationManager stopUpdatingLocation];
    }
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
//             NSLog(@"%@",placemark.name);
//             NSString *province =  placemark.administrativeArea;
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             self.cityName = city;
         }
         
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];

}

-(RACSignal *)updateCurrentConditions{
    return [[self.client fetchCurrentConditionsForLocation:self.currentLocation.coordinate] doNext:^( WXCondition *conditon) {
        self.currentCondition  = conditon;
    }];
}
-(RACSignal *)updateDailyForecast {
    return [[self.client fetchDailyForecastForLocation:self.currentLocation.coordinate]
            doNext:^( WXDailyForecast *forecast) {
                self.dailyForecast = forecast.list;
            }];
}
-(RACSignal *)updateHourlyforecast {
    return [[self.client fetchHourlyForecastForLocation:self.currentLocation.coordinate] doNext:^(WXHourlyForecast *forecast) {
        self.hourlyForecast = forecast.list;
    }];
}

@end
