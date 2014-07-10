//
//  FirstViewController.h
//  wink
//
//  Created by Diogo Magalhaes martins on 6/30/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "WKPlace.h"

@interface FirstViewController : UIViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak,nonatomic) IBOutlet MKMapView *mapView;
@property (weak,nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray * places;

-(void)zoomToCurrentLocation;

@end

extern CGFloat const IMAGEVIEW_IMAGE_SIZE;
