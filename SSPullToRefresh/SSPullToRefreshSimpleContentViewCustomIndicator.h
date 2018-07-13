//
//  SSPullToRefreshSimpleContentViewCustomIndicator.h
//  SSPullToRefresh
//
//  Created by Bohms, Markus on 12.07.18.
//  Copyright © 2018 Bohms, Markus. All rights reserved.
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
