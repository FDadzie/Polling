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
        if (error != nil){
            NSLog(@"Error: %@", error.localizedDescription);
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
