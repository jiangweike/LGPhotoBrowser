//
//  ViewController.m
//  LGPhotoBrowser
//
//  Created by ligang on 15/10/27.
//  Copyright (c) 2015年 L&G. All rights reserved.
//

#import "ViewController.h"
#import "LGPhotoPickerViewController.h"
#import "LGPhotoPickerBrowserViewController.h"
#import "LGPhotoPickerBrowserPhoto.h"

#define HEADER_HEIGHT 100

@interface ViewController ()<LGPhotoPickerViewControllerDelegate,LGPhotoPickerBrowserViewControllerDataSource,LGPhotoPickerBrowserViewControllerDelegate, UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *myTableView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserPhotoArray;
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserURLArray;
@property (nonatomic, assign) LGShowImageType showType;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.titleArray = [[NSArray alloc] init];
    self.titleArray = @[@"照片选择器",@"照片浏览器",@"网络图片浏览器"];
    
    
    self.LGPhotoPickerBrowserPhotoArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
        photo.photoImage = [UIImage imageNamed:[NSString stringWithFormat:@"broswerPic%d.jpg",i]];
        [self.LGPhotoPickerBrowserPhotoArray addObject:photo];
    }
    
    self.LGPhotoPickerBrowserURLArray = [[NSMutableArray alloc] init];
    
    LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
    photo.photoURL = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/060828381f30e9242ab42f274f086e061d95f790.jpg"];
    [self.LGPhotoPickerBrowserURLArray addObject:photo];
    
    LGPhotoPickerBrowserPhoto *photo1 = [[LGPhotoPickerBrowserPhoto alloc] init];
    photo1.photoURL = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/267f9e2f0708283890f56e02bb99a9014c08f128.jpg"];
    [self.LGPhotoPickerBrowserURLArray addObject:photo1];
    
    LGPhotoPickerBrowserPhoto *photo2 = [[LGPhotoPickerBrowserPhoto alloc] init];
    photo2.photoURL = [NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/pic/item/b219ebc4b74543a9fa0c4bc11c178a82b90114a3.jpg"];
    [self.LGPhotoPickerBrowserURLArray addObject:photo2];
    
    LGPhotoPickerBrowserPhoto *photo3 = [[LGPhotoPickerBrowserPhoto alloc] init];
    photo3.photoURL = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/024f78f0f736afc33b1dbe65b119ebc4b7451298.jpg"];
    [self.LGPhotoPickerBrowserURLArray addObject:photo3];
    
    LGPhotoPickerBrowserPhoto *photo4 = [[LGPhotoPickerBrowserPhoto alloc] init];
    photo4.photoURL = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/77094b36acaf2edd481ef6e78f1001e9380193d5.jpg"];
    [self.LGPhotoPickerBrowserURLArray addObject:photo4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style {
    // 创建控制器
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // 最多能选9张图片
    pickerVc.maxCount = 9;
    pickerVc.delegate = self;
    self.showType = style;
    [pickerVc showPickerVc:self];
}

- (void)pushPhotoBroswerWithStyle:(LGShowImageType)style{
    LGPhotoPickerBrowserViewController *BroswerVC = [[LGPhotoPickerBrowserViewController alloc] init];
    BroswerVC.delegate = self;
    BroswerVC.dataSource = self;
    BroswerVC.showType = style;
    self.showType = style;
    [self presentViewController:BroswerVC animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT)];
    textView.text = @"欢迎使用本框架\n如果在使用过程中遇到问题请联系作者\nQQ:544043963\nE-mail:544043963@qq.com\n博客:http://blog.csdn.net/gang544043963";
    [textView setBackgroundColor:[UIColor redColor]];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:14];
    return textView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEADER_HEIGHT;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            [self presentPhotoPickerViewControllerWithStyle:LGShowImageTypeImagePicker];
            break;
        case 1:
            [self pushPhotoBroswerWithStyle:LGShowImageTypeImageBroswer];
            break;
        case 2:
            [self pushPhotoBroswerWithStyle:LGShowImageTypeImageURL];
            break;
            
        default:
            break;
    }
}

#pragma mark - LGPhotoPickerViewControllerDelegate
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original{
    NSInteger num = (long)assets.count;
    NSString *isOriginal = original? @"YES":@"NO";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送图片" message:[NSString stringWithFormat:@"您选择了%ld张图片\n是否原图：%@",(long)num,isOriginal] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - LGPhotoPickerBrowserViewControllerDataSource
- (NSInteger)photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{if (self.showType == LGShowImageTypeImageBroswer) {
        return self.LGPhotoPickerBrowserPhotoArray.count;
    } else if (self.showType == LGShowImageTypeImageURL) {
        return self.LGPhotoPickerBrowserURLArray.count;
    } else {
        NSLog(@"非法数据源");
        return 0;
    }
}

- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    if (self.showType == LGShowImageTypeImageBroswer) {
        return [self.LGPhotoPickerBrowserPhotoArray objectAtIndex:indexPath.item];
    } else if (self.showType == LGShowImageTypeImageURL) {
        return [self.LGPhotoPickerBrowserURLArray objectAtIndex:indexPath.item];
    } else {
        NSLog(@"非法数据源");
        return nil;
    }
}
@end
