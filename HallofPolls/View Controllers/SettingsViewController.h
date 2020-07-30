//
//  SettingsViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/27/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingsViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol SettingsViewControllerDelegate <NSObject>

- (void)profileDataTransfer:(SettingsViewController *)preferences changeImage: (UIImage *)image changeGame: (NSString *)favorite;

@end

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *settingsTable;
@property (retain, nonatomic) UIImage *originalImage;
@property (retain, nonatomic) UIImage *editImage;
@property (nonatomic, strong) NSString *pickedFavGame;
@property (nonatomic, weak) id<SettingsViewControllerDelegate> settingsDelegate;

@end

NS_ASSUME_NONNULL_END
