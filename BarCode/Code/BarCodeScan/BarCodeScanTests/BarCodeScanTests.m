//
//  BarCodeScanTests.m
//  BarCodeScanTests
//
//  Created by Optimus on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BarCodeScanTests.h"

@implementation BarCodeScanTests

-(void)testbarCode
{
   
    barCodeScanViewController *barCodeScanner=[[barCodeScanViewController alloc]init];
    NSString *expectedNumber=@"1234567890";
    NSString *resultNumber=[barCodeScanner barCode];
    STAssertEqualObjects(expectedNumber,resultNumber,@"hello");
    
}



- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

/*- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in BarCodeScanTests");
}*/

@end
