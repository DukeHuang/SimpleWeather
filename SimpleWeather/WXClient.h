//
//  WXClient.h
//  SimpleWeather
//
//  Created by Duke on 10/27/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>

@interface WXClient : NSObject

-(RACSignal *)fetchJSONFromURL:(NSURL *)url;
-(RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate;
-(RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate;
-(RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate;

@end
