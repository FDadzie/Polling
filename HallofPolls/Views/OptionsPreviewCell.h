//
//  OptionsPreviewCell.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/20/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OptionsPreviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *optionsPreview;
@property (weak, nonatomic) IBOutlet UILabel *optionVotes;
@property (weak, nonatomic) IBOutlet UILabel *optionName;

@end

NS_ASSUME_NONNULL_END
