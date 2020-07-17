//
//  Poll.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/14/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "Poll.h"

@implementation Poll

@dynamic totalVoteCount;
@dynamic optionCount;
@dynamic isOpen;
@dynamic options;
@dynamic pollQuestion;

+ (nonnull NSString *)parseClassName {
    return @"Poll";
}

@end
