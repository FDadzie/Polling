//
//  Poll.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/14/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@class UserModel;

NS_ASSUME_NONNULL_BEGIN

@interface Poll : PFObject<PFSubclassing>

@property (nonatomic, strong) NSNumber *totalVoteCount;
@property (nonatomic, strong) NSNumber *optionCount;
@property (nonatomic) BOOL *isOpen;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSString *pollQuestion;
@property (nonatomic, strong) UserModel *user;

@end

NS_ASSUME_NONNULL_END
