//
//  PictureViewController.m
//  PictureLibrary
//
//  Created by Optimus Information on 08/10/2012.
//  Copyright (c) 2012 Optimus. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()

@end

@implementation PictureViewController
@synthesize imageView, previewImageView;

NSString *saveImageString;
BOOL isImageRotated;

#define M_PI  3.14159265358979323846264338327950288
NSUInteger maximumCompressionLimit = 1048576;// Default compression size 1Mb.

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

/*
 Check user device
 */
- (BOOL)isPad
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.inputTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setPreviewImageView:nil];
    [super viewDidUnload];
}

/*
 Method to capture image when user tap on 'Take from Camera' button.
 */
- (IBAction)captureFromCamera:(UIButton *)sender
{
    previewImageView.image = nil;
    [self useCamera];
}

/*
 Method to pick image from gallery when user tap on 'Pick from gallery' button.
 */
- (IBAction)pickFromGallery:(UIButton *)sender
{
    previewImageView.image = nil;
    [self useCameraRoll];
}

/*
 Method to get thumbnail of an image when user tap on 'Thumbnail' button.
 */
- (IBAction)getThumbnail:(UIButton *)sender
{
    [self createThumbnail:imageUrl];
}

/*
 Method rotate image on tapping rotate button.
 */
- (IBAction)rotateImage:(UIButton *)sender
{
    isImageRotated = YES;
    
    // Read angle to rotate image from input text field.
    NSInteger angle = [self.inputTextField.text intValue];
   
    // Call image rotation method.
    [self imageRotatedByDegrees:originalImage:angle];
}

/*
 Compress image.
 */
- (IBAction)compressImage:(UIButton *)sender
{
    [self compressPhoto:originalImage];
}

/*
 Method first check that the device on which the application is running has a camera. It then create a UIImagePickerController instance, assign the CameraViewController as the delegate for the object and define the media source as the camera.
 */
-(void)useCamera
{
    // Check if camera is available
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType= UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = NO;
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
        newImage = YES;
    }
    else
    {
        // Show an error measse if device does not have camera.
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Message"
                              message: @"Camera is not available on the device"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

/*
 Method set the photo source to Image-view and newImage flag is set to NO (since the photo is already in the library we don’t need to save it again).
 */
-(void)useCameraRoll
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = NO;
        imagePicker.delegate = self;
        if([self isPad])
        {
            // Display pop over in case of iPad only
            popover = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
            [popover presentPopoverFromRect:CGRectMake(0.0f, 415.0f, 750.0f, 1000.0f) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            [popover setDelegate:self];
        }
        else
        {
            [self presentModalViewController:imagePicker animated:YES];
        }
        
        newImage = NO;
    }
}

/*
 DidFinishPickingMediaWithInfo method is called when the user has taken image.
 */
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self displayPhoto:(NSDictionary *)info];
}

/*
 Method display image on the image-view after tacking from camera or picking from gallery.
 */
-(void)displayPhoto:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        // Get image form the 'info' dictionary return by camera.
        originalImage = [info
                         objectForKey:UIImagePickerControllerOriginalImage];
        
        // Show the image on the imageview.
        imageView.image = originalImage;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        if (newImage)
        {
            // Save the image if user taken a new image from camera.
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeImageToSavedPhotosAlbum:[originalImage CGImage] orientation:(ALAssetOrientation)[originalImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
                if (error)
                {
                    NSLog(@"error");
                }
                else
                {
                    imageUrl = assetURL;
                }
            }];
        }
        else
        {
            // If user picked from gallery then return url of the image.
            imageUrl = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
        }
    }
    [self dismissModalViewControllerAnimated:YES];
}

/*
 Implement the imagePickerControllerDidCancel delegate method which is called if the user cancel the image picker session without taking a picture or making an image selection.
 
 */
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

/*
 Method to take thumbnail of an image.
 */
-(UIImage *)createThumbnail:(NSURL *)imageURL
{
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        CGImageRef iref = [myasset thumbnail];
        if (iref)
        {
            imageThumbnail = [UIImage imageWithCGImage:iref];
            [self.previewImageView setImage:imageThumbnail];
            
            previewImageView.contentMode = UIViewContentModeScaleAspectFit;
            
            [self saveImage:imageThumbnail];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Error, can't get image - %@",[myerror localizedDescription]);
    };
    
    if(imageURL)
    {
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:imageURL
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
    return imageThumbnail;
}

/*
 Method to compress image.
 */
-(NSData *)compressPhoto:(UIImage *)actualImage
{
    UIImage *image = actualImage;
    
    float compression = 1.0f;
    NSData* data = UIImageJPEGRepresentation(image, compression);
    while(data.length > maximumCompressionLimit)
    {
        compression -= .1f;
        data = UIImageJPEGRepresentation(image, compression);
    }
    
    compressedImage = [UIImage imageWithData:data];
    [self.previewImageView setImage:compressedImage];
    previewImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self saveImage:compressedImage];
    
    return data;
}

/*
 Method set maximum compression limit for image compression.
 */
-(void)returnMaxCompressionLimit:(NSUInteger)maxSize
{
    maximumCompressionLimit = maxSize;
}

/*
 Method rotate image clock wise and counter clock wise .
 User need to enter angle to rotate.
 */
- (UIImage *)imageRotatedByDegrees:(UIImage *)image:(NSInteger)degree
{
    // Calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degree));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degree));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2,
                                          -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Save rotated image to the photo gallery.
    [self saveImage:rotatedImage];
    
    return rotatedImage;    
}

/*
 Method to save an image to photo gallery.
 */
-(void)saveImage:(UIImage *)processImage
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:[processImage CGImage] orientation:(ALAssetOrientation)[originalImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error)
     {
         if (error)
         {
             NSLog(@"error");
         }
         else
         {
             NSLog(@"assestUrl %@", assetURL);
             
             saveImageString = [assetURL absoluteString];
             if(isImageRotated)
             {
                 // Call method to display rotated image.
                 [self showRotatedImage];
                 isImageRotated = NO;
             }
         }
     }];
}

/*
 Method display rotated image.
 */
-(void)showRotatedImage
{
    // Display captured image.
    ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset)
    {
        UIImage *image;
        ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
        image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
        
        previewImageView.contentMode = UIViewContentModeScaleAspectFit;
        previewImageView.image = image;
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock  = ^(NSError *error)
    {
        NSLog(@"Unresolved error: %@, %@", error, [error localizedDescription]);
    };
    
    ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init] ;
    
    [assetsLibrary assetForURL:[NSURL URLWithString:saveImageString]
                   resultBlock:resultBlock
                  failureBlock:failureBlock];
}

/*
 Function to Close OnScreen Keyboard when Done Button is tapped.
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textfield
{
    [textfield resignFirstResponder];
    return YES;
}


@end
