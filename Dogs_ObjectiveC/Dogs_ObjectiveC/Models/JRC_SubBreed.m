//
//  JRC_SubBreed.m
//  Dogs_ObjectiveC
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//


#import "JRC_SubBreed.h"

@implementation JRC_SubBreed

//MARK: - Initializers
- (instancetype)initWithSubBreedName:(NSString *)name imageUrls:(NSArray *)imageUrls
{
    self = [super init];
    if (self) {
        //What you are initializing example: _name = name
        _name = name;
        _imageUrls = imageUrls;
    }
    return self;
}
@end
