//
//  PictureLibraryTests.m
//  PictureLibraryTests
//
//  Created by Optimus Information on 12/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import "PictureLibraryTests.h"

@implementation PictureLibraryTests

- (void)setUp
{
    [super setUp];
    
    pictureControllerInstance = [[PictureViewController alloc] init];
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

@end
