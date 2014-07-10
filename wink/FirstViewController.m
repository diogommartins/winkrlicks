//
//  FirstViewController.m
//  wink
//
//  Created by Diogo Magalhaes martins on 6/30/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import "FirstViewController.h"
#import "LocationTableViewCell.h"

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "PAImageView.h"
#import "UIColor+Crayola.h"

CGFloat const IMAGEVIEW_IMAGE_SIZE = 90.0;

@interface FirstViewController () 

@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) NSMutableDictionary * locationImages;


- (IBAction) toggleSidePanelVisibility: (UIBarButtonItem *)sender;
- (void) updateStatusWithLocation: (MKUserLocation *)location;
- (void) loadLocationImageForCellAndIndexPath: (NSArray *)objects;

-(void)performFacebookGraphAPIRequestForCoordinate: (CLLocationCoordinate2D)coordinate distance:(int)distance limit:(int)limit;
-(void)parseApiData:(NSDictionary *)places;

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationImages = [[NSMutableDictionary alloc] init];
    NSLog(@"Merda...");
    _mapView.zoomEnabled = YES;
    _mapView.showsPointsOfInterest = NO;
    _mapView.showsUserLocation = YES;
    
    [self zoomToCurrentLocation];
//    self.mapView.us
    [self.lblStatus setText: [NSString stringWithFormat:@"%f", self.mapView.userLocation.location.coordinate.latitude] ];
    // Do any additional setup after loading the view.
    
    [self performFacebookGraphAPIRequestForCoordinate: self.mapView.userLocation.coordinate
                                             distance: 100
                                                limit: 20];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateStatusWithLocation: (MKUserLocation *)location
{
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:0];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Latitude: %f Longitude: %f", location.coordinate.latitude, location.coordinate.longitude] ];
}

#pragma mark - MapView related functions

- (void)zoomToCurrentLocation{
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = _mapView.userLocation.coordinate.latitude;
    region.center.longitude = _mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [_mapView setRegion:region animated:YES];
}

-(void)performFacebookGraphAPIRequestForCoordinate: (CLLocationCoordinate2D)coordinate distance:(int)distance limit:(int)limit;
{
    NSString * coordinates = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
    [FBRequestConnection startWithGraphPath: @"/search"
                                 parameters: @{@"type": @"place",
                                               @"fields": @"category, category_list, id, location, name, picture",
                                               @"center": coordinates,
                                               @"limit": [NSString stringWithFormat:@"%d", limit],
                                               @"distance": [NSString stringWithFormat:@"%d", distance]}
                                 HTTPMethod: @"GET"
                          completionHandler: ^(FBRequestConnection *connection, id result, NSError *error) {
                              if(result){
                                  [self parseApiData:result[@"data"]];
                                  
                              }
                          }];
}

-(void)parseApiData:(NSDictionary *)places
{
    self.places = [NSMutableArray new];
    for (NSDictionary * place in places)
        [self.places addObject: [[WKPlace alloc] initWithFacebookPlaceDictionary:place]];    
    [self.tableView reloadData];
}

#pragma mark - MapView Delegate related functions

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    [self updateStatusWithLocation:userLocation];
    [self performFacebookGraphAPIRequestForCoordinate: userLocation.coordinate
                                             distance: 100
                                                limit: 20];
    
}
-loca

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)toggleSidePanelVisibility:(UIBarButtonItem *)sender {
    [self.sidePanelController showLeftPanelAnimated:YES];
}

#pragma mark TableView Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];    
    [cell.imageView setImage: [UIImage imageNamed:@"street_view-50-white"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKPlace * place = [self.places objectAtIndex:indexPath.row];
    cell.textLabel.text = place.name;
    
    if ([self.locationImages objectForKey:place.idPlace])
    {
        [cell.imageView addSubview:[self.locationImages objectForKey:place.idPlace]];
    }
    else{
        [NSThread detachNewThreadSelector:@selector(loadLocationImageForCellAndIndexPath:)
                                 toTarget:self
                               withObject:@[cell, indexPath, place]];
    }
}

- (void) loadLocationImageForCellAndIndexPath: (NSArray *)objects
{
    @autoreleasepool {
        UITableViewCell * cell = [objects objectAtIndex:0];
        NSIndexPath * indexPath = [objects objectAtIndex:1];
        WKPlace * place = [objects objectAtIndex:2];
        //        UIImageView * imageSubView = [UIImageView alloc]ini
        // Here we set the cell image
        cell.imageView.image = place.profilePicture;
        // Makes round image
        cell.imageView.layer.cornerRadius = IMAGEVIEW_IMAGE_SIZE /2;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.borderWidth = 2;
        cell.imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        cell.imageView.clipsToBounds = YES;
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage: cell.imageView.image];
        
        [self.locationImages setObject: imageView
                                forKey: place.idPlace];
    }
}


@end
