//
//  Utils.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(CGFloat)calculateAverageTestScores:(NSArray*)aggregates;

+(CGFloat)getLastTestScore:(NSArray*)aggregates;

+(NSArray*)getLast:(NSInteger)count scoresFromAggregates:(NSArray*)aggregates;

+(NSArray*)getLast:(NSInteger)count labelsForAggregates:(NSArray*)aggregates;

+(CGFloat)calculateCorrectScore:(NSArray*)questions;

+(NSInteger)calculateNumberOfCorrectAnswers:(NSArray*)questions;

+(NSArray*)loadQuestionsFromTopics:(NSArray*)selectedTopics forTotalNumberOfQuestions:(NSInteger)questionCount;


@end
