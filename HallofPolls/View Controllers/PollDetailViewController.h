//
//  PollDetailViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/30/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Poll.h"
NS_ASSUME_NONNULL_BEGIN

@interface PollDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) Poll *chosenPoll;
@end

NS_ASSUME_NONNULL_END
