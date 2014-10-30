//
//  TopicCell.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "TopicCell.h"
#import "Config.h"

@implementation TopicCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    
    self.topicTitle.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:14.0f];
    self.topicTitle.textColor = [UIColor whiteColor];
    self.topicTitle.numberOfLines = 0;
    
    self.overlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    
    self.tickImageView.alpha = 0.0;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.tickImageView.alpha = selected ? 1.0 : 0.0;
}


@end
