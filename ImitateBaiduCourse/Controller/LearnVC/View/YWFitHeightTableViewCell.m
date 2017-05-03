//
//  YWFitHeightTableViewCell.m
//  ImitateBaiduCourse
//
//  Created by 张君君 on 17/5/3.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWFitHeightTableViewCell.h"

static NSString *const kIdentifier = @"YWFitHeightTableViewCellIdentifier";

@implementation YWFitHeightTableViewCell
{
    UILabel *_contentLabel;
    UIView  *_sepratorLine;
    UILabel *_subLab;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    YWFitHeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (!cell) {
        cell = [[YWFitHeightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = Font(14.0f);
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_contentLabel];
        _sepratorLine = [[UIView alloc]init];
        _sepratorLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_sepratorLine];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _sepratorLine.frame = CGRectMake(10, self.height - 0.6,kScreen_Width - 10, 0.6);
}


- (void)setContent:(NSString *)content {
    _content = content;
    CGSize size = [content boundingRectWithSize:CGSizeMake(kScreen_Width - 20, MAXFLOAT) font:_contentLabel.font lineSpacing:9.0f];
    NSMutableAttributedString *atrributeString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 9.0f;
    [atrributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
    [atrributeString addAttribute:NSFontAttributeName value:_contentLabel.font range:NSMakeRange(0, content.length)];
    _contentLabel.frame = CGRectMake(10, 10, kScreen_Width - 20, size.height);
    _contentLabel.attributedText =atrributeString;
}

+ (CGFloat)cellHeightWithContent:(NSString *)content {
    CGSize size = [content boundingRectWithSize:CGSizeMake(kScreen_Width - 20, MAXFLOAT) font:Font(14) lineSpacing:9.0f];
    return size.height + 20;
}

@end
