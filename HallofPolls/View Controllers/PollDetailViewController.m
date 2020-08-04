//
//  PollDetailViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/30/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "PollDetailViewController.h"
#import "OptionsPreviewCell.h"
#import "Poll.h"
#import <Parse/Parse.h>

@interface PollDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger storedIndexPath;
@property (nonatomic, strong) NSMutableArray *pendingVotes;
@property (nonatomic, assign) BOOL hasVoted;

@end

@implementation PollDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    
    self.detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    self.pendingVotes = self.chosenPoll.voteArray;
    
    [self setHasVoted:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.chosenPoll.options count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.chosenPoll.pollQuestion;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    OptionsPreviewCell *voteOption = [self.detailTableView dequeueReusableCellWithIdentifier:@"OptionDetail"];
    
    if([self.chosenPoll.voteArray count] != [self.chosenPoll.options count]){
        NSInteger votes = 0;
        [self.chosenPoll.voteArray insertObject:[NSNumber numberWithInteger:votes] atIndex:indexPath.row];
        [self.chosenPoll saveInBackground];
    }
    
    voteOption.optionName.text = [self.chosenPoll.options objectAtIndex:indexPath.row];
    voteOption.optionVotes.text = [[self.chosenPoll.voteArray objectAtIndex:indexPath.row]stringValue];
    return voteOption;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // OptionsPreviewCell *currentCell = [self.detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
   // OptionsPreviewCell *previousCell = [self.detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.storedIndexPath inSection:0]];

    NSInteger increase = [[self.pendingVotes objectAtIndex:indexPath.row]integerValue];
    
    //TODO: Code Below Needs Edit
    if(self.hasVoted == NO){
        increase++;
        [self.pendingVotes replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInteger:increase]];
        self.storedIndexPath = indexPath.row;
        //currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.chosenPoll.voteArray = self.pendingVotes;
        [self.chosenPoll saveInBackground];
        [self setHasVoted:YES];
        
    } else if(self.storedIndexPath != indexPath.row && self.hasVoted == YES){
        NSInteger decrease = [[self.pendingVotes objectAtIndex:self.storedIndexPath]integerValue];
        decrease--;
        increase++;
        [self.pendingVotes replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInteger:increase]];
        [self.pendingVotes replaceObjectAtIndex:self.storedIndexPath withObject:[NSNumber numberWithInteger:decrease]];
        //previousCell.accessoryType = UITableViewCellAccessoryNone;
        //currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.storedIndexPath = indexPath.row;
        self.chosenPoll.voteArray = self.pendingVotes;
        
        [self.chosenPoll saveInBackground];
        
        [self.detailTableView reloadData];
        
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
