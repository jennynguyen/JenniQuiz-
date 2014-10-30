//
//  QuestionViewController.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Question.h"

@protocol QuestionViewControllerDelegate;

@interface QuestionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Question* question;

@property (nonatomic, assign) id<QuestionViewControllerDelegate> delegate;

@property (nonatomic, assign) BOOL isForReview;

-(void)loadData;

@end


@protocol QuestionViewControllerDelegate <NSObject>

-(void)questionHasBeenAnswered:(Question*)question withController:(QuestionViewController*)controller;

@end
