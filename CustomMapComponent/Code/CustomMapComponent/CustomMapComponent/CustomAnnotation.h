//
//  CutomAnnotation.h
//  CustomMapComponent
//
//  Created by Optimus Information on 16/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

/**
 Custom annotation class use to drop annotation on the map. 
 **/

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject<MKAnnotation>

@property (strong, nonatomic) NSMutableDictionary *detailsDictionary;
@property (nonatomic , readonly) CLLocationCoordinate2D coordinate;

-(id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates;

@end
