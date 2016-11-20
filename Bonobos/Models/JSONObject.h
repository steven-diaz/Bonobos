//
//  JSONObject.h
//  Bonobos
//
//  Created by Steven Diaz on 11/17/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONObject : NSObject

/**
 *  Override this initializer in subclasses to deserialize from JSON.
 */
+ (instancetype)objectFromJSON:(NSDictionary *)json;

@end
