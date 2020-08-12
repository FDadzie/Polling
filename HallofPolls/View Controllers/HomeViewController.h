//
//  HomeViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsPreviewCell.h"
#import "PollQuestionCell.h"
#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (strong, nonatomic) NSMutableArray<Game *> *gameArray;
@property (strong, nonatomic) NSArray<Game *> *queuedGames;
@property (strong, nonatomic) NSString *nextPage;
@property (nonatomic) BOOL isDataLoading;

@end

NS_ASSUME_NONNULL_END
