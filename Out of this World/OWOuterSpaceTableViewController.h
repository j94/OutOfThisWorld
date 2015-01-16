//
//  OWOuterSpaceTableViewController.h
//  Out of this World
//
//  Created by James Carney on 12/1/14.
//  Copyright (c) 2014 James Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWAddSpaceObjectViewController.h"

// This class must conform to the OWAddSpace VC so that it can recieve planet data the user adds
@interface OWOuterSpaceTableViewController : UITableViewController < OWAddSpaceObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;


@end
