//
//  ViewController.h
//  PictureLibrary
//
//  Created by Lion User on 08/10/2012.
//  Copyright (c) 2012 Optimus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PicterViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>
{
    BOOL newImage;
    UIPopoverController *popover;
    NSURL *imageUrl;
    UIImage *originalImage;    
    UIImage *imageThumbnail;   
    UIImage *compressedImage;
    NSURL *savedImageUrl;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *previewImageView;
@property (nonatomic, readwrite) BOOL isImageSave;

- (IBAction)captureFromCamera:(UIButton *)sender;
- (IBAction)pickFromGallery:(UIButton *)sender;
- (IBAction)getThumbnail:(UIButton *)sender;
- (IBAction)rotateImage:(UIButton *)sender;
- (IBAction)compressImage:(UIButton *)sender;

/** Open camera to take a picture.
 *
 * User can take a picture from camera.
 */
-(void)useCamera;

/** Open picture gallery.
 *
 * User can pick a picture from picture gallery.
 */
-(void)useCameraRoll;

/** Compress image.
 *
 * @param UIImage actualImage
 * User can compress an image by tapping on Compress button
 */
-(NSData *)compressPhoto:(UIImage *)actualImage;

/** Rotate a image.
 *
 * @param UIImage image
 * User can rotate an image by tapping on Rotate button.
 */
-(UIImageOrientation )rotatePhoto:(UIImage *)image;

/** Create thumbnail of an image.
 *
 * @param UIImage actualImage
 * User can create thumbnail image by tapping on Create Thumbnail button.
 */
-(UIImage *)createThumbnail:(NSURL *)imageURL;

/** Set maiximum size for comress image.
 *
 * @param NSUInteger maxSize
 * If a developer want to change default compress size(1Mb) then he can set his own compression size by calling this method.
 */
-(void)returnMaxCompressionLimit:(NSUInteger)maxSize;
@end
