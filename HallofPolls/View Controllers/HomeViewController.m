//
//  HomeViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "HomeViewController.h"
#import "Profile.h"
#import "Game.h"
#import "Poll.h"
#import <Parse/Parse.h>
#import "PollQuestionCell.h"
#import "OptionsPreviewCell.h"
#import "PollDescriptionCell.h"
#import "PollDetailViewController.h"
#import "PopularGamesViewController.h"
#import "PollCreationViewController.h"


@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (strong, nonatomic) NSArray<Poll *> *polls;
@property (strong, nonatomic) UIRefreshControl *refresh;
@property (strong, nonatomic) NSIndexSet *targetSection;
@property (strong, nonatomic) NSDictionary *gameRanks;
@property (strong, nonatomic) Profile *user;

//Temporary API counter for now
@property (nonatomic) NSUInteger counter;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    [self setIsDataLoading:true];
    
    [self beginRefresh:(UIRefreshControl *)_refresh];
       self.refresh = [[UIRefreshControl alloc] init];
       [self.refresh addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
       [self.homeTableView insertSubview: self.refresh atIndex:0];
    
    [self makeQuery];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pollCreated:) name:@"PollCreatedNotification" object:nil];
    
    [self.homeTableView reloadData];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [self.homeTableView reloadData];
    // How to reload selected section after view controller is changed?
   // [self.homeTableView reloadSections:<#(nonnull NSIndexSet *)#> withRowAnimation:UITableViewRowAnimationFade]
}
- (void)pollCreated:(NSNotification *)notification{
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

#pragma mark - RAWG API
/*
- (void)initApiWithCompletionBlock:(void(^)(BOOL completed))completion {
    // Probably not able to just dump the API
    //NSURL *url = [NSURL URLWithString:@"https://rawg.io/api/games"];
    NSURL *url = [NSURL URLWithString:@"https://api.rawg.io/api/games?dates=2015-01-01,2020-07-17&ordering=-added"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);

    } else {
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.gameArray = dataDictionary[@"results"];
        self.nextPage = dataDictionary[@"next"]; 
    }
        
    }];
    [task resume];
}

- (void)loadMoreData{
    
    if(self.isDataLoading){
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.nextPage] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);

    } else {
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.queuedGames = dataDictionary[@"results"];
        [self.gameArray addObjectsFromArray:self.queuedGames];
        self.nextPage = dataDictionary[@"next"];
        
        self.counter++;
        //self.isDataLoading = false;
        if(self.counter == 9){
            [self setIsDataLoading:false];
        }
    }
        
    }];
    [task resume];
    }
}
*/
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showPopular"]){
        PopularGamesViewController *popular;
        popular = [segue destinationViewController];
    } else if([[segue identifier] isEqualToString:@"showPollDetail"]) {
        PollDetailViewController *details = [segue destinationViewController];
        NSIndexPath *index = [self.homeTableView indexPathForSelectedRow];
        Poll *selectedPoll = self.polls[index.section];
        details.chosenPoll = selectedPoll;
    }

    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Table View Data Source


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){
        return 92;
    }
    return 105;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.polls count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Poll *accessPoll = self.polls[indexPath.section];
    
    NSInteger total = 0;
    
        for(int i = 0; i < [accessPoll.options count]; i++){
            if([accessPoll.voteArray count] > i){
                NSArray *temp = [accessPoll.voteArray objectAtIndex:i];
                total = total + [temp count];
            }
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
