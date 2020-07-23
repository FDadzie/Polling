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

@interface GamePickerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Game *> *fetchedGames;
@property (strong, nonatomic) NSDictionary *game;

@end

@implementation GamePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self initApiWithCompletionBlock:^(BOOL completed) {
    }];
}

- (void) initApiWithCompletionBlock:(void(^)(BOOL completed))completion {
    NSURL *url = [NSURL URLWithString:@"https://api.rawg.io/api/games?dates=2015-01-01,2020-07-17&ordering=-added"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);

    } else {
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.fetchedGames = dataDictionary[@"results"];
        
        for (self->_game in self.fetchedGames) {
            NSLog(@"%@", self->_game[@"name"]);
        }
            [self.tableView reloadData];
    }
        
    }];
    [task resume];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetchedGames count];
}
    
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GamePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PickerCell"];
    
    Game *tester = self.fetchedGames[indexPath.row];
    cell.name.text = tester[@"name"];
    
    return cell;
}

// pass selected cell's game name to array
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GamePickerCell *cell = (GamePickerCell *)[tableView cellForRowAtIndexPath:(indexPath)];
    [self.choices addObject:cell.name.text];
    [self.delegate gamePicker:self didPickItem:cell.name.text];
    [self dismissViewControllerAnimated:YES completion:nil];
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
