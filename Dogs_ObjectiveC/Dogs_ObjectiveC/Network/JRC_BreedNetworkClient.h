//
//  JRC_BreedNetworkClient.h
//  Dogs_ObjectiveC
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRC_Breed.h"
#import "JRC_SubBreed.h"

@interface JRC_BreedNetworkClient : NSObject

//MARK: - Shared Instance

+ (JRC_BreedNetworkClient *)shared;

//MARK: - Functions
//This method will fetch all of the breeds
- (void)fetchAllBreeds:(void (^) (NSArray <JRC_Breed *> *allBreeds))completion;

//This method will fetch the images of dog breeds
- (void)fetchBreedImageURLs:(JRC_Breed *)breed completion:(void (^) (NSArray *))completion;

//This method will fetch the images of dog sub-breeds
- (void)fetchSubBreedImageURLs:(JRC_SubBreed *)subBreed breed:(JRC_Breed *)breed completion:(void (^) (NSArray *))completion;
                  
//This method will fetch the image Data in the form of NSData
- (void)fetchImageData:(NSURL *)url completion:(void (^) (NSData *imageData))completion;
                                
@end
