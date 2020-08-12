//
//  MyPollsTableViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/23/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyPollsTableViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *pollTableView;
//@property (strong, nonatomic) NSArray<Game *> *gameList;

@end

NS_ASSUME_NONNULL_END
