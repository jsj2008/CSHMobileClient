//
//  ScoreController.m
//  沉思·航
//
//  Created by Sean Chain on 5/12/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "ScoreController.h"
#import "ASFTableView.h"

@interface ScoreController ()

@property (nonatomic, retain) NSMutableArray *rowsArray;

@end

@implementation ScoreController

@synthesize json;

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    id jsonObject = json;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat barh = statusBarFrame.size.height;
    CGFloat header = self.view.frame.size.height * 0.05;
    ASFTableView *mytableview = [[ASFTableView alloc] initWithFrame:CGRectMake(0, barh + header, self.view.frame.size.width, self.view.frame.size.height - barh - header)];
    mytableview.backgroundColor = [UIColor colorWithRed:0.0f green:91.0f/255 blue:171.0f/255 alpha:1.0];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, header, header)];
    [img setImage:[UIImage imageNamed:@"back.png"]];
    [img addGestureRecognizer:singleTap];
    [img setUserInteractionEnabled:YES];
    UIView *welcomeview = [[UIView alloc] initWithFrame:CGRectMake(0, barh, self.view.frame.size.width, header)];
    NSString *username = jsonObject[[jsonObject count] - 1][2];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(header * 1.2, 0, self.view.frame.size.width, header)];
    label.text = [NSString stringWithFormat:@"欢迎你, %@", username];
    [welcomeview addSubview:img];
    [welcomeview addSubview:label];
    [self.view addSubview:welcomeview];
    [self.view addSubview:mytableview];
    NSArray *cols = @[@"课程号",@"课程名",@"学分",@"成绩"];
    NSArray *weights = @[@(0.30f),@(0.42f),@(0.13f),@(0.15f)];
    NSDictionary *options = @{kASF_OPTION_CELL_TEXT_FONT_SIZE : @(13),
                              kASF_OPTION_CELL_TEXT_COLOR:[UIColor whiteColor],
                              kASF_OPTION_CELL_TEXT_FONT_BOLD : @(true),
                              kASF_OPTION_CELL_BORDER_COLOR : [UIColor whiteColor],
                              kASF_OPTION_CELL_BORDER_SIZE : @(0.5),
                              kASF_OPTION_BACKGROUND : [UIColor colorWithRed:18/255.0 green:62/255.0 blue:120/255.0 alpha:1.0]};
    
    // [mytableview setDelegate:self];
    [mytableview setBounces:NO];
    [mytableview setSelectionColor:nil];
    // [mytableview setSelectionColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0f]];
    [mytableview setTitles:cols
               WithWeights:weights
               WithOptions:options
                 WitHeight:32 Floating:YES];
    
    [_rowsArray removeAllObjects];
    for (int i=0; i < [jsonObject count] - 1; i++) {
        [_rowsArray addObject:@{
                                kASF_ROW_ID :
                                    @(i),
                                
                                kASF_ROW_CELLS :
                                    @[@{kASF_CELL_TITLE : jsonObject[i][0], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : jsonObject[i][1],kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : jsonObject[i][2], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : [jsonObject[i][4] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)}],
                                
                                kASF_ROW_OPTIONS :
                                    @{kASF_OPTION_BACKGROUND : (i % 2 == 0 ? [UIColor whiteColor]:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]),
                                      kASF_OPTION_CELL_TEXT_FONT_SIZE: @(12),
                                      kASF_OPTION_CELL_PADDING : @(4),
                                      kASF_OPTION_CELL_BORDER_SIZE: @(0.5),
                                      kASF_OPTION_CELL_BORDER_COLOR : [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]}}];
    }
    NSUInteger num = [jsonObject count] - 1;
    NSString *avgscore = jsonObject[num][0];
    NSString *gpa = jsonObject[num][1];
    NSLog(@"%@--%@", avgscore, gpa);
    [_rowsArray addObject:@{
                            kASF_ROW_ID:@(num),
                            kASF_ROW_CELLS:@[@{kASF_CELL_TITLE: @"加权平均"}, @{kASF_CELL_TITLE : avgscore, kASF_OPTION_CELL_TEXT_ALIGNMENT:@(NSTextAlignmentCenter)}, @{}, @{}],
                            kASF_ROW_OPTIONS:
                                @{kASF_OPTION_BACKGROUND : ([UIColor whiteColor]),
                                  kASF_OPTION_CELL_TEXT_FONT_SIZE: @(12),
                                  kASF_OPTION_CELL_PADDING : @(4),
                                  kASF_OPTION_CELL_BORDER_SIZE: @(0.0),
                                  kASF_OPTION_CELL_BORDER_COLOR : [UIColor whiteColor]}
                            }]; //添加平均成绩部分
    [_rowsArray addObject:@{
                            kASF_ROW_ID:@(num + 1),
                            kASF_ROW_CELLS:@[@{kASF_CELL_TITLE:@"GPA"}, @{kASF_CELL_TITLE: gpa, kASF_OPTION_CELL_TEXT_ALIGNMENT:@(NSTextAlignmentCenter)},  @{}, @{}],
                            kASF_ROW_OPTIONS:
                                @{kASF_OPTION_BACKGROUND : ([UIColor whiteColor]),
                                  kASF_OPTION_CELL_TEXT_FONT_SIZE: @(12),
                                  kASF_OPTION_CELL_PADDING : @(4),
                                  kASF_OPTION_CELL_BORDER_SIZE: @(0.0),
                                  kASF_OPTION_CELL_BORDER_COLOR : [UIColor whiteColor]}
                            }]; //添加GPA部分
    [mytableview setRows:_rowsArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _rowsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)imageTaped:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"Hello, worlder");
    [self performSegueWithIdentifier:@"back" sender:self.view];
}

@end
