//
//  SquareTableViewCell.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/22.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "SquareTableViewCell.h"

@implementation SquareTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifeir = @"SquareTableViewCellIdentifier";
    SquareTableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:identifeir];
    if (!cell) {
        cell = [[SquareTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifeir];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:_intoLab];                   
    }
    return self;
}

- (void)initSubViews {
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    }
    [self addSubview:_leftIcon];
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_leftIcon.right +10, _leftIcon.top +5, SCREENWIDTH -_leftIcon.width -20, 20)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = Font(16.0);
        [self addSubview:_titleLab];
    }
    
    if (!_intoLab) {
        _intoLab  = [[UILabel alloc]initWithFrame:CGRectMake(_titleLab.left, _titleLab.bottom, _titleLab.width, 40)];
        _intoLab.numberOfLines = 0;
        _intoLab.font = Font(14.0f);
        _intoLab.textAlignment = NSTextAlignmentLeft;
    }
    [self addSubview:_intoLab];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
