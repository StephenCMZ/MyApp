//
//  ActionConfig.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LSImpression        @"LSImpression"        // 统计页面标记
#define LSTrackedEvents     @"LSTrackedEvents"     // 统计事件集合
#define LSEventName         @"LSEventName"         // 统计事件名称
#define LSEventSelectorName @"LSEventSelectorName" // 统计事件方法

@interface ActionConfig : NSObject

+ (void)setupWithConfiguration:(NSDictionary *)configs;

@end
