//
//  ViewController.m
//  Forecast
//
//  Created by young_jerry on 2020/8/4.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableViewCell.h"
#import "AddViewController.h"
#import "CityViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,AddViewControllerDelegate>
@property UIButton* addButton;
@property NSMutableArray *array;
@property NSMutableArray *now;
@property BOOL select;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backview2.jpeg"]];
        _now = [[NSMutableArray alloc]init];
   //正常创建自定义cell
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)style:UITableViewStyleGrouped];
                          _tableView.dataSource = self;
                          _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone; 
                             [self.view addSubview:_tableView];

        [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"111"];
    _array = [[NSMutableArray alloc] init];
            [_array addObject:@"西安"];

 
    //强行再用一次
    for(int i = 0; i < _array.count;i++)
 [self creatPost:_array[i]];
    //设置添加按钮 通过组数*组距来完成
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_addButton setFrame:CGRectMake(330, 600, 50, 50)];
    
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    _addButton.tintAdjustmentMode = YES;
    [_addButton addTarget:self action:@selector(pressSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
}
- (void)creatPost: (NSString*)str{
    NSString *str0 = [NSString stringWithFormat:@"https://yiketianqi.com/api?version=v9&appid=21253683&appsecret=0LXrEm6Y&city=%@", str];
    str0 = [str0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:str0];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
   
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        
        [self.now addObject:dic[@"data"][0][@"tem"]];
        NSLog(@"%@",self->_now[0]);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
                }];

    }];
    [dataTask resume];
}
-(void)pressSearch{
    AddViewController *searchVC = [[AddViewController alloc] init];
    searchVC.delegate = self;
    searchVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:searchVC animated:YES completion:nil];
}
- (void)presscontent:(NSMutableArray *)array{
    [_array addObject:array];
    [_tableView reloadData];
}
//下面4个自定义cell的必备
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
         FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111" forIndexPath:indexPath];
              cell.nameLabel.text = _array[indexPath.row];
    
//    cell.nowLabel.text = _now[indexPath.row ];
    cell.backgroundColor = [UIColor clearColor];
          return cell;
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    导航+UITableView，在push，back回来之后，当前cell仍然是选中的状态的解决方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CityViewController *cityVC = [[CityViewController alloc] init];
    cityVC.array = [NSMutableArray array];
    cityVC.array = _array;
    cityVC.page = indexPath.row;
    cityVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:cityVC animated:YES completion:nil];
}

@end
