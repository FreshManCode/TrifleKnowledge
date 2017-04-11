//
//  TestTableViewCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/11.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "TestTableViewCell.h"

@interface TestTableViewCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UIButton * openButton;

@end


@implementation TestTableViewCell

static NSString *identifier = @"TestTableViewCell.h";

+ (instancetype)cellWithTableView:(UITableView*)tableView {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel      = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH - 80, 15)];
        _nameLabel.font = Font(15.0f);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor     = [UIColor lightGrayColor];
    }
    return _nameLabel;
}

- (UIButton *)openButton {
    if (!_openButton) {
        _openButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 50, _nameLabel.top,40 , 20)];
        _openButton.selected = NO;
        [_openButton setTitle:@"展开" forState:UIControlStateNormal];
        [_openButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _openButton.titleLabel.font = Font(15.0f);
        [_openButton addTarget:self action:@selector(openOrCloseEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openButton;
}

- (void)setUpSubViews {
    [self addSubview:[self nameLabel]];
    
    [self addSubview:[self openButton]];
    
}

- (void)setModel:(TestClickModel *)model {
    _model = model;
    _nameLabel.text = model.title;
}


- (void)openOrCloseEvent:(UIButton *)sender {
    if (self.OpenViewClick) {
        self.OpenViewClick(sender);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
