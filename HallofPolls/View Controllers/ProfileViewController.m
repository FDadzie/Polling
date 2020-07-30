//
//  ProfileViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/27/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingsViewController.h"
#import "GamePickerViewController.h"
#import <Parse/Parse.h>
#import "Profile.h"

@interface ProfileViewController ()<SettingsViewControllerDelegate>


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profileUser.text = [PFUser currentUser].username;
    
}

-(void) makeUserQuery{
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    query.limit = 1;
    [query findObjectsInBackgroundWithBlock:^( fetchedProfile, NSError * _Nullable error) {
        if(!error){
            // do something with data fetched
        } else {
            // handle errors
        }
    }];
     */
}

- (IBAction)didTapSave:(id)sender {
    [Profile saveUserData:self.profileUser.text withFavorite:self.favGame.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error){
            NSLog(@"User data was successfully saved");
        } else {
            NSLog(@"Error saving user data");
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showSettings"]){
     SettingsViewController *settings = [segue destinationViewController];
        settings.settingsDelegate = self;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



- (void)profileDataTransfer:(nonnull SettingsViewController *)preferences changeImage:(nonnull UIImage *)image changeGame:(nonnull NSString *)favorite {
    self.profileImage.image = image;
    self.favGame.text = favorite;
}

@end
