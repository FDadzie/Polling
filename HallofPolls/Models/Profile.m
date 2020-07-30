//
//  User.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/16/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "Profile.h"

@implementation Profile

@dynamic userId;
@dynamic userName;
@dynamic favGame;
@dynamic prefGenre;
@dynamic polls;

+ (nonnull NSString *)parseClassName {
    return @"PollUser";
}

+ (void) saveUserData:(NSString *)user withFavorite:(NSString *)userGame withCompletion: (PFBooleanResultBlock _Nullable)completed{
    Profile *profileData = [Profile new];
    profileData.favGame = userGame;
    profileData.userName = [PFUser currentUser].username;
    
    [profileData saveInBackgroundWithBlock:completed];
}
@end
