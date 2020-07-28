//
//  PopularGameCell.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/28/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopularGameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *gameImage;
@property (weak, nonatomic) IBOutlet UILabel *game;
@property (weak, nonatomic) IBOutlet UILabel *popularDesc;

@end

NS_ASSUME_NONNULL_END
