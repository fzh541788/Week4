//
//  CityViewController.m
//  Forecast
//
//  Created by young_jerry on 2020/8/5.
//  Copyright © 2020 young_jerry. All rights reserved.
//

#import "CityViewController.h"
#import "TodaySingleTableViewCell.h"
#import "ForecastTableViewCell.h"
@interface CityViewController ()
//最上面的各种图标温度数组
@property NSMutableArray *headViewArray;
//滚动时间预报数组
@property NSMutableArray *hourlyArray;
//中间的天气图片
@property NSMutableArray *weekimageArray;
//最后一部分的名称
@property NSMutableArray *dayArray;
//最后一部分的数据
@property NSMutableArray *contentArray;

@property NSMutableArray *forecastArray;

@property NSString *str;
@property UIScrollView *scrollerView;
@property NSInteger i;
@property UIView *headView;
@end

@implementation CityViewController
@synthesize i;
- (void)viewDidLoad {
   self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backview2.jpeg"]];
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 630)];
        _scrollerView.contentSize = CGSizeMake([_array count] * 375, 650);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.delegate = self;
    
        _dayArray = [NSMutableArray arrayWithObjects:@"日出", @"日落", @"空气质量", @"湿度", @"风速等级", @"风速", @"体感温度", @"气压", @"能见度", @"夜间天气", nil];
        [self.view addSubview:_scrollerView];
         
        _contentArray = [NSMutableArray array];
        _forecastArray = [NSMutableArray array];
        _headViewArray = [NSMutableArray array];
        _hourlyArray = [NSMutableArray array];
        _weekimageArray = [NSMutableArray array];
        for (i = 0; i < [_array count]; i++) {
           
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(375 * i, 0, 375, 630) style:UITableViewStyleGrouped];
            tableView.tag = i;
            [tableView registerClass:[ForecastTableViewCell class] forCellReuseIdentifier:@"forecastCell"];
            [tableView registerClass:[TodaySingleTableViewCell class] forCellReuseIdentifier:@"todaySingelCell"];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            [self creatPost:_array[i] tableView:tableView];
            [_scrollerView addSubview:tableView];
        }
        [_scrollerView setContentOffset:CGPointMake(_page * 375, 0)];

    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 630, 50, 40)];
              [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
              [cancelButton addTarget:self action:@selector(pressCancel)  forControlEvents:UIControlEventTouchUpInside];
              [self.view addSubview:cancelButton];
    }
//设置0前面的高度 正常创建tableviewcell还是从头开始 加一个如果=0，就是第一个 那么头部高度为410
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 410;
    } else {
        return 0;
    }
}
- (void)pressCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 410)];

        UIScrollView *smallScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 280, 375, 130)];
        smallScrollerView.contentSize = CGSizeMake(630, 130);


        UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 375, 50)];
        cityLabel.font = [UIFont systemFontOfSize:45];
        cityLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 375, 20)];
        weatherLabel.font = [UIFont systemFontOfSize:17];
        weatherLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, 375, 80)];
        tempLabel.font = [UIFont systemFontOfSize:60];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 230, 130, 30)];
        todayLabel.font = [UIFont systemFontOfSize:15];
        
        UILabel *maxlabel = [[UILabel alloc] initWithFrame:CGRectMake(255, 230, 50, 25)];
        maxlabel.font = [UIFont systemFontOfSize:20];
        maxlabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(315, 230, 50, 25)];
        minLabel.font = [UIFont systemFontOfSize:20];
        minLabel.textAlignment = NSTextAlignmentCenter;
        
        [headView addSubview:todayLabel];
        [headView addSubview:maxlabel];
        [headView addSubview:minLabel];
        [headView addSubview:cityLabel];
        [headView addSubview:weatherLabel];
        [headView addSubview:tempLabel];
        [headView addSubview:smallScrollerView];

     NSInteger j;

       if ([_headViewArray count] != 0) {
           for (j = 0; j < [_array count]; j++) {
               if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {
                   break;
               }
           }
           cityLabel.text = _headViewArray[j][5];
           weatherLabel.text = _headViewArray[j][0];
           tempLabel.text = _headViewArray[j][1];
           todayLabel.text = _headViewArray[j][2];
           maxlabel.text = _headViewArray[j][3];
           minLabel.text = _headViewArray[j][4];
           [self.delegate nowcontent: _headViewArray[j][1]];
       }
       

        
        //第一部分 今天的天气 啥的 完成
        //第二部分 本天天气预报
        //由于默认给的是从9点开始的 按道理第一个应该是现在的时刻 所以先添加现在的时刻
        UILabel *tempLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 62.5, 20)];
        
        tempLabel1.textAlignment = NSTextAlignmentCenter;
        
        UIImageView *imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 35, 30, 40)];
        
        UILabel *todayLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 62.5, 20)];
        
        todayLabel1.textAlignment = NSTextAlignmentCenter;
        
        todayLabel1.text = @"现在";
        
        [smallScrollerView addSubview:tempLabel1];
        [smallScrollerView addSubview:imageView0];
        [smallScrollerView addSubview:todayLabel1];
        
        //这个if按道理不用加 但为了通过编译
        if ([_headViewArray count] != 0) {
            for (j = 0; j < [_array count]; j++) {
                if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {
                    break;
                }
            }
            imageView0.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _hourlyArray[j][0][@"wea_img"]]];
            tempLabel1.text = _headViewArray[j][1];
        }

