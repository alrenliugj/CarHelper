//
//  GJMineVC.m
//  CarHelper
//
//  Created by Arlenly on 2018/6/12.
//  Copyright © 2018年 CAR. All rights reserved.
//

#import "GJMineVC.h"
#import "GJAppSettingVC.h"
#import "GJMineTopCell.h"
#import "GJNormalTBVCell.h"
#import "GJNormalCellModel.h"
#import "GJMessageListVC.h"

@interface GJMineVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJNormalCellModel *> *models;
@property (nonatomic, strong) GJMineTopCell *topCell;
@end

@implementation GJMineVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setStatusBarLight:NO];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _topCell = [[GJMineTopCell alloc] init];
    
    GJNormalCellModel *model1 = [GJNormalCellModel cellModelTitle:@"轨迹" detail:@"" imageName:@"setup" acessoryType:UITableViewCellAccessoryDisclosureIndicator];
    GJNormalCellModel *model2 = [GJNormalCellModel cellModelTitle:@"订单" detail:@"" imageName:@"setup" acessoryType:UITableViewCellAccessoryDisclosureIndicator];
    GJNormalCellModel *model3 = [GJNormalCellModel cellModelTitle:@"我的车辆" detail:@"" imageName:@"setup" acessoryType:UITableViewCellAccessoryDisclosureIndicator];
    GJNormalCellModel *model4 = [GJNormalCellModel cellModelTitle:@"支付方式" detail:@"" imageName:@"setup" acessoryType:UITableViewCellAccessoryDisclosureIndicator];
    GJNormalCellModel *model5 = [GJNormalCellModel cellModelTitle:@"帮助中心" detail:@"" imageName:@"setup" acessoryType:UITableViewCellAccessoryDisclosureIndicator];
    _models = @[model1, model2, model3, model4, model5];
    
    model1.didSelectBlock = ^(NSIndexPath *indexPath) {
        
    };
    model2.didSelectBlock = ^(NSIndexPath *indexPath) {
        
    };
    model3.didSelectBlock = ^(NSIndexPath *indexPath) {
        
    };
    model4.didSelectBlock = ^(NSIndexPath *indexPath) {
        
    };
    model5.didSelectBlock = ^(NSIndexPath *indexPath) {
        
    };
}

- (void)initializationSubView {
    self.title = @"我的";
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AdaptatSize(60), 44)];
    UIButton *setupBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AdaptatSize(30), 44)];
    [setupBtn setImage:[UIImage imageNamed:@"setup"] forState:UIControlStateNormal];
    [setupBtn addTarget:self action:@selector(setupAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *msgBtn = [[UIButton alloc] initWithFrame:CGRectMake(AdaptatSize(30), 0, AdaptatSize(30), 44)];
    [msgBtn setImage:[UIImage imageNamed:@"search_magnifier"] forState:UIControlStateNormal];
    [msgBtn addTarget:self action:@selector(msgAction) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:setupBtn];
    [rightView addSubview:msgBtn];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = right;
    
    [self.view addSubview:self.tableView];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)setupAction {
    GJAppSettingVC *vc = [[GJAppSettingVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)msgAction {
    GJMessageListVC *vc = [[GJMessageListVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return _topCell;
    }else {
        GJNormalTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJNormalTBVCell reuseIndentifier]];
        if (!cell) {
            cell = [[GJNormalTBVCell alloc] initWithStyle:[GJNormalTBVCell expectingStyle] reuseIdentifier:[GJNormalTBVCell reuseIndentifier]];
            [cell settingShowSpeatLine:YES];
        }
        cell.textLabel.font = [APP_CONFIG appAdaptFontOfSize:15];
        cell.cellModel = _models[indexPath.row - 1];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return _topCell.height;
    }else {
        return AdaptatSize(54);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        BLOCK_SAFE(_models[indexPath.row - 1].didSelectBlock)(indexPath);
    }
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = APP_CONFIG.appBackgroundColor;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
