//
//  PictureViewControllerTest.m
//  PictureLibrary
//
//  Created by Optimus Information on 10/10/12.
//  Copyright (c) 2012 Optimus. All rights reserved.
//

#import "PictureViewControllerTest.h"
@class PicterViewController;

@implementation PictureViewControllerTest


- (void)setUp
{
    [super setUp];
    
    pictureControllerInstance = [[PicterViewController alloc] init];
    [pictureControllerInstance viewDidLoad];
}

- (void)tearDown
{
    // Tear-down code here.    
    [super tearDown];
    pictureControllerInstance = nil;
}


// Test case to check image compression.
- (void)testCompressImage
{
    [pictureControllerInstance returnMaxCompressionLimit:353366];
    UIImage *sampleImage = [UIImage imageNamed:@"IMG_0162.jpg"];
    NSData *data = UIImageJPEGRepresentation(sampleImage, 1.0f);    
    NSData *compressImageData =  [pictureControllerInstance compressPhoto:sampleImage];   
    STAssertTrue(data.length > compressImageData.length, @"Compress image data shold be less then priginal image data");
}


-(void)testSaveCompressImage
{
     // ToDo: incomplete.
    [pictureControllerInstance returnMaxCompressionLimit:353366];
    UIImage *sampleImage = [UIImage imageNamed:@"IMG_0162.jpg"];    
    [pictureControllerInstance compressPhoto:sampleImage];
    BOOL result= [pictureControllerInstance isImageSave];
    NSLog(@"result %d",result);
    //STAssertEquals(YES, YES, @"cc");
}

- (void)testRotateImage
{
    // ToDo: incomplete.
      UIImage *sampleImage = [UIImage imageNamed:@"IMG_0162.jpg"];         
     [pictureControllerInstance rotatePhoto:sampleImage];     
    // STAssertEquals(YES, YES, @"cc");
}

@end
