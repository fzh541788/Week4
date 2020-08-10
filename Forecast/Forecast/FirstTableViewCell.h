//
//  FirstTableViewCell.h
//  Forecast
//
//  Created by young_jerry on 2020/8/4.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstTableViewCell : UITableViewCell
- (void)give:(NSIndexPath *)indexPath Arr1:(NSMutableArray *)nameArr;
@property UILabel *nowLabel;
@property UILabel *nameLabel;
@end

NS_ASSUME_NONNULL_END
