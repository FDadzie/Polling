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

@end

@implementation PollDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    
    self.detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    self.pendingVotes = self.chosenPoll.voteArray;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View Data Sources
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.chosenPoll.options count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.chosenPoll.pollQuestion;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *description;
    OptionsPreviewCell *voteOption = [self.detailTableView dequeueReusableCellWithIdentifier:@"OptionDetail"];
    
    NSArray *voters = [self.chosenPoll.voteArray objectAtIndex:indexPath.row];
    
    voteOption.optionName.text = [self.chosenPoll.options objectAtIndex:indexPath.row];
    voteOption.optionVotes.text = [NSString stringWithFormat:@"%ld", (long)[voters count]];
    return voteOption;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // OptionsPreviewCell *currentCell = [self.detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
   // OptionsPreviewCell *previousCell = [self.detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.storedIndexPath inSection:0]];
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.chosenPoll.voteArray];
    
    
    
    for(int i = 0; i < [self.chosenPoll.voteArray count]; i++){
        if(indexPath.row == i){
            NSMutableArray *roll = [NSMutableArray arrayWithArray:[array objectAtIndex:i]];
            if(![roll containsObject:[PFUser currentUser].objectId]){
                [roll addObject:[PFUser currentUser].objectId];
            }
            [array replaceObjectAtIndex:i withObject:roll];
        } else if(indexPath.row != i){
            NSMutableArray *other = [NSMutableArray arrayWithArray:[array objectAtIndex:i]];
            if([other containsObject:[PFUser currentUser].objectId]){
                [other removeObject:[PFUser currentUser].objectId];
            }
            [array replaceObjectAtIndex:i withObject:other];
        }
        
    }
    self.chosenPoll.voteArray = array;
    
    [self.chosenPoll saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            // something
        } else{
            // something
        }
    }];
    //[self.chosenPoll.voteArray replaceObjectAtIndex:<#(NSUInteger)#> withObject:<#(nonnull id)#>];
    
    [tableView reloadData];

    //TODO: CHANGE FROM RELOAD DATA API
    
    
    //[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
@end

/*
 NSInteger increase = [[self.pendingVotes objectAtIndex:indexPath.row]integerValue];
 
 //TODO: Code Below Needs Edit
 if(![roll containsObject:[PFUser currentUser].objectId]){
 //[self.pendingVotes replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInteger:increase]];
 //self.storedIndexPath = indexPath.row;
 //currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
 //self.chosenPoll.voteArray = self.pendingVotes;
 [self.chosenPoll saveInBackground];
 [self.detailTableView reloadData];
 
 
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
 */
