//
//  PopoverManager.m
//  PopoverManager
//
//  Created by Lorenzo Rey Vergara on Jan 4, 2017.
//  Copyright © 2017 By Implication, Inc. All rights reserved.
//

#define IPAD    UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#import "PopoverManager.h"
#import "PopoverView.h"

#import <React/RCTBridge.h>
#import <React/RCTModalHostViewController.h>
#import <React/RCTTouchHandler.h>
#import <React/RCTShadowView.h>
#import <React/RCTUtils.h>

@interface PopoverShadowView : RCTShadowView

@end

@implementation PopoverShadowView

- (void)insertReactSubview:(id<RCTComponent>)subview atIndex:(NSInteger)atIndex
{
	[super insertReactSubview:subview atIndex:atIndex];
	if ([subview isKindOfClass:[RCTShadowView class]]) {
		CGRect frame = {.origin = CGPointZero, .size = RCTScreenSize()};
		[(RCTShadowView *)subview setFrame:frame];
	}
}

@end

@interface PopoverManager () <PopoverViewInteractor, UIPopoverPresentationControllerDelegate>
@property (nonatomic, copy) RCTDirectEventBlock onClose;
@end

@implementation PopoverManager
{
	NSHashTable *_hostViews;
}

RCT_EXPORT_MODULE()

- (UIView *)view
{
	PopoverView *view = [[PopoverView alloc] initWithBridge:self.bridge];
	view.delegate = self;
	if (!_hostViews) {
		_hostViews = [NSHashTable weakObjectsHashTable];
	}
	[_hostViews addObject:view];
	return view;
}

- (void)presentPopoverView:(PopoverView *)popoverView withViewController:(RCTModalHostViewController *)viewController animated:(BOOL)animated
{
	UIView *v;
	if (IPAD){
		v = [[UIView alloc] initWithFrame: CGRectMake([popoverView.originX doubleValue], [popoverView.originY doubleValue], [popoverView.originW doubleValue], [popoverView.originH doubleValue])];
		v.hidden = YES;
		[[popoverView reactViewController].view addSubview: v];
		
		viewController.modalPresentationStyle = UIModalPresentationPopover;
		viewController.preferredContentSize = CGSizeMake([popoverView.popoverW doubleValue], [popoverView.popoverH doubleValue]);
		viewController.popoverPresentationController.sourceView = v;
		viewController.popoverPresentationController.sourceRect = v.bounds;
		viewController.popoverPresentationController.delegate = self;
		self.onClose = popoverView.onClose;
	}
	
	dispatch_block_t completionBlock = ^{
		if (popoverView.onShow) {
			popoverView.onShow(nil);
			[v removeFromSuperview];
		}
	};
	if (_presentationBlock) {
		_presentationBlock([popoverView reactViewController], viewController, animated, completionBlock);
	} else {
		[[popoverView reactViewController] presentViewController:viewController animated:animated completion:completionBlock];
	}
}

- (void)dismissPopoverView:(PopoverView *)popoverView withViewController:(RCTModalHostViewController *)viewController animated:(BOOL)animated
{
	if (_dismissalBlock) {
		_dismissalBlock([popoverView reactViewController], viewController, animated, nil);
	} else {
		[viewController dismissViewControllerAnimated:animated completion:^{
			if(popoverView.onClose){
				popoverView.onClose(nil);
			}
		}];
	}
}


- (RCTShadowView *)shadowView
{
	return [PopoverShadowView new];
}

- (void)invalidate
{
	for (PopoverView *hostView in _hostViews) {
		[hostView invalidate];
	}
	[_hostViews removeAllObjects];
}

-(void) popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
	if(self.onClose){
		self.onClose(nil);
	}
}

RCT_EXPORT_VIEW_PROPERTY(transparent, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onShow, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onClose, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(supportedOrientations, NSArray)
RCT_EXPORT_VIEW_PROPERTY(onOrientationChange, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(originX, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(originY, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(originW, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(originH, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(popoverW, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(popoverH, NSNumber)

@end

