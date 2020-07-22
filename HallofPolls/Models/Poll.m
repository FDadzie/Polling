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
@dynamic pollCreator;

+ (nonnull NSString *)parseClassName {
    return @"Poll";
}

+ (void) postPoll : (NSArray * _Nullable)pollOptions withQuestion: (NSString * _Nullable )question withCompletion: (PFBooleanResultBlock _Nullable)completion {
    
    Poll *newPoll = [Poll new];
    newPoll.totalVoteCount = @(0);
    newPoll.optionCount = [pollOptions count];
    newPoll.pollQuestion = question;
    newPoll.pollCreator = [PFUser currentUser];
    
    
    [newPoll saveInBackgroundWithBlock:completion];
}
@end
