//
//  SmoothScaledEGOImageView.h
//  Mall
//
//  Created by Jackson Fu on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGOImageView.h"
#import "EGOImageButton.h"

@interface SmoothScaledEGOImageView : EGOImageView <EGOImageViewDelegate>

@end

@protocol SmoothScaledEGOImageButtonDelegate <NSObject>

- (void)imageDidLoad:(UIImage *)image index:(NSInteger)index;

@end
@interface SmoothScaledEGOImageButton : EGOImageButton <EGOImageButtonDelegate>

@property (unsafe_unretained, nonatomic) NSObject<SmoothScaledEGOImageButtonDelegate> *smoothScaledEGOImageButtonDelegate;

@end
