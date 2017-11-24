//
//  SmoothScaledEGOImageView.m
//  Mall
//
//  Created by Jackson Fu on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SmoothScaledEGOImageView.h"

@interface SmoothScaledEGOImageView () {
    
    CGRect _frame;
}

@end

@implementation SmoothScaledEGOImageView

- (void)setImageURL:(NSURL *)imageURL {
    super.imageURL = imageURL;
    _frame = self.frame;
    
    if (self.delegate == nil) {
        self.delegate = self;
    }
    
    [self scaleImage:self];

}

- (void)imageViewLoadedImage:(EGOImageView *)imageView {
    [self scaleImage:imageView];
}

- (void)scaleImage:(EGOImageView *)imageView {
    
    CGSize newSize = _frame.size;
    CGFloat scaled = imageView.image.size.width/newSize.width;
    newSize.height = imageView.image.size.height/scaled;
    
    imageView.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
//    [self scaleImage:self];
}

@end


@interface SmoothScaledEGOImageButton() {
    
    CGRect _frame;
}

@end

@implementation SmoothScaledEGOImageButton
@synthesize smoothScaledEGOImageButtonDelegate;

- (void)setImageURL:(NSURL *)imageURL {
    
    _frame = self.frame;
    
    if (self.delegate == nil) {
        self.delegate = self;
    }
    
    super.imageURL = imageURL;
    
    [self scaleImage:self];
    
}

- (void)scaleImage:(EGOImageButton *)imageButton {
    CGSize newSize = _frame.size;
    CGFloat scaled = imageButton.imageView.image.size.width/newSize.width;
    newSize.height = imageButton.imageView.image.size.height/scaled;
    
    imageButton.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
}

- (void)imageButtonLoadedImage:(EGOImageButton *)imageButton {
    [self scaleImage:imageButton];
    
    if (smoothScaledEGOImageButtonDelegate != nil) {
        [smoothScaledEGOImageButtonDelegate imageDidLoad:imageButton.imageView.image index:imageButton.tag];
    }
}

@end