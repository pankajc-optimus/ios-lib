//
//  CustomMapViewController.h
//  CustomMapComponent
//
//  Created by Optimus Information on 16/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

/**
 -For using this library developer should include these to file his/ her project and need to connect the outlet with UI properly.
 Before building the project need to add two framework into the project:
 1.MapKit.framework
 2.CoreLocation.framework 
 **/

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomAnnotation.h"


@interface CustomMapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate>
{
    CustomAnnotation *pindropAnnotation;
    CLGeocoder *myGeocoder;
    UIToolbar *navigationTools;
    UILongPressGestureRecognizer *longPressGesture;
    CLLocationCoordinate2D touchLocationCordinate;
    CLLocation *defaultLocation;
    NSMutableDictionary *locationInfoDictionary;
    NSMutableDictionary *userDefaultLocationInfoDictionary;
    
    NSMutableDictionary *annotationItemsDict;
    
    UIView *customCalloutView;
    UIPopoverController *popOverController;
    MKAnnotationView *selectedAnnotation;
    UITapGestureRecognizer *singleTapGester;
    
    NSTimer *timer;
    NSTimer *zoomTimer;
    
    MKCoordinateRegion changedRegion;
}

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) CLLocationManager *locationManager;


/* Show user default location.
 *
 * @param id sender
 * Show user default location by custom pin.
 *
 */
-(IBAction)showDefaultLocation:(id)sender;

/* Add a annotation by tapping on the map.
 *
 * Method find location coordinates and show a flag on the map if user tap and hold on the screen for 1 second.
 *
 */
-(void)handleTapOnMap;

@end
