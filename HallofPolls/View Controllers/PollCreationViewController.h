//
//  PollCreationViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePickerViewController.h"
#import "MyPollsTableViewController.h"
#import "Game.h"
@class PollCreationViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol PollCreationViewControllerDelegate <NSObject>

- (void)myPollUpdate: (PollCreationViewController *)pollCreation;

@end

@interface PollCreationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<PollCreationViewControllerDelegate> pollDelegate;
//@property (nonatomic, strong) NSArray<Game *> *gameList;
@end

NS_ASSUME_NONNULL_END
