//
//  MyPollsTableViewCell.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/23/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PollQuestionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *createdQuestion;
@property (weak, nonatomic) IBOutlet UILabel *homeQuestion;
@property (weak, nonatomic) IBOutlet UILabel *totalVotes;
@property (weak, nonatomic) IBOutlet UILabel *pollAuthor;
@property (weak, nonatomic) IBOutlet UILabel *homeTotalVotes;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;

@end

NS_ASSUME_NONNULL_END
