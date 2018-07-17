//
//  SSPullToRefreshSimpleContentViewCustomIndicator.m
//  SSPullToRefresh
//
//  Created by Bohms, Markus on 12.07.18.
//  Copyright © 2018 Bohms, Markus. All rights reserved.
//

#import "SSPullToRefreshSimpleContentViewCustomIndicator.h"

@implementation SSPullToRefreshSimpleContentViewCustomIndicator

@synthesize statusLabel = _statusLabel;
@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize textForState = _textForState;

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		CGFloat width = self.bounds.size.width;

		_statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 14.0, width, 20.0)];
		_statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_statusLabel.font = [UIFont boldSystemFontOfSize:14.0];
		_statusLabel.textColor = [UIColor blackColor];
		_statusLabel.backgroundColor = [UIColor clearColor];
		_statusLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_statusLabel];
	}
	return self;
}

- (void)setActivityIndicatorView:(UIView<SSActivityView> *)activityIndicatorView {
	if (_activityIndicatorView != nil) {
		[_activityIndicatorView removeFromSuperview];
	}
	_activityIndicatorView = activityIndicatorView;
	_activityIndicatorView.frame = CGRectMake(30.0, 25.0, 20.0, 20.0);
	[self addSubview:_activityIndicatorView];
}

- (void)layoutSubviews {
	CGSize size = self.bounds.size;
	self.statusLabel.frame = CGRectMake(20.0, round((size.height - 30.0) / 2.0), size.width - 40.0, 30.0);
	self.activityIndicatorView.frame = CGRectMake(round((size.width - 40.0) / 2.0), round((size.height - 28.0) / 2.0), 40.0, 40.0);
}

#pragma mark - SSPullToRefreshContentView

- (void)setState:(SSPullToRefreshViewState)state withPullToRefreshView:(SSPullToRefreshView *)view {
	NSString* key = [self.textForState objectForKey: [NSNumber numberWithInt:state]];
	if (key != nil) {
		NSLocalizedString(key, nil);
	}

	switch (state) {
		case SSPullToRefreshViewStateReady: {
			self.statusLabel.text = key;
			if (key == nil) {
				self.statusLabel.alpha = 0.0;
				[self.activityIndicatorView startAnimating];
				self.activityIndicatorView.alpha = 1.0;
			}
			break;
		}

		case SSPullToRefreshViewStateNormal: {
			self.statusLabel.text = key;
			self.statusLabel.alpha = 1.0;
			[self.activityIndicatorView stopAnimating];
			self.activityIndicatorView.alpha = 0.0;
			break;
		}

		case SSPullToRefreshViewStateLoading: {
			self.statusLabel.alpha = 0.0;
			[self.activityIndicatorView startAnimating];
			self.activityIndicatorView.alpha = 1.0;
			break;
		}

		case SSPullToRefreshViewStateClosing: {
			self.statusLabel.text = nil;
			self.activityIndicatorView.alpha = 0.0;
			break;
		}
		case SSPullToRefreshViewStateNormalHidden: {
			self.statusLabel.text = nil;
			self.statusLabel.alpha = 0.0;
			self.activityIndicatorView.alpha = 0.0;
			break;
		}
	}
}

@end
