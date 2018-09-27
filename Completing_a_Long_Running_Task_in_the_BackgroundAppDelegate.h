//
//  Completing_a_Long_Running_Task_in_the_BackgroundAppDelegate.h
//  
//
//  Created by 深蓝的宿风 on 2018/8/6.
//  Copyright © 2018年 深蓝的宿风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Completing_a_Long_Running_Task_in_the_BackgroundAppDelegate : UIResponder<UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *myTimer;

@end
