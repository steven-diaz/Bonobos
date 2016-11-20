//
//  ProductCollectionViewFlowLayout.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "ProductCollectionViewFlowLayout.h"

CGFloat const CellHeightRatio= 1.5;

@implementation ProductCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.minimumLineSpacing = 1.0;
    self.minimumInteritemSpacing = 1.0;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

- (CGSize)itemSize {
    NSInteger numberOfColumns = 2;
    
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (numberOfColumns - 1)) / numberOfColumns;
    return CGSizeMake(itemWidth - 4, itemWidth * CellHeightRatio);
}

@end
