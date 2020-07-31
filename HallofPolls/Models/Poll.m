//
//  Poll.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/14/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "Poll.h"

@implementation Poll

@dynamic isOpen;
@dynamic options;
@dynamic pollQuestion;
@dynamic pollCreator;
@dynamic voteArray;
@dynamic pollDescription;

+ (nonnull NSString *)parseClassName {
    return @"Poll";
}

+ (void) postPoll : (NSArray * _Nullable)pollOptions withQuestion: (NSString * _Nullable )question withDescription: (NSString * _Nullable )description withCompletion: (PFBooleanResultBlock _Nullable)completion {
    
    Poll *newPoll = [Poll new];
    newPoll.pollQuestion = question;
    newPoll.pollCreator = [PFUser currentUser];
    newPoll.options = pollOptions;
    newPoll.voteArray = [[NSMutableArray alloc] init];
    newPoll.pollDescription = description;
    
    
    [newPoll saveInBackgroundWithBlock:completion];
}


@end
