//
//  MTLModel+NullableScalar.m
//  
//
//  Created by Duke on 10/29/15.
//
//

#import "MTLModel+NullableScalar.h"
#import "WXHourlyForecast.h"

@implementation MTLModel (NullableScalar)
-(void)setNilValueForKey:(NSString *)key
{
    [self setValue:@0 forKey:key];    
}
@end
