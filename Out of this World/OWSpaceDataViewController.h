//
//  OWSpaceDataViewController.h
//  Out of this World
//
//  Created by James Carney on 1/1/15.
//  Copyright (c) 2015 James Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceOjects.h"
@interface OWSpaceDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) OWSpaceOject *spaceObject;




@end
