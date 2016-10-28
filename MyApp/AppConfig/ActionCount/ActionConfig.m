//
//  ActionConfig.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "ActionConfig.h"
#import "Aspects.h"

@implementation ActionConfig

+ (void)setupWithConfiguration:(NSDictionary *)configs{
    
    // 页面开始
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                       NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                       NSString *pageImp = configs[className][LSImpression];
                                       if (pageImp) {
                                           //TODO: 将类名传给统计框架
                                           //[MobClick beginLogPageView:className];
                                       }
                                   });
                               } error:NULL];
    
    // 页面结束
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   if ([aspectInfo.instance isBeingDismissed]) {
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                           NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                           NSString *pageImp = configs[className][LSImpression];
                                           if (pageImp) {
                                               //TODO: 将类名传给统计框架
                                               //[MobClick endLogPageView:className];
                                           }
                                       });
                                   }
                               } error:NULL];
    
    // 事件
    for (NSString *className in configs) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configs[className];
        
        if (config[LSTrackedEvents]) {
            for (NSDictionary *event in config[LSTrackedEvents]) {
                SEL selekor = NSSelectorFromString(event[LSEventSelectorName]);
                [clazz aspect_hookSelector:selekor
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        //TODO: 将事件传给统计框架
                                        // [MobClick event:[NSString stringWithFormat:@"%@_%@",className,event[LSEventName]]];
                                    });
                                } error:NULL];
                
            }
        }
    }

    
}

@end
