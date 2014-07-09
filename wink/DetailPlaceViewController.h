//
//  DetailPlaceViewController.h
//  wink
//
//  Created by Diogo Magalhaes Martins on 7/8/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKPlace.h"

@interface DetailPlaceViewController : UIViewController

@property (strong,nonatomic) WKPlace * place;


-(id)initwithPlace: (WKPlace *) place ;

@end
