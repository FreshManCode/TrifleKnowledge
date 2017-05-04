//
//  YWFitHeightViewControler.m
//  ImitateBaiduCourse
//
//  Created by 张君君 on 17/5/3.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWFitHeightViewControler.h"
#import "YWFitHeightTableViewCell.h"

@interface YWFitHeightViewControler () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation YWFitHeightViewControler
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    self.title = @"计算cell的高度";
    [self setUpUI];
    [super viewDidLoad];
}

- (void)setUpUI {
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"对NSString进行以下方法的增加。",
                  @"NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];\nNSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];\nparagraphStyle.lineSpacing = lineSpacing;\n[attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];\n[attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];\nNSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;\nCGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];",
                  @"阿里腾讯都到百度去挖AI大牛，百度为何对此不care? IS THIS TRue ?",
                  @"友商的策反、资本的助推，成为AI人才流动的加速器。然而，既然你能挖来人才，别的公司也可能从你公司挖走。因此，只挖人是不够的，互联网公司还要提供一个好的研发机制和氛围。",
                  @"几年前，中国互联网公司只有百度在积极地投资人工智能，李彦宏到处摇旗呐喊，主动地做起了人工智能在中国的步道师。今天，人工智能市场热闹了起来，百度不再孤独。",
                  @"做不做人工智能，早已不是问题。怎么做，才是关键。互联网公司以人为本，当他们一拥而入进入某个领域，无可避免地就会上演人才争夺战。人工智能大战的本质就是一场智力竞赛，谁能吸引到世界上最聪明的人谁就可能赢。大数据只能算是人工智能的第二要素，人才是人工智能的第一要素。因此，人工智能的人才争夺大战更加惨烈。哪怕有互联网招聘网站的冲击，猎头公司的生意一夜之间又好了起来。百度附近的咖啡厅门庭若市——要挖人工智能的人才，首选目标是百度。This is a real story.and the main character died at the end",
                  @"最近半年不少人工智能大牛离开了百度，余凯、吴恩达、张潼……用媒体的话说，百度人工智能进入了动荡期。之所以如此，一个根本原因是人工智能进入黄金发展期之后，人才流动加速的必然。",
                  @"最近半年不少人工智能大牛离开了百度，余凯、吴恩达、张潼……用媒体的话说，百度人工智能进入了动荡期。之所以如此，一个根本原因是人工智能进入黄金发展期之后，人才流动加速的必然。\ninitWithString:self];\nNSMutableParagraphStyle *paragraphStyle\nhttp://luochao.baijia.baidu.com/article/839119",
                  nil];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHeight], kScreen_Width, kScreen_Height - [self getNavHeight]) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YWFitHeightTableViewCell *cell = [YWFitHeightTableViewCell cellWithTableView:tableView];
    cell.content = _dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YWFitHeightTableViewCell cellHeightWithContent:_dataArray[indexPath.row]];
}

@end

