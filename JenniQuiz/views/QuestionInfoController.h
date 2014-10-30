//
//  TopicDetailViewController.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Topic.h"
#import "QuestionViewController.h"

typedef void (^UserPressedStart)();

@protocol QuestionInfoControllerDelegate;

@interface QuestionInfoController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel* infoLabel;

@property (nonatomic, weak) IBOutlet UILabel* questionsLabel;

@property (nonatomic, weak) IBOutlet UIButton* startButton;

@property (nonatomic, strong) NSArray* questions;

@property (nonatomic, copy) UserPressedStart userPressedStartBlock;

@end

@protocol QuestionInfoControllerDelegate <NSObject>

-(void)userDidStartQuiz;

@end
