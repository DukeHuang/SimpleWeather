//
//  WXClient.m
//  SimpleWeather
//
//  Created by Duke on 10/27/15.
//  Copyright © 2015 DU. All rights reserved.
//

#import "WXClient.h"
#import "WXCondition.h"
#import "WXDailyForecast.h"
#import "WXHourlyForecast.h"

@interface WXClient()

@property(nonatomic,strong)NSURLSession *session;

@end

@implementation WXClient

-(id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

-(RACSignal *)fetchJSONFromURL:(NSURL *)url {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //TODO: handle retrevied data
            if (!error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"\n\nFetching : %@ ===> %@",url.absoluteString,jsonString);
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error];
            }
            [subscriber sendCompleted];
        }];
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

/*
 By geographic coordinates
 API call:
 
 api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}
 Parameters:
 
 lat, lon coordinates of the location of your interest
 Examples of API calls:
 
 api.openweathermap.org/data/2.5/weather?lat=35&lon=139
 
 API respond:
 
 {"coord":{"lon":139,"lat":35},
 "sys":{"country":"JP","sunrise":1369769524,"sunset":1369821049},
 "weather":[{"id":804,"main":"clouds","description":"overcast clouds","icon":"04n"}],
 "main":{"temp":289.5,"humidity":89,"pressure":1013,"temp_min":287.04,"temp_max":292.04},
 "wind":{"speed":7.31,"deg":187.002},
 "rain":{"3h":0},
 "clouds":{"all":92},
 "dt":1369824698,
 "id":1851632,
 "name":"Shuzenji",
 "cod":200}
*/

-(RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%@",coordinate.latitude,coordinate.longitude,apikey];
    NSURL *url = [NSURL URLWithString:urlString];
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[WXCondition class] fromJSONDictionary:json error:nil];
    }];
}
-(RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&appid=%@",coordinate.latitude,coordinate.longitude,apikey];
    NSURL *url = [NSURL URLWithString:urlString];
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[WXHourlyForecast class] fromJSONDictionary:json error:nil];
    }];
}

-(RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&appid=%@&cnt=10",coordinate.latitude,coordinate.longitude,apikey];
    NSURL *url = [NSURL URLWithString:urlString];
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        //        WXDailyForecast *forecast = [MTLJSONAdapter modelOfClass:[WXDailyForecast class] fromJSONDictionary:json error:nil];
        return [MTLJSONAdapter modelOfClass:[WXDailyForecast class] fromJSONDictionary:json error:nil];
    }];
}

@end
