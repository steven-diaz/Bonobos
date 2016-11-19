//
//  XCTestCase+Utilities.h
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (Utilities)

@property (nonatomic, strong) XCUIApplication *application;

#pragma mark - Launch

/**
 * Initializes self.application (XCUIApplication) and calls launch.
 */
- (void)launch;

/**
 *  Asserts if a navigation bar exists with a supplied title
 *
 *  @param title The text displayed in the navigation bar
 */
- (void)assertNavigationBarWithTitle:(NSString *)title;

/**
 *  Tap an element with given text in a label
 *
 *  @param labelText The text displayed in the label
 */
- (void)tapElementWithLabelText:(NSString *)labelText;

/**
 *  Tap a button with given text
 *
 *  @param buttonText The button with the given text
 */
- (void)tapButtonWithText:(NSString *)buttonText;

/**
 * Convenience method, same as calling waitForElementToAppear followed by a tap on the same element
 *  @param element The element to assert and tap.
 */
- (void)waitForElementToAppearThenTap:(XCUIElement *)element;

/**
 *  Waits for an element to exist, regardless of whether it's on screen or not, with a timeout.
 *
 *  @param element The element to assert.
 *  @param exist   Whether the element should exist or not
 *  @param timeout The timeout interval for the assertion
 */
- (void)waitForElement:(XCUIElement *)element toExist:(BOOL)exist withTimeout:(NSTimeInterval)timeout;

/**
 *  Waits for an element to exist, regardless of whether it's on screen or not, with a timeout.
 *
 *  @param element The element to assert.
 *  @param exist   Whether the element should exist or not
 *  @param timeout The timeout interval for the assertion
 *  @param handler Optional handler that gets called when either element is found or timeout is triggered.
 */
- (void)waitForElement:(XCUIElement *)element toExist:(BOOL)exist withTimeout:(NSTimeInterval)timeout handler:(XCWaitCompletionHandler)handler;

/**
 *  Waits for an element to appear in view with a timeout.
 *
 *  @param element The element to assert.
 *  @param appear   Whether the element should appear or not
 *  @param timeout The timeout interval for the assertion
 */
- (void)waitForElement:(XCUIElement *)element toAppear:(BOOL)appear withTimeout:(NSTimeInterval)timeout;

/**
 *  Waits for an element to appear in view with a timeout.
 *
 *  @param element The element to assert.
 *  @param appear   Whether the element should appear or not
 *  @param timeout The timeout interval for the assertion
 *  @param handler Optional handler that gets called when either element is found or timeout is triggered.
 */
- (void)waitForElement:(XCUIElement *)element toAppear:(BOOL)appear withTimeout:(NSTimeInterval)timeout handler:(XCWaitCompletionHandler)handler;

/**
 *  Execute block repeatedly with an exit condition
 *
 *  @param block     The block to repeatedly execute
 *  @param condition The condition to break repetition
 */
- (void)executeRepeatBlock:(void (^)())block exitCondition:(BOOL (^)())condition;

@end
