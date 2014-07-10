//
//  LoginViewController.h
//  wink
//
//  Created by Diogo Magalhaes martins on 7/2/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginUIViewController : UIViewController <FBLoginViewDelegate>

- (UIStatusBarStyle)preferredStatusBarStyle;

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

@end
