//
//  Question.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, strong) NSString* text;

@property (nonatomic, strong) NSString* image;

@property (nonatomic, strong) NSArray* answers;

-(NSInteger)numberOfCorrectAnswers;

-(BOOL)indexIsCorrectAnswer:(NSInteger)answerIndex;

-(BOOL)indexIsChosenAnswer:(NSInteger)answerIndex;

-(BOOL)hasBeenAnsweredCorrectly;

-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
