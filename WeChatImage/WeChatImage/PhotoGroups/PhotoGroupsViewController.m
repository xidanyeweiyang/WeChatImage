//
//  PhotoGroupsViewController.m
//  WeChatImage
//  相册分类列表; 列入微信, 截图, QQ等
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "PhotoGroupsViewController.h"
#import "PhotoGroupTableViewCell.h"
#import "GroupModle.h"
#import "PhotosListViewController.h"



@interface PhotoGroupsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation PhotoGroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismissAction:)];
    // Do any additional setup after loading the view.
}

- (void)dismissAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark    UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupModle.kindArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoGroupTableViewCell" forIndexPath:indexPath];
    [cell displayCellWithDataSource:self.groupModle.kindArr indexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak PhotoGroupsViewController *weakSelf = self;
    NSDictionary *data = self.groupModle.kindArr[indexPath.row];
    PHFetchResult *result = data[@"result"];
    if (result.count > 0) {
        PhotosListViewController *listC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotosListViewController"];
        [[ImageHelper shareImageHelper] getAllImageActionWithCollection:result];
        [self presentViewController:listC animated:YES completion:^{
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:weakSelf.navigationController.viewControllers];
            for (UIViewController *conC in arr) {
                if ([conC isKindOfClass:[PhotoGroupsViewController class]]) {
                    [arr removeObject:conC];
                    break;
                }
            }
            weakSelf.navigationController.viewControllers = arr;
        }];

    }
}



#pragma mark    Case
- (GroupModle *)groupModle {
    if (!_groupModle) {
        _groupModle = [[GroupModle alloc] init];
    }
    return _groupModle;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
