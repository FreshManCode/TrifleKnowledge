//
//  CourseTableViewCell.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "CourseTableViewCell.h"

@implementation CourseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"CourseTableViewCell";
    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CourseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    if (!_courseImage) {
        _courseImage = [[UIImageView alloc]init];
        _courseName.contentMode = UIViewContentModeScaleAspectFill;
    }
    [self addSubview:_courseImage];
    
    if (!_courseName) {
        _courseName = [[UILabel alloc]init];
        _courseName.textAlignment = NSTextAlignmentLeft;
        _courseName.font = [UIFont systemFontOfSize:15.0f];
        _courseName.numberOfLines = 0;
    }
    [self addSubview:_courseName];
    
    if (!_couseIntro) {
        _couseIntro = [[UILabel alloc]init];
        _couseIntro.textAlignment = NSTextAlignmentLeft;
        _couseIntro.font = [UIFont systemFontOfSize:15.0f];
        _couseIntro.numberOfLines = 0;
    }
    [self addSubview:_couseIntro];
    
    if (!_sepratorLineView) {
        _sepratorLineView = [[UIView alloc] init];
        _sepratorLineView.frame = CGRectMake(10, 80 -1, SCREENWIDTH -20, 1.0);
        _sepratorLineView.backgroundColor = [UIColor lightGrayColor];
    }
    [self addSubview:_sepratorLineView];
    
}


- (void)layoutSubviews {
    _courseImage.frame = CGRectMake(10, 10, 60, 60);
    _courseName.frame  = CGRectMake(CGRectGetMaxX(_courseImage.frame)+ 5, 15, SCREENWIDTH -70, 20);
    _couseIntro.frame  =
    CGRectMake(CGRectGetMaxX(_courseImage.frame) + 5, 15+20+10,SCREENWIDTH-70 , 20);
}


- (void)setCourseModel:(CourseListModel *)courseModel {
    _courseModel = courseModel;
    [_courseImage sd_setImageWithURL:[NSURL URLWithString:courseModel.PhotoURL] placeholderImage:nil];
    _couseIntro.text = courseModel.CourseName;
    _courseName.text = courseModel.SchoolName;
//    CGSize size1 = [_couseIntro.text getAttributionHeightWithLineSpace:8.0f font:[UIFont systemFontOfSize:15.0f] width:SCREENWIDTH-70];
//
//    CGSize size = [_courseName.text getAttributionHeightWithString:_courseName.text lineSpace:8.0f font:[UIFont systemFontOfSize:15.0f] width:SCREENWIDTH-70 ];
//    NSLog(@"文字的宽搞为:%f--%f",size.width,size.height);
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"cellType"]) {
        CourseTableViewCellType cellType = [ change[NSKeyValueChangeNewKey] integerValue];
        _cellType = cellType;
        [self layoutIfNeeded];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"cellType"];
}

@end


@implementation CourseScrollCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"CourseScrollCell";
    CourseScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CourseScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, SCREENWIDTH, 80);
        _scrollView.bounces = YES;
    }
    [self addSubview:_scrollView];
}


- (void)setScrollArray:(NSArray *)scrollArray {
    _scrollArray = scrollArray;
    if (_scrollArray.count>0 ) {
        CGFloat offX    = 5;
        CGFloat originY = 5;
        CGFloat width   = 150;
        CGFloat height  = 70;
        for (int i=0;i<_scrollArray.count;i++) {
            _scrollImage = [[UIImageView alloc]initWithFrame: CGRectMake(offX + (offX +width) *i, originY, width, height)];
            _scrollImage.tag = 10 + i;
            AlbumListModel *listModel = _scrollArray[i];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickCourseIndex:)];
            _scrollImage.userInteractionEnabled = YES;
            [_scrollImage sd_setImageWithURL:
             [NSURL URLWithString:listModel.PhotoURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            [_scrollImage addGestureRecognizer:tapGesture];
            [_scrollView addSubview:_scrollImage];
        }
        _scrollView.contentSize = CGSizeMake((_scrollArray.count ) *155, 80);
    }
    
}

- (void)didClickCourseIndex:(UITapGestureRecognizer *)gesture {
    UIEvent *event     = [[UIEvent alloc]init];
    CGPoint location   = [gesture locationInView:gesture.view];
    UIView  *superView = [gesture.view hitTest:location withEvent:event];
    if ([superView isKindOfClass:[UIImageView class]]) {
        if (_courseClick) {
            _courseClick(superView.tag -10);
        }
    }
}

@end
