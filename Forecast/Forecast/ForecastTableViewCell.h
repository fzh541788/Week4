//
//  ForecastTableViewCell.h
//  Forecast
//
//  Created by young_jerry on 2020/8/8.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForecastTableViewCell : UITableViewCell
@property UILabel *dataLabel;
@property UIImageView *weatherImageView;
@property UILabel *maxLabel;
@property UILabel *minLabel;
@end

NS_ASSUME_NONNULL_END
