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
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log in failed" message:@"Password/Username is incorrect"
            preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
            style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * _Nonnull action) {
                
                
                // handle response here.
            }];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:^{
                self.passTextfield.text = @"";
                // optional code for what happens after the alert controller has finished presenting
            }];
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"showHome" sender:(nil)];
            // display Home Feed after successful login
        }
    }];
}


- (IBAction)didTapSignUp:(id)sender {
    [self performSegueWithIdentifier:@"showSignUp" sender:(nil)];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
