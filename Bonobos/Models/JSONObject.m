//
//  JSONObject.m
//  Bonobos
//
//  Created by Steven Diaz on 11/17/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "JSONObject.h"

@implementation JSONObject

+ (instancetype)objectFromJSON:(NSDictionary *)json {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
