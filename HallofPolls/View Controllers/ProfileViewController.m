//
//  ProfileViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/27/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "ProfileViewController.h"
#import "GamePickerViewController.h"
#import "ProfilePictureCell.h"
#import "GamePickerCell.h"
#import "GenrePickerCell.h"
#import <Parse/Parse.h>
#import "Profile.h"

@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GamePickerViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *genreArray;
@property (strong, nonatomic) UIImage *bannerCache;
@property (strong, nonatomic) UIImage *imageCache;
@property (strong, nonatomic) NSString *favoriteCache;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    
    if(self.currentUser == nil) {
        [self makeUserQuery];
    } else {
        
    }
}

-(void) makeUserQuery{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId = [c] %@",[PFUser currentUser].objectId];
    PFQuery *query = [PFQuery queryWithClassName:@"Profile" predicate:predicate];
    [query includeKey:@"userId"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if(!error){
            ProfilePictureCell *picture = [self.profileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            GamePickerCell *game = [self.profileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            self.currentUser = (Profile *)object;
            
            [self.currentUser.userImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                picture.profileImage.image = [UIImage imageWithData:data];
            }];
            
            [self.currentUser.userBanner getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                if(!error){
                    picture.profileBanner.image = [UIImage imageWithData:data];
                }
            }];
            
            game.favGame.text = self.currentUser.favGame;
        }
        
    }];
}


- (IBAction)didTapSave:(id)sender {
    ProfilePictureCell *profileImages = [self.profileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    GamePickerCell *game = [self.profileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if(self.currentUser == nil){
        [Profile saveUserData:[PFUser currentUser].username withFavorite:game.favGame.text withImage:profileImages.profileImage.image withBanner:profileImages.profileBanner.image withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if(!error){
                NSLog(@"User data was successfully saved");
            } else {
                NSLog(@"Error saving user data");
                NSLog(@"%@", error.localizedDescription);
            }
        }];
    } else {
        //update the object instead
        
    }
        
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved User" message:@"User profile was saved" preferredStyle:(UIAlertControllerStyleAlert)];
        
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // handle response here.
    }];
    [alert addAction:okAction];
        
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}




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
    ProfilePictureCell *userImage = [self.profileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    //UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    userImage.profileImage.image = editedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.profileTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return 270;
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
            
            profile.profileImage.layer.cornerRadius = profile.profileImage.frame.size.height/2;
            profile.profileImage.layer.masksToBounds = YES;
            profile.profileImage.layer.borderWidth = 0;
            profile.profileUser.text = [PFUser currentUser].username;
            return profile;
        } else if(indexPath.row == 1){
            game = [tableView dequeueReusableCellWithIdentifier:@"Favorite Game"];
            
            return game;
        } else if (indexPath.row == 2){
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
        return 3;
    } else if(section == 1){
        return 1;
        //[self.genreArray count];
    } else {
        return 2;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 1){
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
    GamePickerCell *favorite = [self.profileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ProfilePictureCell *banner = [self.profileTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    banner.profileBanner.image = gameimage;
    favorite.favGame.text = game;
    [self.profileTableView reloadData];
}


@end
