//
//  MerchantImageCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/1.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "MerchantImageCell.h"

@implementation MerchantImageCell
{
    UIImageView *_shopImage;
    UIView *_bgView;
    
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _bgView    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) ];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        _shopImage = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, _bgView.width - 2, _bgView.height - 2)];
        [_bgView addSubview:_shopImage];
    }
    return self;
}


- (void)setMerchantsModel:(MainMerchantsModel *)merchantsModel {
    _merchantsModel = merchantsModel;
    [_shopImage sd_setImageWithURL:[NSURL URLWithString:_merchantsModel.merchants_image] placeholderImage:PlaceHolder];
}

@end
