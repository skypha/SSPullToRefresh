//
//  SSPullToRefreshSimpleContentViewCustomIndicator.h
//  SSPullToRefresh
//
//  Created by Sam Soffes on 5/17/12.
//  Copyright (c) 2012-2014 Sam Soffes. All rights reserved.
//

#import "SSPullToRefreshView.h"

@protocol SSActivityView <NSObject>
	-(void)startAnimating;
	-(void)stopAnimating;
@end

@interface SSPullToRefreshSimpleContentViewCustomIndicator: UIView <SSPullToRefreshContentView>

@property (nonatomic, readonly) UILabel *statusLabel;
@property (nonatomic, readwrite) UIView<SSActivityView> *activityIndicatorView;
@property (nonatomic, readwrite) NSDictionary<NSNumber*, NSString*>* textForState;

@end
