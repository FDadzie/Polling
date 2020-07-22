//
//  GamePickerViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/17/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GamePickerViewController;


NS_ASSUME_NONNULL_BEGIN

@protocol GamePickerViewControllerDelegate <NSObject>

- (void)gamePicker:(GamePickerViewController *)controller didPickItem:(NSString *)game;

@end

@interface GamePickerViewController : UIViewController

@property (strong, nonatomic) NSMutableArray * choices;
@property (nonatomic, weak) id<GamePickerViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

