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
    Poll *accessPoll = self.polls[indexPath.section];
    
    if(indexPath.row == 0){
        
        self.question = [self.homeTableView dequeueReusableCellWithIdentifier:@"HomeQuestion"];
        self.question.homeQuestion.text = accessPoll.pollQuestion;
        self.question.selectionStyle = UITableViewCellSelectionStyleNone;

    } else if(indexPath.row == 1){
        AuthorCell *author = [self.homeTableView dequeueReusableCellWithIdentifier:@"HomeAuthor"];
        author.pollCreator.text = accessPoll.pollCreator.username;
        
        author.selectionStyle = UITableViewCellSelectionStyleNone;
        return author;
        
    } else if(indexPath.row > 1) {
        OptionsPreviewCell *voteOption = [self.homeTableView dequeueReusableCellWithIdentifier:@"HomeOption"];
        NSArray *optionArray = [accessPoll.options objectAtIndex:indexPath.section];
        //voteOption.optionName.text = [accessPoll.options objectAtIndex:indexPath.section];
        NSLog(@"%@", [optionArray objectAtIndex:indexPath.row]);
        // RETURNING ONLY ONE OPTION NAME (NOT INTENTIONAL)
        return voteOption;
    }
    
    return self.question;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Poll *refPoll = self.polls[section];
    
    return refPoll.optionCount + 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Poll *exPoll = self.polls[indexPath.section];
    
    // USER CAN ONLY VOTE FOR ONE OPTION
    if(indexPath.row > 1 || indexPath.row < exPoll.optionCount){
        
        
        // Do something here
        // Make sure vote counts are seperate and
    }
    // Tap cell again to remove vote?
}

@end
