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
#import "PollDescriptionCell.h"
#import "PollDetailViewController.h"
#import "PopularGamesViewController.h"



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
    
    [self makeQuery];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pollCreated:) name:@"PollCreatedNotification" object:nil];
}

-(void)pollCreated:(NSNotification *)notification{
    [self makeQuery];
    [self.homeTableView reloadData];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [self makeQuery];
    [self.homeTableView reloadData];
    [refreshControl endRefreshing];
}

-(void) makeQuery{
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showPopular"]){
        PopularGamesViewController *popular;
        popular = [segue destinationViewController];
    } else {
        
    PollDetailViewController *details = [segue destinationViewController];
    NSIndexPath *index = [self.homeTableView indexPathForSelectedRow];
    Poll *selectedPoll = self.polls[index.section];
    details.chosenPoll = selectedPoll;
    
    }

    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){
        return 72;
    }
    return 152;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.polls count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Poll *accessPoll = self.polls[indexPath.section];
    
    NSInteger total = 0;
    
    for(int i = 0; i < [accessPoll.options count]; i++){
        total = total + [[accessPoll.voteArray objectAtIndex:i]intValue];
    }
    
    if(indexPath.row == 0){
        
        PollQuestionCell *question = [self.homeTableView dequeueReusableCellWithIdentifier:@"HomeQuestion"];
        question.homeQuestion.text = accessPoll.pollQuestion;
        question.pollAuthor.text = accessPoll.pollCreator.username;
        question.homeTotalVotes.text = [NSString stringWithFormat:@"%ld" , (long)total];;
        
        return question;
    } else {
        
        PollDescriptionCell *describe = [self.homeTableView dequeueReusableCellWithIdentifier:@"PollDescription"];
        
        describe.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        describe.showcaseDesc.text = accessPoll.pollDescription;
        return describe;
    }
    /*
    else if(indexPath.row > 0) {
        
        OptionsPreviewCell *voteOption = [self.homeTableView dequeueReusableCellWithIdentifier:@"HomeOption"];
        NSArray *optionArray = accessPoll.options;
        if(_counter >= optionArray.count){
            [self resetCounter];
        }
        voteOption.optionName.text = [optionArray objectAtIndex:self.counter];
        self.counter +=1;
       
        
        //NSLog(@"%@", [optionArray objectAtIndex:counter]);
        // RETURNING ONLY ONE OPTION NAME (NOT INTENTIONAL)
        return voteOption;
    }
    */
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"showPollDetail" sender:self];
}

@end
