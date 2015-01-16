//
//  OWSpaceImageViewController.h
//  Out of this World
//
//  Created by James Carney on 12/29/14.
//  Copyright (c) 2014 James Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceOjects.h"

// conforming to UIScrollView Delegate Protocol
@interface OWSpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) OWSpaceOject *spaceObject;



@end
