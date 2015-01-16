//
//  OWSpaceImageViewController.m
//  Out of this World
//
//  Created by James Carney on 12/29/14.
//  Copyright (c) 2014 James Carney. All rights reserved.
//

#import "OWSpaceImageViewController.h"

@interface OWSpaceImageViewController ()

@end

@implementation OWSpaceImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // initialize imageView
    // set scroll view content size to be the size of our image
    // content size of scrollView = the size of the frame of the imageView
    self.imageView = [[UIImageView alloc] initWithImage:self.spaceObject.spaceImage];
    self.scrollView.contentSize = self.imageView.frame.size;
    [self.scrollView addSubview:self.imageView];
    
    // sets up viewController as the UIScrollView's delegate
    // 'listens' for events from scrollView (scrolls, pinch, etc) and then the UIScrollView delegate class dinamically calls the viewForZoomingInScrollView method
    // make sure max and min zooms are not the same thing or else it will not work
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.5;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// acess to protocol methods,'-' and first letter autofills protocol methods
// asks which view we should zoom in on
// returns self.imageView
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
