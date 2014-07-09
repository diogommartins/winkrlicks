//
//  Place.m
//  wink
//
//  Created by Diogo Magalhaes Martins on 7/8/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import "WKPlace.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation WKPlace

-(id)initWithFacebookPlaceDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.category = [dict objectForKey:@"category"];
        self.categoryList = [dict objectForKey:@"category_list"];
        self.idPlace = [dict objectForKey:@"id"];
        self.location = [[WKLocation alloc] initWithDictionary: [dict objectForKey:@"location"]];
        self.name = [dict objectForKey:@"name"];
        
        BOOL hasImage = ![(NSString *)dict[@"picture"][@"data"][@"is_silhouette"] boolValue];
        if ( hasImage ){
            NSURL * imageURL = [NSURL URLWithString: dict[@"picture"][@"data"][@"url"] ];
            self.profilePicture = [UIImage imageWithData:[NSData dataWithContentsOfURL: imageURL] ];
        }
        else
            self.profilePicture = [UIImage imageNamed:@"street-view-90-white"];
    }
    return self;
}

-(NSString *)graphPath
{
    return [NSString stringWithFormat:@"/%@", self.idPlace];
}

@end
