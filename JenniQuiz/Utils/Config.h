//
//  Config.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

+ (Config *)sharedInstance;

@property (nonatomic, strong) NSArray* topics;

@property (nonatomic, assign) NSInteger numberOfQuestionsToAnswer;
@property (nonatomic, assign) NSInteger numberOfQuestionsToPractice;
@property (nonatomic, assign) NSInteger passThreshold;

@property (nonatomic, strong) NSString* quizStartInfo;
@property (nonatomic, strong) NSString* mainFont;
@property (nonatomic, strong) NSString* boldFont;
@property (nonatomic, strong) NSString* mainBackground;


@property (nonatomic, assign) CGFloat timeNeededInMinutes;

@property (nonatomic, assign) BOOL isTimedQuiz;

@end
