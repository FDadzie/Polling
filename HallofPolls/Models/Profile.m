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
@dynamic userImage;
@dynamic userBanner;

+ (nonnull NSString *)parseClassName {
    return @"Profile";
}

+ (void)saveUserData: (NSString * _Nullable)user withFavorite: (NSString * _Nullable)userGame withImage: (UIImage * _Nullable)image withBanner: (UIImage * _Nullable)banner withCompletion: (PFBooleanResultBlock _Nullable)completed{
    Profile *profileData = [Profile new];
    profileData.userId = [PFUser currentUser].objectId;
    profileData.favGame = userGame;
    profileData.userName = [PFUser currentUser].username;
    profileData.userImage = [self getPFFileFromImage:image];
    profileData.userBanner = [self getPFFileFromImage:banner];
    
    [profileData saveInBackgroundWithBlock:completed];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


@end
