//
//  LoginViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/16/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.userTextfield.text;
    NSString *password = self.passTextfield.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError * _Nullable error) {
        if (error != nil){
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"showHome" sender:(nil)];
            // display Home Feed after successful login
        }
    }];
}

/*
- (IBAction)didTapSignUp:(id)sender {
    PFUser *newAcc = [PFUser user];
    
    newAcc.username = self.userTextfield.text;
    newAcc.password = self.passTextfield.text;
    
    [newAcc signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil){
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"showHome" sender:(nil)];
            // manual segue
        }
    }];
    
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
