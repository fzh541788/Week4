//
//  ForecastTableViewCell.m
//  Forecast
//
//  Created by young_jerry on 2020/8/8.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import "ForecastTableViewCell.h"

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.dataLabel = [[UILabel alloc] init];
    self.weatherImageView = [[UIImageView alloc] init];
    self.maxLabel = [[UILabel alloc] init];
    self.minLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.dataLabel];
    [self.contentView addSubview:self.weatherImageView];
    [self.contentView addSubview:self.maxLabel];
    [self.contentView addSubview:self.minLabel];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dataLabel.frame = CGRectMake(20, 10, 120, 30);
    self.weatherImageView.frame = CGRectMake(170, 10, 25,25);
    self.maxLabel.frame = CGRectMake(270, 10, 30, 30);
    self.minLabel.frame = CGRectMake(320, 10, 30, 30);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
