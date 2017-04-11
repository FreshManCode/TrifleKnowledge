//
//  InsertCollectionViewCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/8.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "InsertCollectionViewCell.h"
#import <YYKit.h>

@interface InsertCollectionViewCell ()
@property (nonatomic,strong) YYAnimatedImageView *imageIcon;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UILabel * describeLab;
@property (nonatomic,strong) UILabel * tapLabel;

@end

@implementation InsertCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    
    return self;
}

- (void)setUpSubViews {
    if (!_imageIcon) {
        _imageIcon = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
//        _imageIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    [self addSubview:_imageIcon];
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageIcon.bottom + 10, _imageIcon.width, 15.0f)];
        _titleLab.font = Font(14.0f);
        _titleLab.text = @"Python精品课程";
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor     = [UIColor lightGrayColor];
    }
    [self addSubview:_titleLab];
    
    if (!_describeLab) {
        _describeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLab.bottom + 10, _titleLab.width, 15.0f)];
        _describeLab.font = Font(12.0f);
        _describeLab.text = @"让你从Python从入门到放弃到死去";
        _describeLab.textAlignment = NSTextAlignmentLeft;
        _describeLab.textColor = [UIColor lightGrayColor];
    }
    [self addSubview:_describeLab];
    
    _tapLabel = [UILabel new];
    _tapLabel.size = self.size;
    _tapLabel.text = @"加载失败,点击重试";
    _tapLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _tapLabel.hidden = YES;
    _tapLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:_tapLabel];
    __weak typeof(self) weakSelf = self;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf setImageURL:[NSURL URLWithString:weakSelf.listModel.PhotoURL]];
    }];
    [_tapLabel addGestureRecognizer:tapGesture];
    
}



- (void)setListModel:(CourseListModel *)listModel {
    _listModel = listModel;
    [self setImageURL:[NSURL URLWithString:_listModel.PhotoURL]];
    _titleLab.text    = _listModel.CourseName;
    _describeLab.text = _listModel.SchoolName;
    
}


- (void)setImageURL:(NSURL *)url {
    __weak typeof(self) weakSelf = self;
    [_imageIcon setImageWithURL:url
                    placeholder:PlaceHolder
                        options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation
                     completion:^(UIImage * image, NSURL * url, YYWebImageFromType from, YYWebImageStage stage, NSError * error) {
                         if (!image) {
                             weakSelf.tapLabel.hidden = NO;
                         }
                     }];
    
    
    
}

@end
