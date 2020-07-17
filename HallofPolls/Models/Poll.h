//
//  Poll.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/14/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Poll : PFObject<PFSubclassing>

@property (nonatomic, strong) NSNumber *totalVoteCount;
@property (nonatomic, strong) NSNumber *optionCount;
@property (nonatomic) Boolean *isOpen;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSString *pollQuestion;

@end

NS_ASSUME_NONNULL_END
