//
//  OWAddSpaceObjectViewController.h
//  Out of this World
//
//  Created by James Carney on 1/4/15.
//  Copyright (c) 2015 James Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceOjects.h"

@protocol OWAddSpaceObjectViewControllerDelegate <NSObject>
@required

-(void)addSpaceObject:(OWSpaceOject *)spaceObject;
-(void)didCancel;

@end

@interface OWAddSpaceObjectViewController : UIViewController

// id is a pointer to type unkown
@property (weak, nonatomic) id <OWAddSpaceObjectViewControllerDelegate> delegate;


@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextFields;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;


- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;




@end
