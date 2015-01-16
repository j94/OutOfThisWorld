//
//  OWSpaceOjects.h
//  Out of this World
//
//  Created by James Carney on 12/22/14.
//  Copyright (c) 2014 James Carney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OWSpaceOject : NSObject

// properties are from the AstroData imported files

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *interestingFact;

@property (nonatomic) float gravitationalForce;
@property (nonatomic) float diameter;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) float temperature;
@property (nonatomic) int numberOfMoons;

// UIImage is seperate from ^ because it is not included in AstroData
@property (strong, nonatomic) UIImage *spaceImage;



// takes astro data and images sets planets properties accordingly. Passing in a NSDictionary named data, passing in a UIImage named image
-(id)initwithData:(NSDictionary *)data andImage:(UIImage *)image;


@end
