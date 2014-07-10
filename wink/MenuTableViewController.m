//
//  MenuTableViewController.m
//  wink
//
//  Created by Diogo Magalhaes martins on 6/30/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import "MenuTableViewController.h"
#import "SidePanelViewController.h"
#import "UIViewController+JASidePanel.h"

#import "PAImageView.h"
#import "UIImage+ImageEffects.h"
#import "UIColor+Crayola.h"


#import "DefaultsViewController.h"
#import "FirstViewController.h"

@interface MenuTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) PAImageView * avatarView;
@property (strong,nonatomic) NSString * profilePictureURL;

- (void) loadAvatarView;
@end

@implementation MenuTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.profilePictureURL = @"https://scontent-b.xx.fbcdn.net/hphotos-xpa1/t1.0-9/10173682_745316542157414_1941861171616365990_n.jpg";
    
    [self setBackgroundImage];
//    [self loadAvatarView];
    [NSThread detachNewThreadSelector:@selector(loadAvatarView) toTarget:self withObject:nil];
}

- (void) loadAvatarView
{
    self.avatarView = [[PAImageView alloc] initWithFrame:[self.profileImage bounds]
                                 backgroundProgressColor:[UIColor whiteColor]
                                           progressColor:[UIColor lightGrayColor]];
    
    //    UIImage * rawLightImage = [rawImage applyExtraLightEffect];
    
    [self.profileImage addSubview:self.avatarView];
    // Later
    [self.avatarView setImageURL:[NSURL URLWithString:self.profilePictureURL]];
}

- (void) setBackgroundImage
{
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.profilePictureURL]]];
    image = [image applyBlurWithRadius:7.0
                                tintColor:[UIColor clearColor]
                    saturationDeltaFactor:1.0
                                maskImage:nil];
    
//    image = [image applyLightEffect];
    UIImageView * backgroundImageView = [[UIImageView alloc]initWithImage:image];
    [backgroundImageView setContentMode:UIViewContentModeCenter];
    self.tableView.backgroundView = backgroundImageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        cell.backgroundView = nil;
        cell.backgroundColor = [UIColor clearColor]; //set image for cell 0

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    switch (indexPath.row) {
        case 1:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[DefaultsViewController alloc] init]];
        case 2:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
            break;
            
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
