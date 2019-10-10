//
//  JRC_SubBreed.h
//  Dogs_ObjectiveC
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//
//  Name
//  An Array of Image URLs

#import <Foundation/Foundation.h>


@interface JRC_SubBreed : NSObject

//MARK: - Properties

@property (nonatomic, copy, readonly)NSString *name;
@property (nonatomic, copy)NSArray *imageUrls;

//MARK: - Initializers

- (instancetype)initWithSubBreedName:(NSString *)name imageUrls:(NSArray *)imageUrls;

@end

