//
//  User.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/16/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//
#import <Parse/Parse.h>
@class Poll;

NS_ASSUME_NONNULL_BEGIN

@interface User : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSArray *favGame;
@property (nonatomic, strong) NSMutableArray *prefGenre;
@property (nonatomic, strong) NSMutableArray *polls;

@end

NS_ASSUME_NONNULL_END
