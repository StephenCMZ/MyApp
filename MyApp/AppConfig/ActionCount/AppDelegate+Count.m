//
//  AppDelegate+Count.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "AppDelegate+Count.h"
#import "ActionConfig.h"

@implementation AppDelegate (Count)

- (void)setupCount{
    NSString *countConfigPath = [[NSBundle mainBundle] pathForResource:@"CountConfig" ofType:@"plist"];
    NSDictionary *config = [[NSDictionary alloc]initWithContentsOfFile:countConfigPath];
    [ActionConfig setupWithConfiguration:config];
}

@end
