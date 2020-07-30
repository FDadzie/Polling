//
//  PollDescriptionCell.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/29/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PollDescriptionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *descPreview;
@property (weak, nonatomic) IBOutlet UILabel *showcaseDesc;

@end

NS_ASSUME_NONNULL_END
