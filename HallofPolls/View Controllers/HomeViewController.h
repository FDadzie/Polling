//
//  HomeViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsPreviewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (strong, nonatomic) OptionsPreviewCell *voteOption;

@end

NS_ASSUME_NONNULL_END
