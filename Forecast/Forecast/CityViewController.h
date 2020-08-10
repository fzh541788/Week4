//
//  CityViewController.h
//  Forecast
//
//  Created by young_jerry on 2020/8/5.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol nowViewControllerDelegate <NSObject>;
- (void)nowcontent:(NSMutableArray *)array;
@end
@interface CityViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property NSMutableArray *array;
@property NSInteger page;
@property id<nowViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
