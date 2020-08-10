//
//  FirstTableViewCell.m
//  Forecast
//
//  Created by young_jerry on 2020/8/4.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell
//
//- (void)give:(NSIndexPath *)indexPath Arr1:(NSMutableArray *)nameArr{
//    self.nameLabel.text = nameArr[indexPath.row];
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _nameLabel = [[UILabel alloc] init];
    _nowLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_nowLabel];
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _nameLabel.frame = CGRectMake(5, 15, 100, 30);
    _nameLabel.font = [UIFont systemFontOfSize:23];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor blackColor];
    
    _nowLabel.frame = CGRectMake(200, 25, 100, 20);
    _nowLabel.font = [UIFont systemFontOfSize:17];
    _nowLabel.textAlignment = NSTextAlignmentCenter;
    _nowLabel.textColor = [UIColor blackColor];
//    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
