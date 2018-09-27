//
//  Completing_a_Long_Running_Task_in_the_BackgroundAppDelegate.m
//  
//
//  Created by 深蓝的宿风 on 2018/8/6.
//  Copyright © 2018年 深蓝的宿风. All rights reserved.
//

#import "Completing_a_Long_Running_Task_in_the_BackgroundAppDelegate.h"

@implementation Completing_a_Long_Running_Task_in_the_BackgroundAppDelegate

@synthesize window = _window;
@synthesize backgroundTaskIdentifier;
@synthesize myTimer;

- (BOOL)isMultitaskingSupported {
    BOOL result = NO;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    return result;
}

- (void)timerMethod:(NSTimer *)paramSender {
    NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
    if (backgroundTimeRemaining == DBL_MAX) {
        NSLog(@"Background TimeRemaining = Undetermined");
    }else {
        NSLog(@"Background Time Remaining = %.02fSeconds", backgroundTimeRemaining);
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([self isMultitaskingSupported] == NO) {
        return;
    }
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
    self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundTask];
    }];
}

- (void)endBackgroundTask {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    __weak Completing_a_Long_Running_Task_in_the_BackgroundAppDelegate *weakSelf = self;
    dispatch_async(mainQueue, ^{
        __strong Completing_a_Long_Running_Task_in_the_BackgroundAppDelegate *strongSelf = weakSelf;
        if (strongSelf != nil) {
            [strongSelf.myTimer invalidate];
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
            strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }
    });
}


@end
