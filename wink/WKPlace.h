//
//  Place.h
//  wink
//
//  Created by Diogo Magalhaes Martins on 7/8/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKLocation.h"

@interface WKPlace : NSObject

@property (strong,nonatomic) NSNumber * idPlace;
@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSString * category;
@property (strong,nonatomic) NSDictionary * categoryList;
@property (strong,nonatomic) WKLocation * location;
@property (strong,nonatomic) UIImage * profilePicture;

-(id)initWithFacebookPlaceDictionary: (NSDictionary *) dict;

@end
