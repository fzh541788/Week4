//
//  TodaySingleTableViewCell.m
//  Forecast
//
//  Created by young_jerry on 2020/8/8.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import "TodaySingleTableViewCell.h"

@implementation TodaySingleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.titleLabel = [[UILabel alloc] init];
    self.contentLabel = [[UILabel alloc] init];
    self.titleproLabel = [[UILabel alloc]init];
    self.contentproLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleproLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.contentproLabel];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleproLabel.frame = CGRectMake(250, 10, 375, 20);
    self.titleproLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.frame = CGRectMake(20, 10, 375, 20);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.frame = CGRectMake(20, 35, 375, 40);
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentproLabel.frame = CGRectMake(250, 35, 375, 40);
    self.contentproLabel.font = [UIFont systemFontOfSize:15];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
