//
//  DefaultsViewController.m
//  wink
//
//  Created by Diogo Magalhaes martins on 7/7/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

#import "DefaultsViewController.h"
#import "UIImage+ImageEffects.h"
#import "UIColor+Crayola.h"

@interface DefaultsViewController ()

@property (strong, nonatomic) NSUserDefaults * userDefaults;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *lblMatchGender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchGenderSelector;
@property (weak, nonatomic) IBOutlet NMRangeSlider *idadeRangeSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblIdadeMin;
@property (weak, nonatomic) IBOutlet UILabel *lblIdadeMax;

- (IBAction)changePreferedMatchGender:(UISegmentedControl *)sender;
- (IBAction)idadeRangeChanged:(NMRangeSlider *)sender;

- (NSString *)formatIdadeFromFloat:(float)idade;

@end

@implementation DefaultsViewController

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
    
    
    [self idadeRangeSlider];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.idadeRangeSlider.minimumValue = 0.18;
    self.idadeRangeSlider.maximumValue = 0.50;
    self.idadeRangeSlider.stepValue = 0.01;
    self.idadeRangeSlider.minimumRange = 0.05;
    self.idadeRangeSlider.stepValueContinuously = YES;
    
    [self loadUserDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUserDefaults
{
    float idadeMin = [self.userDefaults floatForKey:@"idadeMin"];
    float idadeMax = [self.userDefaults floatForKey:@"idadeMax"];
    
    // Set user defaults for idadeSlider
    if (idadeMin && idadeMax){
        self.idadeRangeSlider.lowerValue = idadeMin;
        self.idadeRangeSlider.upperValue = idadeMax;
        self.lblIdadeMin.text = [self formatIdadeFromFloat: idadeMin];
        self.lblIdadeMax.text = [self formatIdadeFromFloat: idadeMax];
    }
    else{
        self.idadeRangeSlider.lowerValue = 0.20;
        self.idadeRangeSlider.upperValue = 0.30;
    }
    // Set default gender
    int matchGender = [self.userDefaults integerForKey:@"matchGender"];
    if (matchGender)
        [self.matchGenderSelector setSelectedSegmentIndex:matchGender];
    
    [self applyTintColor:[UIColor crayola_Bittersweet_Color]
             toImageView:[self.lblMatchGender objectAtIndex:matchGender]];
}

- (IBAction)changePreferedMatchGender:(UISegmentedControl *)sender {
    UIImageView * currentTintedImageView = [self.lblMatchGender objectAtIndex:sender.selectedSegmentIndex];
    for (UIImageView * imageView in self.lblMatchGender) {
        if (imageView == currentTintedImageView)
            [self applyTintColor:[UIColor crayola_Bittersweet_Color]
                     toImageView: imageView];
        else
            [self applyTintColor:[UIColor lightGrayColor]
                     toImageView: imageView];
    }
    // Store the selected gender
    [_userDefaults setInteger:sender.selectedSegmentIndex forKey:@"matchGender"];
    [_userDefaults synchronize];
}

-(void)applyTintColor:(UIColor *)color toImageView:(UIImageView *)imageView
{
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imageView.tintColor = color;
    
}

#pragma mark Methods for Age related slider

- (IBAction)idadeRangeChanged:(NMRangeSlider *)sender {
    self.lblIdadeMin.text = [self formatIdadeFromFloat: _idadeRangeSlider.lowerValue];
    self.lblIdadeMax.text = [self formatIdadeFromFloat: _idadeRangeSlider.upperValue];
    
    [_userDefaults setFloat: self.idadeRangeSlider.lowerValue forKey:@"idadeMin"];
    [_userDefaults setFloat: self.idadeRangeSlider.upperValue forKey:@"idadeMax"];
    
    [_userDefaults synchronize];
}

- (NSString *)formatIdadeFromFloat:(float)idade
{
    return [NSString stringWithFormat:@"%d", (int) round(idade * 100)];
}
@end
