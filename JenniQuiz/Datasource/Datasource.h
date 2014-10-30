//
//  Datasource.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Datasource : NSObject

+(NSArray*)loadAggregates;

+(void)saveAggregates:(NSArray*)results forDate:(NSDate*)date;

+(NSArray*)questionsFromFile:(NSString*)file;

@end
