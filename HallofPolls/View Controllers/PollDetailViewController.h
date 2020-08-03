//
//  PollDetailViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/30/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Poll.h"
@class PollDetailViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol PollDetailViewControllerDelegate <NSObject>

- (void) optionVoter:(PollDetailViewController *)pollDetail;

@end

@interface PollDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) Poll *chosenPoll;
@property (nonatomic, strong) id<PollDetailViewControllerDelegate> detailDelegate;

@end

NS_ASSUME_NONNULL_END
