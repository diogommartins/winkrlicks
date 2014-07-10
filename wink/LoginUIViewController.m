//
//  LoginViewController.m
//  wink
//
//  Created by Diogo Magalhaes martins on 7/2/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import "LoginUIViewController.h"
#import "UIImage+ImageEffects.h"

#import "SidePanelViewController.h"
#import "UIViewController+JASidePanel.h"

@interface LoginUIViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation LoginUIViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

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
    self.loginView.readPermissions = @[@"public_profile",
                                       @"email",
                                       @"user_friends",
                                       @"user_birthday",
                                       @"user_photos",
                                       @"user_about_me",
                                       @"user_likes"];
    
    self.backgroundImage.image = [self.backgroundImage.image applyBlurWithRadius:5.0 tintColor:[UIColor clearColor]
                                                           saturationDeltaFactor:1.0
                                                                       maskImage:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Facebook Delegate methods
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSUserDefaults * userDefaults = [NSUserDefaults new];
    BOOL firstLogin = [userDefaults boolForKey:@"firstLogin"];
    
    // Se estiver logando pela primeira vez, armazena a flag e a data
    if (!firstLogin)
    {
        [userDefaults setBool:YES forKey:@"firstLogin"];
        [userDefaults setObject:[NSDate date] forKey:@"firstLoginDate"];
    }
// Armazenar dados do usuário no coredata
    
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - Navigation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
//    self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[FirstViewController new]];
    self.sidePanelController.centerPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"firstViewController"];
}

@end
