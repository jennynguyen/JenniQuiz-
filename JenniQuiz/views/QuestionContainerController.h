//
//  QuestionContainerController.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Topic.h"
#import "QuestionViewController.h"
#import "ResultsViewController.h"

@interface QuestionContainerController : UIViewController  <QuestionViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSArray* questions;

@end
