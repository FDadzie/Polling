//
//  PollCreationViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "PollCreationViewController.h"
#import "Poll.h"
#import "QuestionPreviewCell.h"
#import "OptionsPreviewCell.h"
#import <Parse/Parse.h>
#import "GamePickerViewController.h"
#import "PollDescriptionCell.h"



@interface PollCreationViewController () <UITableViewDelegate, UITableViewDataSource, GamePickerViewControllerDelegate>

@property (strong,nonatomic) NSMutableArray *voteOptions;

@end

@implementation PollCreationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.voteOptions = [NSMutableArray array];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView reloadData];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return 230;
    }
    return 43.5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 3) {
    return [self.voteOptions count];
    }
    return 1;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    QuestionPreviewCell *askQuestion;
    
    UITableViewCell *cell;
    
    if(indexPath.section == 0){
        askQuestion = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
        
    } else if(indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
        
        return cell;
        
    } else if(indexPath.section == 3){
        OptionsPreviewCell *options = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
        
        options.optionsPreview.text = [self.voteOptions objectAtIndex:indexPath.row];
        
        return options;
    } else if (indexPath.section == 1){
        PollDescriptionCell *description = [tableView dequeueReusableCellWithIdentifier:@"DescriptionCell"];
        
        return description;
    }
    return askQuestion;
}

- (IBAction)didTapPost:(id)sender {
    QuestionPreviewCell *pullQuestion = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    PollDescriptionCell *pullDescription = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    if([pullQuestion.questionPreview.text isEqualToString:@""] || [self.voteOptions count] == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Poll" message:@"Poll is missing Question and/or Options" preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // handle response here.
        }];
        [alert addAction:okAction];
    
        [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
        }];
    
    } else {
        
        UITextField *enteredText = pullQuestion.questionPreview;
        NSString *properText = [enteredText text];
    
        [Poll postPoll:_voteOptions withQuestion:properText withDescription:pullDescription.descPreview.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if(!error){
                NSLog(@"Poll was successfully posted");
            } else {
                NSLog(@"Error posting poll");
            }
        }];
        // Moves back to Poll View
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PollCreatedNotification" object:self];
        [self.pollDelegate myPollUpdate:self];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 2){
     [self performSegueWithIdentifier:@"showPicker" sender:nil];
    }
    if(indexPath.section == 3){
       // Delete cell if tapped
        [self.voteOptions removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

 - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if([[segue identifier] isEqualToString:@"showPicker"]) {
 
 [self.tableView reloadData];
 
 // Get destination view
 GamePickerViewController *vc = [segue destinationViewController];
 vc.delegate = self;
    }
 }

- (void) gamePicker:(GamePickerViewController *)controller didPickItem:(NSString *)game itemImage:(UIImage *)gameimage{
   
    NSIndexSet *refSection = [NSIndexSet indexSetWithIndex:3];
    //NSIndexSet *arrayCheck = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.voteOptions count])];
    if(![self.voteOptions containsObject:game]){
        [self.voteOptions addObject:game];
    }
    [self.tableView reloadSections:refSection withRowAnimation:UITableViewRowAnimationFade];
    
}

@end
