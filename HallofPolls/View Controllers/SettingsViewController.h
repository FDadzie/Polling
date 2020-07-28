//
//  SettingsViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/27/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *settingsTable;
@property (retain, nonatomic) UIImage *originalImage;
@property (retain, nonatomic) UIImage *editImage;
@end

NS_ASSUME_NONNULL_END