//
//  OWSpaceOjects.m
//  Out of this World
//
//  Created by James Carney on 12/22/14.
//  Copyright (c) 2014 James Carney. All rights reserved.
//

#import "OWSpaceOjects.h"
#import "AstronomicalData.h"

@implementation OWSpaceOject


// current object (self) is initialized in the header file. return self (id)
-(id)init
{
    self = [self initwithData:nil andImage:nil];
    return self;
}


-(id)initwithData:(NSDictionary *)data andImage:(UIImage *)image
{
    // sets up initializer from above method and then adds to it
//    self = [super init];
 
    // literal syntax and some properties were wrapped as NSNumbers and must be converted back to floats with the method floatValue
    self.name = data[PLANET_NAME];
    self.gravitationalForce = [data[PLANET_GRAVITY] floatValue];
    self.diameter = [data[PLANET_DIAMETER] floatValue];
    self.yearLength = [data[PLANET_YEAR_LENGTH] floatValue];
    self.dayLength = [data[PLANET_DAY_LENGTH] floatValue];
    self.temperature = [data[PLANET_TEMPERATURE] floatValue];
    self.numberOfMoons = [data[PLANET_NUMBER_OF_MOONS] intValue];
    self.nickName = data[PLANET_NICKNAME];
    self.interestingFact = data[PLANET_INTERESTING_FACT];
    
    // image is passed in as a seperate arguement NOT NSDictionary
    self.spaceImage = image;
    
    return self;
    
    
    
}

@end
