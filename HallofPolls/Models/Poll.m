//
//  Poll.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/14/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "Poll.h"

@implementation Poll

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
    NSMutableArray *voteArray = [[NSMutableArray alloc] initWithCapacity:[pollOptions count]];
    newPoll.pollDescription = description;
    
    for(int i = 0; i < [newPoll.options count]; i++){
        [newPoll.voteArray insertObject:[NSMutableArray array] atIndex:i];
    }
    
    newPoll.voteArray = voteArray;
    [newPoll saveInBackgroundWithBlock:completion];
        
}


@end
