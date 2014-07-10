//
//  WKLocation.m
//  wink
//
//  Created by Diogo Magalhaes Martins on 7/8/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import "WKLocation.h"

@implementation WKLocation

-(id)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.city = [dict objectForKey:@"city"];
        self.country = [dict objectForKey:@"country"];
        self.coordinates = CLLocationCoordinate2DMake([(NSString *)[dict objectForKey:@"latitude"] doubleValue],
                                                      [(NSString *)[dict objectForKey:@"latitude"] doubleValue]);
        self.state = [dict objectForKey:@"state"];
        self.street = [dict objectForKey:@"street"];
        self.zip = [dict objectForKey:@"zip"];
        
    }
    return self;
}

@end
