//
//  SignUpViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/28/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapSignUp:(id)sender {
    PFUser *newAcc = [PFUser user];
    newAcc.username = self.signUpUsername.text;
    newAcc.password = self.signUpPassword.text;
    newAcc.email = self.signUpEmail.text;
    
    [newAcc signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        
        if(self.signUpUsername.text.length == 0){
            NSLog(@"Error: %@", error.localizedDescription);
            UIAlertController *userAlert = [UIAlertController alertControllerWithTitle:@"Sign Up failed" message:@"No Username was given" preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // handle response here.
                [newAcc deleteInBackground];
            }];
            [userAlert addAction:okAction];
            
            [self presentViewController:userAlert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
                
                self.signUpConfirm.text = @"";
            }];
        } else if(![self.signUpPassword.text isEqualToString:self.signUpConfirm.text]){
            
            NSLog(@"Error: %@", error.localizedDescription);
            UIAlertController *confirmAlert = [UIAlertController alertControllerWithTitle:@"Sign Up failed" message:@"Passwords do not match" preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // handle response here.
                [newAcc deleteInBackground];
            }];
            [confirmAlert addAction:okAction];
            
            [self presentViewController:confirmAlert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
                self.signUpConfirm.text = @"";
            }];
            
        } else if(self.signUpEmail.text.length == 0){
            
            NSLog(@"Error: %@", error.localizedDescription);
            UIAlertController *emailAlert = [UIAlertController alertControllerWithTitle:@"Sign Up failed" message:@"No Email was entered" preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // handle response here.
                [newAcc deleteInBackground];
            }];
            [emailAlert addAction:okAction];
            
            [self presentViewController:emailAlert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
                
                self.signUpConfirm.text = @"";
            }];
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"presentHome" sender:(nil)];
            // manual segue
            
        }
    }];
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
