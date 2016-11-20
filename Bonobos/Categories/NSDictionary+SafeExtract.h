//
//  NSDictionary+SafeExtract.h
//  Bonobos
//
//  Created by Steven Diaz on 11/17/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(SafeExtract)

/**
 *  Attempts to retrieve an object from the dictionary.
 *
 *  @param aKey The key to look up the object by.
 *
 *  @return The value for key. If the value is [NSNull null], returns nil.
 */
- (id)safeObjectForKey:(id)aKey;

/**
 *  Attempt to safely retrieve a string from the dictionary.
 *
 *  @param aKey The key to look up the string by.
 *
 *  @return The string value for key.
 */
- (NSString *)safeStringForKey:(id)aKey;

@end
