//
//  SSPullToRefreshDefaultContentView
//  SSPullToRefresh
//
//  Created by Sam Soffes on 4/9/12.
//  Copyright (c) 2012-2014 Sam Soffes. All rights reserved.
//

#import "SSPullToRefreshDefaultContentView.h"

@implementation SSPullToRefreshDefaultContentView

@synthesize statusLabel = _statusLabel;
@synthesize lastUpdatedAtLabel = _lastUpdatedAtLabel;
@synthesize activityIndicatorView = _activityIndicatorView;

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

		_lastUpdatedAtLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 34.0, width, 20.0)];
		_lastUpdatedAtLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_lastUpdatedAtLabel.font = [UIFont systemFontOfSize:12.0];
		_lastUpdatedAtLabel.textColor = [UIColor lightGrayColor];
		_lastUpdatedAtLabel.backgroundColor = [UIColor clearColor];
		_lastUpdatedAtLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_lastUpdatedAtLabel];

        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityIndicatorView.frame = CGRectMake(30.0, 25.0, 20.0, 20.0);
		[self addSubview:_activityIndicatorView];
	}
	return self;
}


#pragma mark - SSPullToRefreshContentView

- (void)setState:(SSPullToRefreshViewState)state withPullToRefreshView:(SSPullToRefreshView *)view {
	switch (state) {
		case SSPullToRefreshViewStateReady: {
			self.statusLabel.text = NSLocalizedString(@"Release to refresh…", nil);
			[self.activityIndicatorView stopAnimating];
			break;
		}
		case SSPullToRefreshViewStateNormalHidden:
		case SSPullToRefreshViewStateNormal: {
			self.statusLabel.text = NSLocalizedString(@"Pull down to refresh…", nil);
			[self.activityIndicatorView stopAnimating];
			break;
		}

		case SSPullToRefreshViewStateLoading:
		case SSPullToRefreshViewStateClosing: {
			self.statusLabel.text = NSLocalizedString(@"Loading…", nil);
			[self.activityIndicatorView startAnimating];
			break;
		}
	}
}


- (void)setLastUpdatedAt:(NSDate *)date withPullToRefreshView:(SSPullToRefreshView *)view {
	static NSDateFormatter *dateFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.formatterBehavior = NSDateFormatterBehavior10_4;
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
	});

	self.lastUpdatedAtLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Last Updated: %@", nil),
									[dateFormatter stringForObjectValue:date]];
}

@end
