//
//  XCTestCase+Utilities.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "XCTestCase+Utilities.h"
#import <objc/runtime.h>

NSTimeInterval const DefaultTimeout = 10;
NSTimeInterval const ElementSearchTimeout = 1;

@implementation XCTestCase (Utilities)

#pragma mark - Associated Object

- (XCUIApplication *)application {
    return objc_getAssociatedObject(self, @selector(application));
}

- (void)setApplication:(XCUIApplication *)application {
    objc_setAssociatedObject(self, @selector(application), application, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Launching Application

- (void)launch {
    self.application = [[XCUIApplication alloc] init];
    [self.application launch];
}

#pragma mark - UI Query Convenience Methods

- (void)assertNavigationBarWithTitle:(NSString *)title {
    XCUIElement *accountSettingsNavigationBar = self.application.navigationBars[title];
    [self waitForElement:accountSettingsNavigationBar toAppear:YES withTimeout:DefaultTimeout];
}

- (void)tapElementWithLabelText:(NSString *)labelText {
    XCUIElement *targetElement = self.application.staticTexts[labelText];
    [self waitForElement:targetElement toAppear:YES withTimeout:ElementSearchTimeout];
    [targetElement tap];
}

- (void)tapButtonWithText:(NSString *)buttonText {
    XCUIElement *targetElement = self.application.buttons[buttonText];
    [self waitForElement:targetElement toAppear:YES withTimeout:ElementSearchTimeout];
    [targetElement tap];
}

- (void)waitForElementToAppearThenTap:(XCUIElement *)element {
    [self waitForElement:element toAppear:YES withTimeout:DefaultTimeout];
    [element tap];
}

#pragma mark - XCUI Utilities

- (void)waitForElement:(XCUIElement *)element toExist:(BOOL)exist withTimeout:(NSTimeInterval)timeout {
    [self waitForElement:element toExist:exist withTimeout:timeout handler:nil];
}

- (void)waitForElement:(XCUIElement *)element toExist:(BOOL)exist withTimeout:(NSTimeInterval)timeout handler:(XCWaitCompletionHandler)handler {
    NSString *predicateExpression = [NSString stringWithFormat:@"exists = %@", exist ? @"1" : @"0"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateExpression];
    [self expectationForPredicate:predicate evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:timeout handler:handler];
}

- (void)waitForElement:(XCUIElement *)element toAppear:(BOOL)appear withTimeout:(NSTimeInterval)timeout {
    [self waitForElement:element toAppear:appear withTimeout:timeout handler:nil];
}

- (void)waitForElement:(XCUIElement *)element toAppear:(BOOL)appear withTimeout:(NSTimeInterval)timeout handler:(XCWaitCompletionHandler)handler {
    NSString *predicateExpression = [NSString stringWithFormat:@"isHittable = %@", appear ? @"1" : @"0"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateExpression];
    [self expectationForPredicate:predicate evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:timeout handler:handler];
}

- (void)executeRepeatBlock:(void (^)())block exitCondition:(BOOL (^)())condition {
    while (true) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        if (condition()) {
            break;
        } else {
            block();
        }
    }
}

@end
