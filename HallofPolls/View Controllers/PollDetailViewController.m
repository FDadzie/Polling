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
#import "PollDetailDescriptionCell.h"
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
    
    //self.detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.detailTableView.estimatedRowHeight = 230;
    self.detailTableView.rowHeight = UITableViewAutomaticDimension;
    
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
    
    if(indexPath.row == [self.chosenPoll.options count]){
        return 230;
    }
    
    return 64;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.chosenPoll.options count] + 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
 
    return self.chosenPoll.pollQuestion;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PollDetailDescriptionCell *description;
    
    if(indexPath.row == [self.chosenPoll.options count]){
        
        description = [self.detailTableView dequeueReusableCellWithIdentifier:@"Detail Description"];
        
        description.detailDescription.text = [self.chosenPoll pollDescription];
        [description.detailDescription sizeToFit];
        return description;
    } else {
        OptionsPreviewCell *voteOption = [self.detailTableView dequeueReusableCellWithIdentifier:@"OptionDetail"];
        
        if(indexPath.row < [self.chosenPoll.voteArray count]){
            NSArray *voters = [self.chosenPoll.voteArray objectAtIndex:indexPath.row];
            
            voteOption.optionName.text = [self.chosenPoll.options objectAtIndex:indexPath.row];
            voteOption.optionVotes.text = [NSString stringWithFormat:@"%ld", (long)[voters count]];
        }
        
        return voteOption;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row < [self.chosenPoll.options count]){
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VotingNotification" object:self];
    [tableView reloadData];
    
    }
    //TODO: CHANGE FROM RELOAD DATA API
    
    
    //[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
