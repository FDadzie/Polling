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

@interface ProfileViewController () <GamePickerViewControllerDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)gamePicker:(nonnull GamePickerViewController *)controller didPickItem:(nonnull NSString *)game {
    self.favGame.text = game;
}

@end
