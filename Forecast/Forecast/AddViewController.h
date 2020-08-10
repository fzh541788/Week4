//
//  AddViewController.h
//  Forecast
//
//  Created by young_jerry on 2020/8/5.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddViewControllerDelegate <NSObject>
- (void)presscontent:(NSMutableArray *)array;
@end

@interface AddViewController : UIViewController
@property NSMutableArray *array;
@property id<AddViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
