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
#import "ProfilePictureCell.h"
#import "GamePickerCell.h"
#import "GenrePickerCell.h"
#import <Parse/Parse.h>
#import "Profile.h"

@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GamePickerViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *genreArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    
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

/*
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
*/



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showPicker2"]) {
           GamePickerViewController *target = [segue destinationViewController];
           target.delegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


/*
- (void)profileDataTransfer:(nonnull SettingsViewController *)preferences changeImage:(nonnull UIImage *)image changeGame:(nonnull NSString *)favorite {
    self.profileImage.image = image;
    self.favGame.text = favorite;
}
*/
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    //ProfilePictureCell *picture = [self.profileTableView cellForRowAtIndexPath:<#(nonnull NSIndexPath *)#>]
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return 171;
        }
    }
    return 43.5;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Profile";
    } else if(section == 1){
        return @"Favorite Game Genres";
    } else {
        return @"Settings";
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ProfilePictureCell *profile;
    GamePickerCell *game;
    UITableViewCell *cell;
    GenrePickerCell *genre;
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            profile = [tableView dequeueReusableCellWithIdentifier:@"Profile Banner"];
            
            return profile;
        } else if(indexPath.row == 1){
            profile = [tableView dequeueReusableCellWithIdentifier:@"Profile User"];
            
            profile.profileUser.text = [PFUser currentUser].username;
            return profile;
        } else if(indexPath.row == 2){
            game = [tableView dequeueReusableCellWithIdentifier:@"Favorite Game"];
            
            return game;
        } else if (indexPath.row == 3){
            cell = [tableView dequeueReusableCellWithIdentifier:@"AddGenre"];
            
            return cell;
        }
    } else if(indexPath.section == 1){
        genre = [tableView dequeueReusableCellWithIdentifier:@"Genre Cell"];
        
        return genre;
    } else if(indexPath.section == 2){
        
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"Change Picture"];
            
            return cell;
        } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Notifications"];
        
        return cell;
        }
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 4;
    } else if(section == 1){
        return 1;
        //[self.genreArray count];
    } else {
        return 2;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 2){
            [self performSegueWithIdentifier:@"showPicker2" sender:nil];
        }
    } else if(indexPath.section == 1){
           // Delete cell if tapped
            [self.genreArray removeObjectAtIndex:indexPath.row];
            [self.profileTableView reloadData];
    } else if(indexPath.section == 2){
        if(indexPath.row == 0){
            UIImagePickerController *imagePicker = [UIImagePickerController new];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}

- (void)gamePicker:(nonnull GamePickerViewController *)controller didPickItem:(nonnull NSString *)game itemImage:(nonnull UIImage *)gameimage {
    
}

@end
