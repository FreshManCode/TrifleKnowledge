//
//  InsertOneImageCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/8.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "InsertOneImageCell.h"

@implementation InsertOneImageCell
{
    UIImageView *_imageView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 65)];
        _imageView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setListModel:(AlbumListModel *)listModel {
    _listModel = listModel;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:listModel.PhotoURL] placeholderImage:PlaceHolder];
}


@end
