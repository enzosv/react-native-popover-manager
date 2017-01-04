//
//  PopoverManager.h
//  PopoverManager
//
//  Created by Lorenzo Rey Vergara on Jan 4, 2017.
//  Copyright © 2017 By Implication, Inc. All rights reserved.
//

#import "RCTViewManager.h"

#import "RCTInvalidating.h"

typedef void (^RCTModalViewInteractionBlock)(UIViewController *reactViewController, UIViewController *viewController, BOOL animated, dispatch_block_t completionBlock);

@interface PopoverManager : RCTViewManager <RCTInvalidating>

/**
 * `presentationBlock` and `dismissalBlock` allow you to control how a Modal interacts with your case,
 * e.g. in case you have a native navigator that has its own way to display a modal.
 * If these are not specified, it falls back to the UIViewController standard way of presenting.
 */
@property (nonatomic, strong) RCTModalViewInteractionBlock presentationBlock;
@property (nonatomic, strong) RCTModalViewInteractionBlock dismissalBlock;

@end
