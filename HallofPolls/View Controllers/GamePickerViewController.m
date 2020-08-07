//
//  GamePickerViewController.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <Parse/Parse.h>
#import "GamePickerViewController.h"
#import "Poll.h"
#import "GamePickerCell.h"
#import "Game.h"
#import "PollCreationViewController.h"
#import "InfiniteScrollActivityView.h"
#import "UIImageView+AFNetworking.h"

@interface GamePickerViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Game *> *bufferingGames;
@property (strong, nonatomic) NSMutableArray<Game *> *fetchedGames;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic) NSString *nextAPI;
@property (strong, nonatomic) InfiniteScrollActivityView *loadingView;
//@property (class, nonatomic, readonly) CGFloat defaultHeight;

//-(void)startAnimating;
//-(void)stopAnimating;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray<Game *> *filteredGames;

@end

@implementation GamePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    [self initApiWithCompletionBlock:^(BOOL completed) {
    }];
    
//    self.filteredGames = self.fetchedGames;
}
#pragma mark - Infinite Scrolling
/*
UIActivityIndicatorView* activityIndicatorView;
static CGFloat _defaultHeight = 60.0;

+ (CGFloat)defaultHeight{
    return _defaultHeight;
}
*/

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
         // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
         // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging){
            self.isMoreDataLoading = true;
            // Code to add more data...
            [self loadMoreData];
        }
    }
}
/*
-(void)stopAnimating{
    [activityIndicatorView stopAnimating];
    self.hidden = true;
}

-(void)startAnimating{
    self.hidden = false;
    [activityIndicatorView startAnimating];
}
*/
#pragma mark - RAWG API CALLS

-(void)loadMoreData{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.nextAPI] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);

    } else {
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.bufferingGames = dataDictionary[@"results"];
        [self.fetchedGames addObjectsFromArray:self.bufferingGames];
        self.nextAPI = dataDictionary[@"next"];
        
        
        [self.tableView reloadData];
        self.isMoreDataLoading = false;
    }
        
    }];
    [task resume];
}
- (void) initApiWithCompletionBlock:(void(^)(BOOL completed))completion {
    NSURL *url = [NSURL URLWithString:@"https://rawg.io/api/games"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);

    } else {
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.fetchedGames = dataDictionary[@"results"];
        self.filteredGames = self.fetchedGames;
        self.nextAPI = dataDictionary[@"next"];
        
        /*
        for (self->_game in self.fetchedGames) {
            NSLog(@"%@", self->_game[@"name"]);
        }
         */
        
        [self.tableView reloadData];
    }
        
    }];
    [task resume];
}

#pragma mark - Table View Data Source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredGames count];
}
    
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GamePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PickerCell"];
    
    Game *tester = self.filteredGames[indexPath.row];
    cell.name.text = tester[@"name"];
    
    NSString *imageURL = tester[@"background_image"];
    NSURL *comepleteImage = [NSURL URLWithString:imageURL];
    cell.gameImage.image = nil;
    [cell.gameImage setImageWithURL:comepleteImage];
    return cell;
}

// pass selected cell's game name to array
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GamePickerCell *cell = (GamePickerCell *)[tableView cellForRowAtIndexPath:(indexPath)];
    [self.delegate gamePicker:self didPickItem:cell.name.text itemImage:cell.gameImage.image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SEARCH BAR

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS [c] %@", searchText];
        self.filteredGames = [self.fetchedGames filteredArrayUsingPredicate:predicate];
        
    }
    else {
        self.filteredGames = self.fetchedGames;
    }
    
    [self.tableView reloadData];
 
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PollCreationViewController *creationView = [segue destinationViewController];
    NSIndexSet *refSection = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 3)];
    [creationView.tableView reloadSections: refSection  withRowAnimation:UITableViewRowAnimationNone];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
