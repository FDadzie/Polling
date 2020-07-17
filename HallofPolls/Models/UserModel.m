//
//  User.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/16/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

@dynamic userId;
@dynamic userName;
@dynamic favGame;
@dynamic prefGenre;
@dynamic polls;

+ (nonnull NSString *)parseClassName {
    return @"PollUser";
}

@end
