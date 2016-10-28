//
//  UIViewController+Back.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "UIViewController+Back.h"
#import <objc/runtime.h>

@implementation UIViewController (Back)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(custom_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
    
}

- (void)custom_viewWillAppear:(BOOL)animated {
    
    [self custom_viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = COLOR_NAV_BAR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_NAV_TITLE}];
    
    self.navigationController.navigationBar.tintColor = COLOR_NAV_BACKBTN;
    self.navigationController.navigationBar.backIndicatorImage = BACK_IMAGE;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = BACK_IMAGE;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:BACK_TITLE
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:NULL];
}

@end
