//
//  Game.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/16/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "Game.h"

@implementation Game

@dynamic gameId;
@dynamic name;
@dynamic developers;
@dynamic publishers;
@dynamic platforms;
@dynamic desc;
@dynamic backgroundImg;
@dynamic genres;
@dynamic poll;



+ (nonnull NSString *)parseClassName {
    return @"Game";
}

/*
+ (void)storeGames {
    
    Game *newGame = [Game new];
    newGame.gameId = nil;
    newGame.name = nil;
    newGame.developers = nil;
    newGame.publishers = nil;
    newGame.platforms = nil;
    newGame.desc = nil;
    newGame.genres = nil;
    

}
*/


@end