//下面是通过 宽度*i 来实现所在scollerview中的位置 然后通过一开始的赋值 在其中获取
        //通过j来判断是哪一个视图
        for (int i = 1; i < 10; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(62.5 * i, 10, 62.5, 20)];
            label.textAlignment = NSTextAlignmentCenter;
            UIImageView *imageViewHour = [[UIImageView alloc] initWithFrame:CGRectMake(62.5 * i + 15, 35, 30, 40)];
           UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(62.5 * i, 80, 62.5, 20)];
            tempLabel.textAlignment = NSTextAlignmentCenter;
            if ([_headViewArray count] != 0) {
                for (j = 0; j < [_array count]; j++) {
                    if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {
                        break;
                    }
                }
                tempLabel.text = _hourlyArray[j][i - 1][@"tem"];
                 imageViewHour.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _hourlyArray[j][i - 1][@"wea_img"]]];
                label.text = _hourlyArray[j][i - 1][@"hours"];
            }
            [smallScrollerView addSubview:label];
            [smallScrollerView addSubview:imageViewHour];
            [smallScrollerView addSubview:tempLabel];
        }

        headView.backgroundColor = [UIColor clearColor];
        return headView;
    } else {
        return nil;
    }
    
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (void)creatPost: (NSString*)str tableView:(UITableView *)tableView {
    NSString *str0 = [NSString stringWithFormat:@"https://yiketianqi.com/api?version=v9&appid=21253683&appsecret=0LXrEm6Y&city=%@", str];
    str0 = [str0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:str0];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
   
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *tempArray1 = [NSMutableArray arrayWithObjects:dic[@"data"][0][@"wea"],dic[@"data"][0][@"tem"],dic[@"data"][0][@"day"],dic[@"data"][0][@"tem1"],dic[@"data"][0][@"tem2"],str, nil];
            
        
                    [self->_headViewArray addObject:tempArray1];
//                  按道理总共有23个hours数组
                    [self.hourlyArray addObject:dic[@"data"][0][@"hours"]];
        
        NSMutableArray *tempArray2 = [NSMutableArray arrayWithObjects:dic[@"data"][1][@"week"],dic[@"data"][1][@"tem1"],dic[@"data"][1][@"tem2"],dic[@"data"][2][@"week"],dic[@"data"][1][@"tem1"],dic[@"data"][3][@"tem2"],dic[@"data"][3][@"week"],dic[@"data"][3][@"tem1"],dic[@"data"][3][@"tem2"],dic[@"data"][4][@"week"],dic[@"data"][4][@"tem1"],dic[@"data"][4][@"tem2"],dic[@"data"][5][@"week"],dic[@"data"][5][@"tem1"],dic[@"data"][5][@"tem2"],dic[@"data"][6][@"week"],dic[@"data"][6][@"tem1"],dic[@"data"][6][@"tem2"],nil];
        
        [self.forecastArray addObject:tempArray2];
//        NSLog(@"%@",self->_forecastArray[0][1]);
        
         NSMutableArray *tempArray3 = [NSMutableArray arrayWithObjects:dic[@"data"][0][@"sunrise"],dic[@"data"][0][@"sunset"],dic[@"data"][0][@"air"],dic[@"data"][0][@"humidity"],dic[@"data"][0][@"win_speed"],dic[@"data"][0][@"win_meter"],dic[@"data"][0][@"tem"],dic[@"data"][0][@"pressure"],dic[@"data"][0][@"visibility"],dic[@"data"][0][@"wea_day"],nil];
         
        [self.contentArray addObject:tempArray3];
        
          NSMutableArray *tempArray4 = [NSMutableArray arrayWithObjects:dic[@"data"][1][@"wea_day_img"],dic[@"data"][2][@"wea_day_img"],dic[@"data"][3][@"wea_day_img"],dic[@"data"][4][@"wea_day_img"],dic[@"data"][5][@"wea_day_img"],dic[@"data"][6][@"wea_day_img"],nil];
        [self.weekimageArray addObject:tempArray4];
//        NSLog(@"%@",self->_ViewArray[0][1]);
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [tableView reloadData];
                }];

    }];
    [dataTask resume];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section == 0) {
            return 40;
        } else {
            return 70;
        }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       if (section == 0) {
             return 6;
         } else {
             if (section == 1) {
                 return 1;
             } else {
                 return 5;
             }
         }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
       if (cell == nil) {
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
       }
//       return cell;
    if (_headViewArray.count != 0) {
        NSInteger j;
        for (j = 0; j < [_array count]; j++) {

            if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {

                break;
            }
        }
        if (indexPath.section == 0) {
            ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forecastCell" forIndexPath:indexPath];
            cell.dataLabel.text = _forecastArray[0][indexPath.row * 3];
            cell.maxLabel.text = _forecastArray[0][indexPath.row * 3 + 1];
            cell.minLabel.text = _forecastArray[0][indexPath.row * 3 + 2];
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _weekimageArray[0][indexPath.row]]];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        } else {
            if (indexPath.section == 2) {
                TodaySingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todaySingelCell" forIndexPath:indexPath];
                
                cell.titleLabel.text = _dayArray[indexPath.row * 2];
                cell.titleproLabel.text = _dayArray[indexPath.row * 2 + 1];
                if ([_headViewArray count] != 0) {
                           for (j = 0; j < [_array count]; j++) {
                               if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {
                                   break;
                               }
                           }
                }
                cell.contentLabel.text = _contentArray[j][indexPath.row * 2];
                cell.contentproLabel.text = _contentArray[j][indexPath.row * 2 + 1];
                cell.backgroundColor = [UIColor clearColor];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lifeStyleCell"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lifeStyleCell"];
                }
                cell.textLabel.text = [NSString stringWithFormat:@"今天：今日天气为：%@。当前气温%@，预计最高气温%@。", _headViewArray[j][0], _headViewArray[j][1], _headViewArray[j][4]];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.font = [UIFont systemFontOfSize:13];
                return cell;
            }
        }
        return cell;
    }
    return cell;
}
@end
