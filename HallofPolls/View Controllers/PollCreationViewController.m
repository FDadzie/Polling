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
#import "AddOptionCell.h"
#import <Parse/Parse.h>
#import "GamePickerViewController.h"


@interface PollCreationViewController () <UITableViewDelegate, UITableViewDataSource, GamePickerViewControllerDelegate>

@property (strong,nonatomic) NSMutableArray *voteOptions;

@end

@implementation PollCreationViewController

@synthesize askQuestion;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.voteOptions = [NSMutableArray array];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showPicker"]) {
        
        [self.tableView reloadData];
        
        // Get destination view
        GamePickerViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.choices = self.voteOptions;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 2) {
    return [self.voteOptions count];
    }
    return 1;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    self.askQuestion = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    
    if(indexPath.section == 1) {
        AddOptionCell *add = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
        
        return add;
        
    } else if(indexPath.section == 2){
        OptionsPreviewCell *options = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
        
        options.optionsPreview.text = [self.voteOptions objectAtIndex:indexPath.row];
        return options;
    }
    return self.askQuestion;
}

- (IBAction)didTapPost:(id)sender {
    UITextField *enteredText = askQuestion.questionPreview;
    NSString *properText = [enteredText text];
    
    [Poll postPoll:_voteOptions withQuestion:properText withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error){
            
            NSLog(@"Poll was successfully posted");
        } else {
            NSLog(@"Error posting poll");
        }
    }];
    // Moves back to Poll View
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
     [self performSegueWithIdentifier:@"showPicker" sender:nil];
    }
    if(indexPath.section == 2){
       // Delete cell if tapped
       // Maybe utilize an edit mode?
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


 */

- (void) gamePicker:(GamePickerViewController *)controller didPickItem:(NSString *)game{
    NSIndexSet *refSection = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)];
    [self.tableView reloadSections:refSection withRowAnimation:UITableViewRowAnimationNone];
}

@end
