//
//  ProductModel.h
//  Bonobos
//
//  Created by Steven Diaz on 11/17/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"

@interface ProductModel : JSONObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *productDescription;
@property (nonatomic, strong, readonly) NSString *displayPrice;
@property (nonatomic, strong, readonly) NSURL *imageURL;

@end
