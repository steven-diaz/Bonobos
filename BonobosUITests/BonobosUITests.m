//
//  BonobosUITests.m
//  BonobosUITests
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+Utilities.h"

@interface BonobosUITests : XCTestCase

@end

@implementation BonobosUITests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCategoryFlow {
    [self launch];
    [self waitForElement:self.application.otherElements[@"LoadingView"] toAppear:NO withTimeout:10];
    XCUIElement *chinoCell = self.application.cells[@"fit for your family gathering"];
    [chinoCell tap];
    [self waitForElement:self.application.otherElements[@"SubCategoryViewController"] toAppear:YES withTimeout:10];
}

@end
