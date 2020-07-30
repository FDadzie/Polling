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
@property (nonatomic) NSUInteger counter;

@end

@implementation MyPollsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pollTableView.delegate = self;
    self.pollTableView.dataSource = self;
    
    [self resetCounter];
    
    [self beginRefresh:(UIRefreshControl *)_refresher];
    self.refresher = [[UIRefreshControl alloc] init];
    [self.refresher addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.pollTableView insertSubview: self.refresher atIndex:0];
    
    [self anotherQuery];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)anotherQuery{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pollCreator = [c] %@",[PFUser currentUser]];
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
#pragma mark - Table view data source

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
    
    if(indexPath.row == 0){
        
        cell = [self.pollTableView dequeueReusableCellWithIdentifier:@"MyPollsCell" forIndexPath:indexPath];
        
        cell.createdQuestion.text = accessPoll.pollQuestion;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.totalVotes.text = @"50";
        
    } else if(indexPath.row > 0){
        OptionsPreviewCell *optionCell = [self.pollTableView dequeueReusableCellWithIdentifier:@"MyPollsOptionsCell" forIndexPath:indexPath];
        NSArray *accessArray = accessPoll.options;
        if(_counter >= accessArray.count){
            [self resetCounter];
        }
        
        optionCell.myOptionName.text = [accessArray objectAtIndex:_counter];
        _counter += 1;
        return optionCell;
        
    }
    
    return cell;
}

-(void)resetCounter{
    self.counter = 0;
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
    pc.pollDelegate = self;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
