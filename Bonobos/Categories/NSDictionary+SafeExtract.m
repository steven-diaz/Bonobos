//
//  NSDictionary+SafeExtract.m
//  Bonobos
//
//  Created by Steven Diaz on 11/17/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "NSDictionary+SafeExtract.h"

@implementation NSDictionary(SafeExtract)

- (id)safeObjectForKey:(id)aKey {
    id obj = [self objectForKey:aKey];
    if (obj == nil || obj == [NSNull null]) return nil;
    
    return obj;
}

- (NSString *)safeStringForKey:(id)aKey {
    NSString *string = [self objectForKey:aKey];
    if (string == nil || string == (NSString *)[NSNull null]) return nil;
    
    return string;
}

@end
