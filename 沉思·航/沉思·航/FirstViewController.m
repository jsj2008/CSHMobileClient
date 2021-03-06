//
//  FirstViewController.m
//  沉思·航
//
//  Created by Sean Chain on 3/9/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "FirstViewController.h"
#import "NJWeibo.h"
#import "JHWeiboCell.h"
#import "JHWeiboFrame.h"
#import "HTMLParser.h"
#import "CBStoreHouseRefreshControl.h"
#import "ZuSimpelColor.h"
#import "AFHTTPRequestOperation.h"

@interface FirstViewController ()

@property (strong , nonatomic) NSArray *statusFrames;

@end

@implementation FirstViewController

NSIndexPath *idxpth;
NSMutableArray *posts;
NSMutableArray *titles;
NSMutableArray *comments;
NSMutableArray *ids;


- (void)viewDidLoad {
    [super viewDidLoad];
        self.storeHouseRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.tableView target:self refreshAction:@selector(refreshTriggered:) plist:@"csh" color:maroon lineWidth:1.5 dropHeight:80 scale:1 horizontalRandomness:150 reverseLoadingAnimation:YES internalAnimationFactor:0.5];
}

- (void)getUserPortraitAsync
{
    NSLog(@"trying to download the image");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *user = [ud valueForKey:@"user"];
    NSString *url = [NSString stringWithFormat:@"http://www.chensihang.com/CSHiOS/portraits/%@.jpg", user];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        NSData *portraitData = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
        [ud setValue:portraitData forKey:@"portrait"];
        NSLog(@"portrait load");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self getUserPortraitAsync];
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    self.title = @"沉思·航";
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [NSKeyedUnarchiver unarchiveObjectWithData:[ud valueForKey:@"scheme"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.tableView.backgroundColor = white;

}

#pragma mark - 数据源
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHWeiboCell *cell = [JHWeiboCell cellWithTableView:tableView];
    
    // 3.设置数据
    cell.weiboFrame = self.statusFrames[indexPath.row];
    
    // 4.返回
    return cell;
    
}

- (NSMutableArray*)getContent{
    NSMutableArray *models = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString:@"http://chensihang.com/blog/?json=1"];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [json objectForKey:@"posts"];
    posts = [[NSMutableArray alloc] init];
    titles = [[NSMutableArray alloc] init];
    comments = [[NSMutableArray alloc] init];
    ids = [[NSMutableArray alloc] init];
    NSMutableArray *thumbnails = [[NSMutableArray alloc] init];
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSDictionary *contentdata in arr) {
        NSString *temptitle = [contentdata objectForKey:@"title"];
        [titles addObject:temptitle];
        NSString *temparr = [contentdata objectForKey:@"content"];
        [posts addObject:temparr];
        NSArray *tempcomment = [contentdata objectForKey:@"comments"];
        [comments addObject:tempcomment];
        NSString *tempthumbnail = [contentdata objectForKey:@"thumbnail"];
        NSString *tempdate = [contentdata objectForKey:@"modified"];
        NSString *postid = [contentdata objectForKey:@"id"];
        [ids addObject:postid];
        [dates addObject:tempdate];
        if (tempthumbnail == nil) {
            [thumbnails addObject:@""];
        }
        else
            [thumbnails addObject:tempthumbnail];
    }
    NSMutableArray *dictarrs = [[NSMutableArray alloc] init];
    int count = 0;
    for (NSString *str in posts){
        HTMLParser *parser = [[HTMLParser alloc] initWithString:str error:nil];
        HTMLNode *node = [parser body];
        NSArray *paras = [node findChildTags:@"p"];
        NSString *text = [[paras objectAtIndex:0] allContents];
        NSMutableDictionary *tempdic = [[NSMutableDictionary alloc] init];
        tempdic[@"name"] = @"Chen Sihang";
        tempdic[@"icon"] = @"http://www.chensihang.com/CSHiOS/portraits/cs.jpg";
        tempdic[@"text"] = text;
        tempdic[@"time"] = dates[count];
        tempdic[@"picture"] = thumbnails[count];
        tempdic[@"title"] = titles[count];
        count ++;
        [dictarrs addObject:tempdic];
    }
    
    for (NSDictionary *dict in dictarrs) {
        // 创建模型
        NJWeibo *weibo = [NJWeibo weiboWithDict:dict];
        // 根据模型数据创建frame模型
        JHWeiboFrame *wbF = [[JHWeiboFrame alloc] init];
        wbF.weibo = weibo;
        [models addObject:wbF];
    }
    return models;
}

#pragma mark - 懒加载
- (NSArray *)statusFrames
{
    if (_statusFrames == nil) {
        self.statusFrames = [[self getContent] copy];
    }
    return _statusFrames;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    idxpth = indexPath;
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:idxpth];
    if (cell.tag == 0) {
        cell.selected = NO;
    }else{
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    }
    [self performSegueWithIdentifier:@"newscontent" sender:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *postid = ids[idxpth.row];
    NSArray *commentstr = comments[idxpth.row];
    NSString *str = [NSString stringWithFormat:@"<h2>%@</h2>%@", titles[idxpth.row], posts[idxpth.row]];
    NSDictionary *dic = @{@"comments":commentstr, @"content":str, @"id":postid};
    id destController = segue.destinationViewController;
    [destController setValue:dic forKey:@"dic"];
}


#pragma mark - 代理方法
// 这个方法比cellForRowAtIndexPath先调用，即创建cell的时候得先知道它的高度，所以高度必须先计算
// 所以在懒加载的时候获取微博的数据立即去计算行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出相应行的frame模型
    JHWeiboFrame *wbf = self.statusFrames[indexPath.row];
    return wbf.cellHeight;
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Notifying refresh control of scrolling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.storeHouseRefreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.storeHouseRefreshControl scrollViewDidEndDragging];
}

#pragma mark - Listening for the user to trigger a refresh

- (void)refreshTriggered:(id)sender
{
    [self performSelector:@selector(finishRefreshControl) withObject:nil afterDelay:3 inModes:@[NSRunLoopCommonModes]];
}

- (void)finishRefreshControl
{
    [self.storeHouseRefreshControl finishingLoading];
    self.statusFrames = [[self getContent] copy];
    [self.tableView reloadData];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
