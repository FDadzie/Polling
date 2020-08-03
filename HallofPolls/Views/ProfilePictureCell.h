//
//  ProfilePictureCell.h
//  HallofPolls
//
//  Created by fdadzie20 on 8/2/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfilePictureCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileBanner;
@property (weak, nonatomic) IBOutlet UILabel *profileUser;


@end

NS_ASSUME_NONNULL_END
