//
//  PollCreationViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "PollCreationViewController.h"

@interface PollCreationViewController ()

@end

@implementation PollCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)tapAddOption:(id)sender {
    [self performSegueWithIdentifier:@"showPicker" sender:nil];
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
