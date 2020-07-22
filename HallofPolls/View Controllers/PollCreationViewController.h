//
//  PollCreationViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionPreviewCell.h"
#import "OptionsPreviewCell.h"
#import "GamePickerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PollCreationViewController : UIViewController

@property (nonatomic, strong) QuestionPreviewCell *askQuestion;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

NS_ASSUME_NONNULL_END
