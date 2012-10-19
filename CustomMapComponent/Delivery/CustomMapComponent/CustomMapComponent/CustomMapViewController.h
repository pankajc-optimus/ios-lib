//
//  CustomMapViewController.h
//  CustomMapComponent
//
//  Created by Optimus Information on 16/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

/**
 -For using this library developer should include these file into his/ her project and need to connect the outlet with UI properly.
 -CustomMapViewController.h
 -CustomMapViewController.m
 
 -CustomAnnotation.h
 -CustomAnnotation.m 
 CustomAnnotation class used to create custom annotation.
 
 -FormDetailsViewController.h
 -FormDetailsViewController.m  
 FormDetailsViewController class used to show details by tapping on the accessory button on the callout.
 There is a method 'showDetailsForm' to show FormDetailsViewController by tapping on 'accessory' button.  
 
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
    UITapGestureRecognizer *singleTapGesture;
    
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

/*
 * Method return information for location touched on the map.
 *
 * @param float lattitude
 * @param float longitude
 * Method fetch location information(Country name, locality name etc.) by using CLGeocoder class. 
 */
-(void)locationInformation:(float)latitudeValue:(float)longitudeValue;

/*
 * This method is same as the 'locationInformation' method, but it call to fetch default location information. 
 *
 * @param float lattitude
 * @param float longitude
 * Method fetch location information(Country name, locality name etc.) by using CLGeocoder class.
 */
-(void)defaultLocationInformation:(float)latitudeValue:(float)longitudeValue;

/*
 * Method call to create custom callout with some information shows on the callout.
 */
-(void)createCustomCallout;

/*
 * Method call to location details form by tapping on accessory button on the callout.
 */
-(void)showDetailsForm;

/*
 * Method to close custom callout by tapping on the map.
 */
-(void)closeMapPopUp:sender;

/*
 * Method to calculate zoom level if user change map zoom level.
 */
-(void)showCurrentZoomLevel;

/*
 * Method to get new location coordinate after user scroll a map.
 */
-(void)showCurrentRegionCoordinates;
@end
