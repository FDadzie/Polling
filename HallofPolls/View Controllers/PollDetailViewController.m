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

@end

@implementation PollDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    
    self.detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.chosenPoll.voteArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    //NSInteger counter = 0;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.chosenPoll.options count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.chosenPoll.pollQuestion;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    OptionsPreviewCell *voteOption = [self.detailTableView dequeueReusableCellWithIdentifier:@"OptionDetail"];
    
    NSInteger votes = 0;
    [self.chosenPoll.voteArray insertObject:[NSNumber numberWithInteger:votes] atIndex:indexPath.row];
    [self.chosenPoll saveInBackground];
    
    voteOption.optionName.text = [self.chosenPoll.options objectAtIndex:indexPath.row];
    return voteOption;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    if(){
        
    }
    */
    [self.detailDelegate optionVoter:self];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
