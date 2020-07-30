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
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Poll *refPoll;
    // Poll equal to the poll selected from home view
    
    return [refPoll.options count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    //[self.detailTableView dequeueReusableHeaderFooterViewWithIdentifier:<#(nonnull NSString *)#>];
    OptionsPreviewCell *voteOption = [self.detailTableView dequeueReusableCellWithIdentifier:@"PollDetail"];
    
    return voteOption;
}



@end
