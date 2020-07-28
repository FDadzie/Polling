//
//  SettingsViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/27/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "SettingsViewController.h"
#import "GamePickerViewController.h"
#import "SettingsViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,GamePickerViewControllerDelegate>

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingsTable.delegate = self;
    self.settingsTable.dataSource = self;
    
    // Do any additional setup after loading the view.
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.originalImage = originalImage;
    self.editImage = editedImage;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showPicker2"]) {
        GamePickerViewController *target = [segue destinationViewController];
        target.delegate = self;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(indexPath.section == 0){
        cell = [self.settingsTable dequeueReusableCellWithIdentifier:@"Profile Picture" forIndexPath:indexPath];
    } else if(indexPath.section == 1){
        cell = [self.settingsTable dequeueReusableCellWithIdentifier:@"Favorite Game" forIndexPath:indexPath];
    } else if(indexPath.section == 2){
        cell = [self.settingsTable dequeueReusableCellWithIdentifier:@"Notifications" forIndexPath:indexPath];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if(indexPath.section == 1){
        [self performSegueWithIdentifier:@"showPicker2" sender:nil];
    }
}
- (void)gamePicker:(nonnull GamePickerViewController *)controller didPickItem:(nonnull NSString *)game {
    
}


@end
