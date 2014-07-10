//
//  LocationTableViewCell.m
//  wink
//
//  Created by Diogo Magalhaes martins on 7/2/14.
//  Copyright (c) 2014 Diogo Magalhaes martins. All rights reserved.
//

#import "LocationTableViewCell.h"

@implementation LocationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height /2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 2;
    self.imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.imageView.clipsToBounds = YES;
}
@end
