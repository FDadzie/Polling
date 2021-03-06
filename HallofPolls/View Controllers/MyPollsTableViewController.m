//
//  MyPollsTableViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/23/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "MyPollsTableViewController.h"
#import "Poll.h"
#import "PollQuestionCell.h"
#import "OptionsPreviewCell.h"
#import "PollCreationViewController.h"

@interface MyPollsTableViewController () <UITableViewDataSource, UITableViewDelegate,PollCreationViewControllerDelegate>

@property (strong, nonatomic) NSArray<Poll *> *myPolls;
@property (strong, nonatomic) UIRefreshControl *refresher;

@end

@implementation MyPollsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pollTableView.delegate = self;
    self.pollTableView.dataSource = self;
    
    [self beginRefresh:(UIRefreshControl *)_refresher];
    self.refresher = [[UIRefreshControl alloc] init];
    [self.refresher addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.pollTableView insertSubview: self.refresher atIndex:0];
    
    [self anotherQuery];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasVoted:) name:@"VotingNotification" object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)anotherQuery{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pollCreator == %@",[PFUser currentUser]];
    //What would the predicate format be?
    PFQuery *query = [PFQuery queryWithClassName:@"Poll" predicate:predicate];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"pollCreator"];
    
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Poll *> * _Nullable fetchedPolls, NSError * _Nullable error) {
        if(!error){
            // do something with data fetched
            self.myPolls = fetchedPolls;
            [self.pollTableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
            // handle errors
        }
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [self anotherQuery];
    [self.pollTableView reloadData];
    [refreshControl endRefreshing];
}

- (void)hasVoted:(NSNotification *)notification{
    [self anotherQuery];
    [self.pollTableView reloadData];
}
#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.myPolls count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Poll *refPoll = self.myPolls[section];
    
    return [refPoll.options count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Poll *accessPoll = self.myPolls[indexPath.section];
    PollQuestionCell *cell;
    
    NSInteger total = 0;
    
        for(int i = 0; i < [accessPoll.options count]; i++){
            if([accessPoll.voteArray count] > i){
                NSArray *temp = [accessPoll.voteArray objectAtIndex:i];
                total = total + [temp count];
            }
        }
    
    if(indexPath.row == 0){
        
        cell = [self.pollTableView dequeueReusableCellWithIdentifier:@"MyPollsCell" forIndexPath:indexPath];
        
        cell.createdQuestion.text = accessPoll.pollQuestion;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.totalVotes.text = [NSString stringWithFormat:@"%ld" , (long)total];
        
    } else if(indexPath.row > 0){
        OptionsPreviewCell *optionCell = [self.pollTableView dequeueReusableCellWithIdentifier:@"MyPollsOptionsCell" forIndexPath:indexPath];
        NSArray *accessArray = accessPoll.options;
        
        /*
        if(indexPath.row < [accessPoll.voteArray count]){
            NSArray *voters = [accessPoll.voteArray objectAtIndex:indexPath.row - 1];
            
            optionCell.optionName.text = [accessPoll.options objectAtIndex:indexPath.row - 1];
            optionCell.optionVotes.text = [NSString stringWithFormat:@"%ld", (long)[voters count]];
        }
         */
        
        if(indexPath.row <= accessArray.count){
        NSArray *accessVotes = [accessPoll.voteArray objectAtIndex:indexPath.row - 1];
            optionCell.myOptionName.text = [accessArray objectAtIndex:indexPath.row - 1];
            optionCell.myOptionVotes.text = [NSString stringWithFormat:@"%ld", (long)[accessVotes count]];
        }
        return optionCell;
        
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 101;
    }
    return 49;
}

- (void)myPollUpdate:(nonnull PollCreationViewController *)pollCreation {
    [self anotherQuery];
    [self.pollTableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PollCreationViewController *pc = [segue destinationViewController];
    //pc.gameList = self.gameList;
    pc.pollDelegate = self;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
