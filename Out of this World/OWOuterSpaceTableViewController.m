//
//  OWOuterSpaceTableViewController.m
//  Out of this World
//
//  Created by James Carney on 12/1/14.
//  Copyright (c) 2014 James Carney. All rights reserved.
//

#import "OWOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "OWSpaceOjects.h"
#import <UIKit/UIKit.h>
#import "OWSpaceImageViewController.h"
#import "OWSpaceDataViewController.h"

@interface OWOuterSpaceTableViewController ()

@end

@implementation OWOuterSpaceTableViewController
#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantiation of Properties

// if you don't have an instance variable named _planets set up, it initializes it for you
// underscrore is a way to access properties
-(NSMutableArray *)planets
{
    if (!_planets) {
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}


-(NSMutableArray *)addedSpaceObjects
{
    if (!_addedSpaceObjects)
    {
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObjects;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    //
        for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        OWSpaceOject *planet = [[OWSpaceOject alloc] initwithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for (NSDictionary *dictionary in myPlanetsAsPropertyLists) {
        OWSpaceOject *spaceObject = [self spaceObjectForDictionary:dictionary];
        [self.addedSpaceObjects addObject:spaceObject];
        
    }

// NSNumber is useful for wrapping primitives add objects. Why? Because NSDictionaries and Arrays only accept objects
//    NSNumber *myNumber = [NSNumber numberWithInt:5];
//    NSLog(@"%@", myNumber);
//    NSNumber *floatNumber = [NSNumber numberWithFloat:3.14];
//    NSLog(@"%@", floatNumber);
// in Astro.m shorthand for NSNumber is used. Looks like: @22354
}

// prepareForSegue does not do anything its self but is a great place to do logic before the transition to the new viewController
// takes 2 arguements: segue and (id)sender
// id is a pointer to any type of object (in this case sender)
// If statement checks if sender is a tableViewCell
// second if checks to make sure where we are going to is in fact a SpaceImageViewController
// indexes into an array to access the space objects of either the planets array or the added planets array
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if ([sender isKindOfClass:[UITableViewCell class]])
   {
       if ([segue.destinationViewController isKindOfClass:[OWSpaceImageViewController class]])
       {
           OWSpaceImageViewController *nextViewController = segue.destinationViewController;
           NSIndexPath *path = [self.tableView indexPathForCell:sender];
           OWSpaceOject *selectedObject;
           if (path.section == 0) {
               selectedObject = self.planets[path.row];
           }
           else if (path.section == 1) {
               selectedObject = self.addedSpaceObjects[path.row];
           }

           // setting the spaceObject property of the nextVC to the space object that was selected
           nextViewController.spaceObject = selectedObject;
           
           // the following line of commented code will NOT work because prepareForSegue UIelements and IBOutlets are not avaliable to us. They are only available when the VC is on the screen, so we must use a proxy property to store the properties until the VC is up
           // nextViewController.imageView.image = selectedObject.spaceImage;
       }
       
   }
      if ([sender isKindOfClass:[NSIndexPath class]])
      {
          if ([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]])
               {
                   OWSpaceDataViewController *targetViewController = segue.destinationViewController;
                   NSIndexPath *path = sender;
                   OWSpaceOject *selectedObject;
                   if (path.section == 0) {
                       selectedObject = self.planets[path.row];
                   }
                   else if (path.section == 1) {
                       selectedObject = self.addedSpaceObjects[path.row];
                   }
            
                   targetViewController.spaceObject = selectedObject;
               }
      }
    if ([segue.destinationViewController isKindOfClass:[OWAddSpaceObjectViewController class]]) {
        OWAddSpaceObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OWAddSpaceViewController Delegate
// OWOuterSpaceTableViewController dismisses addSpaceVC when it is on top of it
-(void)didCancel {
    
    NSLog(@"didCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addSpaceObject:(OWSpaceOject *)spaceObject {
  
    [self.addedSpaceObjects addObject:spaceObject];
    
    // will save to NSUserDefaults here
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    if (!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsAPropertyList:spaceObject]];
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
#pragma mark - Helper Method (private, will not be used by other classes and therfore will not be declared in the header file
-(NSDictionary *)spaceObjectAsAPropertyList:(OWSpaceOject *)spaceObject {
    
    // NSDictionary uses keys and values. Example--->  KEYNAME1: Value.name, KEYNAME2: Value.name, etc. Remember that @() is how you create an NSNumber object PL
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    NSDictionary *dictionary = @{PLANET_NAME: spaceObject.name, PLANET_GRAVITY: @(spaceObject.gravitationalForce), PLANET_DIAMETER: @(spaceObject.diameter), PLANET_YEAR_LENGTH: @(spaceObject.yearLength), PLANET_DAY_LENGTH: @(spaceObject.dayLength), PLANET_TEMPERATURE: @(spaceObject.temperature), PLANET_NUMBER_OF_MOONS: @(spaceObject.numberOfMoons), PLANET_NICKNAME: spaceObject.nickName, PLANET_INTERESTING_FACT: spaceObject.interestingFact };
    
    return dictionary;
}

// converts propertylist that were made in NSUserDefaults and converts them back into a space object
-(OWSpaceOject *)spaceObjectForDictionary:(NSDictionary *)dictionary {
    
    NSData *dataForImage = dictionary[PLANET_IMAGE];
    // converts back into a UIImage
    UIImage *spaceObjectimage = [UIImage imageWithData:dataForImage];
    OWSpaceOject *spaceObject = [[OWSpaceOject alloc] initwithData:dictionary andImage:spaceObjectimage];
    return spaceObject;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    // if there actually is added objects in my array then we should return 2 sections because the user has in fact added 2 space objects
    if ([self.addedSpaceObjects count]) {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
   
    if (section == 1) {
        return [self.addedSpaceObjects count];
    }
    else {
        return [self.planets count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier  forIndexPath:indexPath];

    // Configure the cell...
    
    if (indexPath.section == 1) {
        // Use new spaceObject to customize our cell
        OWSpaceOject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickName;
        cell.imageView.image = planet.spaceImage;
    }
    else {
        // cell objects come with a detailed properties, these include detailTextLabel and imageView.image
        OWSpaceOject *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickName;
        cell.imageView.image = planet.spaceImage;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:.5 alpha:1.0];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) return YES;
    else return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        // remove the object where the user swiped
        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newSavedSpaceObjectData = [[NSMutableArray alloc] init];
        for (OWSpaceOject *spaceObject in self.addedSpaceObjects) {
            [newSavedSpaceObjectData addObject:[self spaceObjectAsAPropertyList:spaceObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newSavedSpaceObjectData forKey:ADDED_SPACE_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - UITableView Delegate

// method that access disclosure button and makes the connection to the OWSpaceDataViewController
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}


@end
