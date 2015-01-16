//
//  OWAddSpaceObjectViewController.m
//  Out of this World
//
//  Created by James Carney on 1/4/15.
//  Copyright (c) 2015 James Carney. All rights reserved.
//

#import "OWAddSpaceObjectViewController.h"
#import <UIKit/UIKit.h>

@interface OWAddSpaceObjectViewController ()

@end

@implementation OWAddSpaceObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // setting up the background image and color
    UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// didCancel is defined is OWOuterSpaceTableVC.m
- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self.delegate didCancel];
    
    
}

// when the button is pressed it creates a new space object that has all the properties set by the user in the textfields
// we do this by running the returnNewSpaceObject on self
// the new space object is then passed back to the tableViewController
- (IBAction)addButtonPressed:(UIButton *)sender {
    
    OWSpaceOject *newSpaceObject = [self returnNewSpaceObject];
    [self.delegate addSpaceObject:newSpaceObject];
  
}


-(OWSpaceOject *)returnNewSpaceObject {
    
    OWSpaceOject *addedSpaceObject = [[OWSpaceOject alloc] init];
    addedSpaceObject.name = self.nameTextField.text;
    addedSpaceObject.nickName = self.nicknameTextField.text;
    addedSpaceObject.diameter = [self.diameterTextField.text floatValue];
    addedSpaceObject.temperature = [self.temperatureTextField.text floatValue];
    addedSpaceObject.numberOfMoons = [self.numberOfMoonsTextFields.text intValue];
    addedSpaceObject.interestingFact = self.interestingFactTextField.text;
    addedSpaceObject.spaceImage = [UIImage imageNamed:@"EinsteinRing.jpg"];
    
    return addedSpaceObject;
}











@end
