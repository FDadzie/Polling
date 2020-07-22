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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.voteOptions = [NSMutableArray array];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated {
    
    NSIndexSet *refSection = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)];
    [self.tableView reloadSections:refSection withRowAnimation:UITableViewRowAnimationNone];
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
    return 1;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    QuestionPreviewCell *question = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    
    if(indexPath.section == 1) {
        AddOptionCell *add = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
        add.addOption.tag = indexPath.row;
        return add;
        
    } else if(indexPath.section == 2){
    OptionsPreviewCell *options = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
        
        options.optionsPreview.text = @"Test Game Name";
        return options;
    }
    return question;
}

- (IBAction)didTapPost:(id)sender {
    NSString *prepareQuestion = [[_askQuestion textLabel] text];
    [Poll postPoll:_voteOptions withQuestion:prepareQuestion withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error){
            NSLog(@"Poll was successfully posted");
        } else {
            NSLog(@"Error posting poll");
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
     [self performSegueWithIdentifier:@"showPicker" sender:nil];
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

@end
