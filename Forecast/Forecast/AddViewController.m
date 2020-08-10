#import "AddViewController.h"

@interface AddViewController ()
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property UITextField *searchTextFiled;
@property NSMutableArray *searchArray;
@property NSMutableArray *nowArray;
@property UITableView *tableView;

@end

@implementation AddViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    backImageView.image = [UIImage imageNamed:@"back2.jpg"];
//    [self.view addSubview:backImageView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backview2.jpeg"]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 110)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 375, 20)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"输入城市、邮政编码或机场位置";
    label.textAlignment = NSTextAlignmentCenter;
    
    _searchTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 300, 40)];
    _searchTextFiled.backgroundColor = [UIColor whiteColor];
    [_searchTextFiled addTarget:self action:@selector(textFiledChange) forControlEvents:UIControlEventEditingChanged];
    _searchTextFiled.delegate = self;
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(325, 60, 50, 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pressCancel) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view];
    [view addSubview:_searchTextFiled];
    [view addSubview:cancelButton];
    [view addSubview:label];

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, 375, 557) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
       _tableView.separatorStyle=UITableViewCellSeparatorStyleNone; 
    [self.view addSubview:_tableView];
    
    _searchArray = [NSMutableArray array];
    _nowArray = [NSMutableArray array];
    
}

- (void)pressCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)textFiledChange {
    if (_searchTextFiled.text != nil) {
        
        //重新init一下数组 清空数组  不然会保存
        [_searchArray removeAllObjects];
        [self creatPost];
    }
}
    

//  第一响应者:叫出键盘的控件就叫第一响应者 resign辞去第一响应者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchTextFiled resignFirstResponder];
}
//shouldreturn
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchTextFiled resignFirstResponder];
    return YES;
}
- (void)creatPost {
    NSString *str = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=081a92d66f5f4262b5abdcd01d9d068c", _searchTextFiled.text];
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *basic = objc[@"location"];
            for(int i = 0; i < basic.count; i++) {
                NSMutableArray  * name = basic[i][@"name"];
                [self->_searchArray addObject:name];
//                [self->_nowArray addObject:now];
            }
            //想做其他ui操作必须回到主线程 这是第三个
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }];
    [dataTask resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_searchArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if ([_searchArray count] != 0) {
        cell.textLabel.text = _searchArray[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < _array.count; i++) {
        if ([_searchArray[indexPath.row] isEqualToString:_array[i]]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"所选地区已存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:sureAction];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
    }
//    [_array addObject:_searchArray[indexPath.row]];
    [self.delegate presscontent:_searchArray[indexPath.row]];
//    [self.delegate presscontent:_array];
    [self dismissViewControllerAnimated:YES completion:nil];
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
