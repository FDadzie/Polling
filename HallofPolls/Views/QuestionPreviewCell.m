//
//  QuestionPreviewCell.m
//  HallofPolls
//
//  Created by fdadzie20 on 7/20/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "QuestionPreviewCell.h"

@implementation QuestionPreviewCell

@synthesize questionPreview;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
/*
- (void)synthesizeText:(NSString * _Nonnull) properText {
    properText = questionPreview.text;
}
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end