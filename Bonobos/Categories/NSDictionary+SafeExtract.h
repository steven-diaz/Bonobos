//
//  NSDictionary+SafeExtract.h
//  Bonobos
//
//  Created by Steven Diaz on 11/17/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(SafeExtract)

- (id)safeObjectForKey:(id)aKey;

- (NSString *)safeStringForKey:(id)aKey;

@end
