//
//  PopoverView.h
//  PopoverManager
//
//  Created by Lorenzo Rey Vergara on Jan 4, 2017.
//  Copyright © 2017 By Implication, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RCTInvalidating.h"
#import "PopoverManager.h"
#import "RCTView.h"

@class RCTBridge;
@class RCTModalHostViewController;

@protocol PopoverViewInteractor;

@interface PopoverView : UIView <RCTInvalidating>

@property (nonatomic, assign, getter=isTransparent) BOOL transparent;

@property (nonatomic, copy) RCTDirectEventBlock onShow;

@property (nonatomic, weak) id<PopoverViewInteractor> delegate;

@property (nonatomic, copy) NSArray<NSString *> *supportedOrientations;
@property (nonatomic, copy) RCTDirectEventBlock onOrientationChange;

@property (nonatomic, copy) NSNumber *originX;
@property (nonatomic, copy) NSNumber *originY;
@property (nonatomic, copy) NSNumber *originW;
@property (nonatomic, copy) NSNumber *originH;
@property (nonatomic, copy) NSNumber *popoverW;
@property (nonatomic, copy) NSNumber *popoverH;

- (instancetype)initWithBridge:(RCTBridge *)bridge NS_DESIGNATED_INITIALIZER;

@end

@protocol PopoverViewInteractor <NSObject>

- (void)presentPopoverView:(PopoverView *)popoverView withViewController:(RCTModalHostViewController *)viewController animated:(BOOL)animated;
- (void)dismissPopoverView:(PopoverView *)popoverView withViewController:(RCTModalHostViewController *)viewController animated:(BOOL)animated;

@end
