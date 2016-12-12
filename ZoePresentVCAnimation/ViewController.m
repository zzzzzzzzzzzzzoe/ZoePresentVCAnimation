//
//  ViewController.m
//  ZoePresentVCAnimation
//
//  Created by mac on 2016/12/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"
#import "ZoeTransition.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) UIImageView * selectedImage;
@property (nonatomic,strong) ZoeTransition * transition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transition = [[ZoeTransition alloc]init];
    __weak typeof(self) weakSelf = self;
    self.transition.dissmissBlock = ^(){
        weakSelf.selectedImage.hidden = NO;
        
    };
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"dog.jpg"].CGImage);
    cell.contentView.contentMode = UIViewContentModeScaleAspectFill;
    cell.contentView.layer.masksToBounds = YES;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    _selectedImage = (UIImageView *)cell.contentView; //拿到view方便求位置大小
    ImageViewController * VC = [[ImageViewController alloc]init];
    VC.transitioningDelegate = self;
    VC.BgImage = [UIImage imageNamed:@"dog.jpg"];
    [self presentViewController:VC animated:YES completion:nil];

}


#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.transition.originFrame = [self.selectedImage.superview convertRect:self.selectedImage.frame toView:nil];//求出位置大小
    self.transition.presenting = YES; //present YES   dismiss NO
    self.selectedImage.hidden = YES;
    self.transition.duration = @0.5;
    return self.transition;
    
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    self.transition.presenting = NO;
    return self.transition;
}
@end
