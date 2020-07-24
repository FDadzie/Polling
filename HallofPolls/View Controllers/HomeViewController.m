//
//  HomeViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "HomeViewController.h"
#import "Game.h"
#import "Poll.h"
#import <Parse/Parse.h>
#import "PollQuestionCell.h"
#import "OptionsPreviewCell.h"
#import "AuthorCell.h"



@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray<Poll *> *polls;
@property (strong, nonatomic) UIRefreshControl *refresh;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    
    [self beginRefresh:(UIRefreshControl *)_refresh];
       self.refresh = [[UIRefreshControl alloc] init];
       [self.refresh addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
       [self.homeTableView insertSubview: self.refresh atIndex:0];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Poll"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"pollCreator"];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray<Poll *> * _Nullable fetchedPolls, NSError * _Nullable error) {
        if(!error){
            // do something with data fetched
            self.polls = fetchedPolls;
            [self.homeTableView reloadData];
        } else {
            // handle errors
        }
    }];
}
- (void)viewDidAppear:(BOOL)animated{
    [self.homeTableView reloadData];
}
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [self.homeTableView reloadData];
    [refreshControl endRefreshing];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.polls count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Poll *accessPoll = self.polls[indexPath.row];
    // LOOK AT THIS TOMORROW
    
     PollQuestionCell *question = [self.homeTableView dequeueReusableCellWithIdentifier:@"HomeQuestion"];
     question.homeQuestion.text = accessPoll.pollQuestion;
    
    question.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == 1){
        AuthorCell *author = [self.homeTableView dequeueReusableCellWithIdentifier:@"HomeAuthor" forIndexPath:indexPath];
        author.pollCreator.text = accessPoll.pollCreator.username;
        
        author.selectionStyle = UITableViewCellSelectionStyleNone;
        return author;
        
    } else if(indexPath.row > 1) {
        OptionsPreviewCell *options = [self.homeTableView dequeueReusableCellWithIdentifier:@"HomeOption" forIndexPath:indexPath];
        
        options.optionName.text = accessPoll.options[indexPath.row];
        // LOOK AT THIS TOMORROW
        return options;
    }
    
    return question;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Do something with table view to be able to access indexPath?
    Poll *refPoll = [self.polls lastObject];
    // STILL NEEDS TO BE LOOKED AT
    
    return refPoll.optionCount + 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Poll *exPoll = self.polls[indexPath.row];
    // USER CAN ONLY VOTE FOR ONE OPTION
    if(indexPath.row > 1 || indexPath.row < exPoll.optionCount){
        //Do something here
        //Make sure vote counts are seperate and
    }
    // Tap cell again to remove vote?
}

@end
