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

@interface Profile : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *favGame;
@property (nonatomic, strong) NSMutableArray *prefGenre;
@property (nonatomic, strong) NSMutableArray *polls;
@property (nonatomic, strong) PFFileObject *userImage;
@property (nonatomic, strong) PFFileObject *userBanner;

+(void)saveUserData: (NSString * _Nullable)user withFavorite: (NSString * _Nullable)userGame withImage: (UIImage * _Nullable)image withBanner: (UIImage * _Nullable)banner withCompletion: (PFBooleanResultBlock _Nullable)completed;

@end

NS_ASSUME_NONNULL_END
