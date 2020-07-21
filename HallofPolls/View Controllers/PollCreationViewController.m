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

@interface PollCreationViewController () <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *voteOptions;

@end

@implementation PollCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}
- (IBAction)tapAddOption:(id)sender {
    
    [self performSegueWithIdentifier:@"showPicker" sender:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showPicker"]) {
         
        // Get destination view
        GamePickerViewController *vc = [segue destinationViewController];
        
        [vc setChoices:_voteOptions];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    QuestionPreviewCell *question = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    question.questionPreview.delegate = self;
    
    if(indexPath.row > 0){
    OptionsPreviewCell *options = [tableView dequeueReusableCellWithIdentifier:@"OptionCell"];
        options.optionsPreview.text = [_voteOptions objectAtIndex:0];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


 */

@end
