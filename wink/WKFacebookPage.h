//
//  WKPage.h
//  wink
//
//  Created by Diogo Magalhaes Martins on 7/8/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKPlace.h"

@interface WKFacebookPage : NSObject

@property (strong,nonatomic) WKPlace * place;
@property (strong,nonatomic,readonly) NSString * phone;
@property (strong,nonatomic,readonly) NSString * link;
@property (strong,nonatomic,readonly) NSString * description;
@property (strong,nonatomic,readonly) NSString * website;

@property (readonly) long likes;
@property (readonly) long checkins;

-(id) initWithFacebookPageDictionary: (NSDictionary *)dict place:(WKPlace *)place;

@end
