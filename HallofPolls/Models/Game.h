//
//  Game.h
//  HallofPolls
//
//  Created by fdadzie20 on 7/16/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Game : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *developers;
@property (nonatomic, strong) NSArray *publishers;
@property (nonatomic, strong) NSArray *platforms;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) PFFileObject *backgroundImg;
@property (nonatomic, strong) NSArray *genres;

@end

NS_ASSUME_NONNULL_END