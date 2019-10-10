//
//  JRC_Breed.h
//  Dogs_ObjectiveC
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//
//  Name
//  An Array of Sub-Breeds
//  An Array of Image URLs

#import <Foundation/Foundation.h>


@interface JRC_Breed : NSObject

//MARK: - Properties

@property (nonatomic, copy, readonly)NSString *name;
@property (nonatomic, copy)NSArray *subBreeds;
@property (nonatomic, copy)NSArray *imageUrls;

//MARK: - Initializers

- (instancetype)initWithBreedName:(NSString *)name subBreeds:(NSArray *)subBreeds imageUrls:(NSArray *)imageUrls;

@end


