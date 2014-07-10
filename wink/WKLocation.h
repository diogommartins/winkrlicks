//
//  WKLocation.h
//  wink
//
//  Created by Diogo Magalhaes Martins on 7/8/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WKLocation : NSObject

@property (strong,nonatomic) NSString * city;
@property (strong,nonatomic) NSString * country;
@property (nonatomic) CLLocationCoordinate2D coordinates;
@property (strong,nonatomic) NSString * state;
@property (strong,nonatomic) NSString * street;
@property (strong,nonatomic) NSString * zip;

- (id) initWithDictionary: (NSDictionary *)dict;

@end
