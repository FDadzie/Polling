//
//  ProfileViewController.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/27/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (strong, nonatomic) Profile *currentUser;

@end

NS_ASSUME_NONNULL_END
