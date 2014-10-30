//
//  Config.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "Config.h"
#import "Topic.h"
#import "Datasource.h"

@interface Config ()

-(void)loadInfo;

@property (nonatomic, strong) NSDictionary* configInfo;

@end

@implementation Config


+ (Config *)sharedInstance
{
    static dispatch_once_t once;
    static Config *sharedInstance;
    dispatch_once(&once, ^{
        
        sharedInstance = [[Config alloc] init];
        [sharedInstance loadInfo];
    });
    return sharedInstance;
}

-(void)loadInfo{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"];
    
    self.configInfo = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    
    
    NSArray* topicsData = self.configInfo[@"Questions Data"];
    
    NSMutableArray* topics = [NSMutableArray arrayWithCapacity:topicsData.count];
    for (NSDictionary* topicDic in topicsData) {
     
        Topic* topic = [[Topic alloc] init];
        topic.title = topicDic[@"Topic Title"];
        topic.image = [UIImage imageNamed:topicDic[@"Topic Image"]];
        topic.questionJSONObjects = [Datasource questionsFromFile:topicDic[@"Questions File"]];
        [topics addObject:topic];
    }
    
    self.topics = [NSArray arrayWithArray:topics];
    
    
    
    NSDictionary* quizSettings = self.configInfo[@"Quiz Settings"];
    
    self.numberOfQuestionsToAnswer = [quizSettings[@"Number Of Questions To Answer"] integerValue];
    
    self.numberOfQuestionsToPractice = [quizSettings[@"Number of Questions To Practice"] integerValue];
    self.isTimedQuiz = [quizSettings[@"Is Timed Quiz"] boolValue];
    self.timeNeededInMinutes = [quizSettings[@"Time Needed In Minutes"] floatValue];
    self.passThreshold = [quizSettings[@"Pass Threshold"] integerValue];
    

    
    
    
    NSDictionary* interfaceSettings = self.configInfo[@"Interface Settings"];
    self.mainFont = interfaceSettings[@"Main Font"];
    self.boldFont = interfaceSettings[@"Bold Font"];
    self.mainBackground = interfaceSettings[@"Main Background"];
    
    self.quizStartInfo = interfaceSettings[@"Quiz Start Info"];

}
@end
