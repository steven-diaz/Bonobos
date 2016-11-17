//
//  ImageCacheServiceTests.m
//  Bonobos
//
//  Created by Steven Diaz on 11/17/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageCacheService.h"

@interface ImageCacheServiceTests : XCTestCase
@property (nonatomic, strong) ImageCacheService *imageCache;
@end

@implementation ImageCacheServiceTests

- (void)setUp {
    [super setUp];
    
    self.imageCache = [ImageCacheService instance];
}

- (void)testUncachedImage {
    NSURL *testImageURL = [NSURL URLWithString:@"http://testimage"];
    UIImage *cachedImage = [self.imageCache imageForURL:testImageURL];
    XCTAssert(cachedImage == nil);
}

- (void)testCachedImage {
    NSURL *testImageURL = [NSURL URLWithString:@"http://testimage"];
    UIImage *testImage = [UIImage new];
    
    [self.imageCache addImage:testImage forURL:testImageURL];
    UIImage *cachedImage = [self.imageCache imageForURL:testImageURL];
    XCTAssert(cachedImage != nil);
}

- (void)testAsyncImage {
    NSURL *testImageURL = [NSURL URLWithString:@"https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"];
    [self.imageCache asyncImageForURL:testImageURL completion:^(UIImage *image) {
        UIImage *cachedImage = [self.imageCache imageForURL:testImageURL];
        XCTAssert(cachedImage != nil);
    }];
}

@end
