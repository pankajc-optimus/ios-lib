//
//  CutomAnnotation.m
//  CustomMapComponent
//
//  Created by Optimus Information on 16/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

@synthesize coordinate, detailsDictionary;

-(id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
{
    self = [super init];
    if(self !=nil)
    {
        coordinate = paramCoordinates;
    }
    return (self);
}
@end
