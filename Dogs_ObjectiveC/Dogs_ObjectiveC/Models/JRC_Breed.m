//
//  JRC_Breed.m
//  Dogs_ObjectiveC
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

#import "JRC_Breed.h"

@implementation JRC_Breed

//MARK: - Initializer
- (instancetype)initWithBreedName:(NSString *)name subBreeds:(NSArray *)subBreeds imageUrls:(NSArray *)imageUrls
{
    self = [super init];
    if (self) {
        //What you are initializing example: _name = name
        _name = name;
        _subBreeds = subBreeds;
        _imageUrls = imageUrls;
    }
    return self;
}

@end
