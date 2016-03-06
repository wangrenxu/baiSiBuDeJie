//
//  WRXSeeBigPictureViewController.m
//  项目配置01
//
//  Created by wang on 16/2/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXSeeBigPictureViewController.h"
#import "WRXWordTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "WRXProgressView.h"
@interface WRXSeeBigPictureViewController ()

@property (weak, nonatomic) IBOutlet WRXProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation WRXSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
     self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.progress = self.topic.progress;//使大图片的进度和小图片的进度保持一致
    self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.topic.progress * 100];//使大图片的进度和小图片的进度保持一致
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize/expectedSize;
        self.progressView.progress = progress;
        self.progressView.roundedCorners = 5;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
       
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    //根据图片的大小，设置图片的frame
    if (_topic.width && _topic.height) {
        
        CGFloat imageViewH = self.topic.height * WRXScreenW/self.topic.width;
        if (imageViewH > WRXScreenH) {//大图片
            
            imageView.frame = CGRectMake(0, 0, WRXScreenW, imageViewH);
            self.scrollView.contentSize = CGSizeMake(0, imageViewH);
        }else{
            imageView.frame = CGRectMake(0, (WRXScreenH - imageViewH)/2, WRXScreenW, imageViewH);
        }

    }
    
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);//保存图片到相册
}

#pragma mark - 保存图片到相册，不管成功与否，都会调用此方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
