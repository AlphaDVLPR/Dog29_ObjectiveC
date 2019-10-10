//
//  JRC_BreedNetworkClient.m
//  Dogs_ObjectiveC
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

#import "JRC_BreedNetworkClient.h"

//MARK: - Magic Strings
static NSString * const kBaseUrlString = @"https://dog.ceo/api";
static NSString * const kBreedsString = @"breeds";
static NSString * const kBreedString = @"breed";
static NSString * const kListString = @"list";
static NSString * const kAllString = @"all";
static NSString * const kImagesString = @"images";

//MARK: - BreedNetworkClient Class
@implementation JRC_BreedNetworkClient

//MARK: - Shared Instance
+ (JRC_BreedNetworkClient *)shared
{
    static JRC_BreedNetworkClient *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [JRC_BreedNetworkClient new];
    });
    return shared;
}

//MARK: -Functions
//This method will fetch all of the breeds
- (void)fetchAllBreeds:(void (^)(NSArray<JRC_Breed *> *))completion
{
    //Build the Url
    NSURL *baseUrl = [NSURL URLWithString:kBaseUrlString];
    NSURL *breedComponent = [baseUrl URLByAppendingPathComponent:kBreedsString];
    NSURL *listComponent = [breedComponent URLByAppendingPathComponent:kListString];
    NSURL *finalUrl = [listComponent URLByAppendingPathComponent:kAllString];
    
    //URL Check
    NSLog(@" method fetchAllBreeds final URL : %@", finalUrl);
    
    //Start the Url Session
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //Check The Error-------------------------
        if (error) {
            NSLog(@"error with url session fetchAllBreeds %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (response) {
            NSLog(@"error with response %@", response);
        }
        
        if (!data) {
            NSLog(@"There was an error retrieving the data for the fetchAllBreeds method %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        
        //If no errors then we can continue parsing the data
        NSDictionary * topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        
        //Check
        if (!topLevelDictionary) {
            NSLog(@"Error passing the Json for fetchAllBreeds %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *messageDictionary = topLevelDictionary[@"message"];
        NSMutableArray *breeds = [[NSMutableArray alloc] init];
        
        for (id dogBreed in messageDictionary) {
            
            //Now we need to make an array for subBreeds as well
            NSMutableArray *subBreeds = [[NSMutableArray alloc] init];
            
            for (NSString *name in messageDictionary[dogBreed]) {
                JRC_SubBreed *subBreed = [[JRC_SubBreed alloc] initWithSubBreedName:name imageUrls:[[NSMutableArray alloc] init]];
                [subBreeds addObject:subBreed];
            }
            JRC_Breed *dogBreeds = [[JRC_Breed alloc] initWithBreedName:dogBreed subBreeds:subBreeds imageUrls:[[NSMutableArray alloc] init]];
            [breeds addObject: dogBreeds];
        }
        completion(breeds);
    }] resume];
}
//MARK: - fetchSubBreedImageURLs method
//This method will fetch the images of dog breeds
- (void)fetchSubBreedImageURLs:(JRC_Breed *)breed completion:(void (^)(NSArray *))completion
{
    //Build the Url
    NSURL *baseUrl = [NSURL URLWithString:kBaseUrlString];
    NSURL *breedComponent = [baseUrl URLByAppendingPathComponent:kBreedString];
    NSURL *breedNameComponent = [breedComponent URLByAppendingPathComponent:breed.name];
    NSURL *finalUrl = [breedNameComponent URLByAppendingPathComponent:kImagesString];
    
    //URL Check
    NSLog(@"method fetchBreedImageUrl final URL : %@", finalUrl);
    
    //Start the URL Session
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Handle errors
        if (error) {
            NSLog(@"error with url session method #fetchBreedImageUrls : %@", error.localizedDescription);
            completion(nil);
            return;
        }
        //Handle the response
        if (response) {
            NSLog(@"error with response method #fetchBreedImageUrls : %@", response);
        }
        //Handle the data
        if (!data) {
            NSLog(@"There was an error retrieving the data for the method #fetchBreedImageUrls : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        
        //Now we can serialize the data fam and get dat image
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSMutableArray *images = topLevelDictionary[@"message"];
        completion(images);
        
    }] resume];
}

//MARK: - fetchBreedImageUrl method
- (void)fetchBreedImageURLs:(JRC_Breed *)breed completion:(void (^)(NSArray *))completion
{
    //Build the Url
    NSURL *baseUrl = [NSURL URLWithString:kBaseUrlString];
    NSURL *breedUrl = [baseUrl URLByAppendingPathComponent:kBreedString];
    NSURL *breedNameUrl = [breedUrl URLByAppendingPathComponent:breed.name];
    NSURL *finalUrl = [breedNameUrl URLByAppendingPathComponent:kImagesString];
    
    //Url Check
    NSLog(@"method fetchSubBreedImageURLs final URL : %@", finalUrl);
    
    //Start the URL Session
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Handle errors
        if (error) {
            NSLog(@"error with url session method #fetchBreedImageURLs : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        //Handle the response
        if (response) {
            NSLog(@"error with response method #fetchBreedImageURLs : %@", response);
        }
        //Handle the data
        if (!data) {
            NSLog(@"There was an error retrieving the data for the method #fetchBreedImageURLs : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        
        //serialize the JSON
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSMutableArray *breedImages = topLevelDictionary[@"message"];
        completion(breedImages);
        
    }] resume];
}

//MARK: - fetchSubBreedImageURLs method
//This method will fetch the images of dog sub-breeds
- (void)fetchSubBreedImageURLs:(JRC_SubBreed *)subBreed breed:(JRC_Breed *)breed completion:(void (^)(NSArray *))completion
{
    //Build the Url
    NSURL *baseUrl = [NSURL URLWithString:kBaseUrlString];
    NSURL *breedUrl = [baseUrl URLByAppendingPathComponent:kBreedString];
    NSURL *breedNameUrl = [breedUrl URLByAppendingPathComponent:breed.name];
    NSURL *subBreedNameUrl = [breedNameUrl URLByAppendingPathComponent:subBreed.name];
    NSURL *finalUrl = [subBreedNameUrl URLByAppendingPathComponent:kImagesString];
    
    //URL Check
    NSLog(@"method fetchSubBreedImageURLs final URL : %@", finalUrl);
    
    //Start the URL Session
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Handle errors
        if (error) {
            NSLog(@"error with url session method #fetchSubBreedImageURLs : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        //Handle the response
        if (response) {
            NSLog(@"error with response method #fetchSubBreedImageURLs : %@", response);
        }
        //Handle the data
        if (!data) {
            NSLog(@"There was an error retrieving the data for the method #fetchSubBreedImageURLs : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        
        //Serialize
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSMutableArray *subBreedImages = topLevelDictionary[@"message"];
        completion(subBreedImages);
        
    }] resume];
}
//MARK: - fetchImageData method
//This method will fetch the image Data in the form of NSData
- (void)fetchImageData:(NSURL *)url completion:(void (^)(NSData *))completion
{
    //URL is passed in
    //Start Url Session
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Handle errors
        if (error) {
            NSLog(@"error with url session method <methodName> : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        //Handle the response
        if (response) {
            NSLog(@"error with response method <methodName> : %@", response);
        }
        //Handle the data
        if (!data) {
            NSLog(@"There was an error retrieving the data for the method <methodName> : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        
        //complete
        completion(data);
    }] resume];
}

@end
