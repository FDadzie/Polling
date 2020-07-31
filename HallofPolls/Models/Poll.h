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

@property (nonatomic) BOOL *isOpen;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSString *pollQuestion;
@property (nonatomic, strong) PFUser *pollCreator;
@property (nonatomic, strong) NSMutableArray *voteArray;
@property (nonatomic, strong) NSString *pollDescription;


+ (void) postPoll : (NSArray * _Nullable)pollOptions withQuestion: (NSString * _Nullable)question withDescription: (NSString * _Nullable )description withCompletion :(PFBooleanResultBlock _Nullable)completion ;

@end

NS_ASSUME_NONNULL_END
