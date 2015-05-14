

#import "FourthViewController.h"
#import "AppDelegate.h"
#import "ZuSimpelColor.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

NSDictionary *dic;
NSArray *content;
//将来将使用解析新闻链接的方式获得标题

UIToolbar *toolbar;
UITableView *table;

NSIndexPath *idxpth;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    float x = self.view.frame.size.width;
    float y = self.view.frame.size.height;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = darkorange;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    // self.navigationController.navigati
    [self.view addSubview:toolbar];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, y * 0.096, x, y * 0.904) style:UITableViewStylePlain];
    table.tableFooterView = [UIView new]; //去掉多余的行显示
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    content = @[@"用户名", @"用户信息"];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    }
    else {
        return 40;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *firstcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    firstcell.textLabel.text = @"个人信息";
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    NSLog(@"~~%f~~", firstcell.frame.size.height);
    firstcell.imageView.image = [UIImage imageNamed:@"comments.png"];
    UITableViewCell *secondcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    secondcell.textLabel.text = @"用户偏好设置";
    UITableViewCell *thirdcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    thirdcell.textLabel.text = @"关于";
    switch (indexPath.row) {
        case 0:
            return firstcell;
        case 1:
            return secondcell;
        case 2:
            return thirdcell;
    }
    return nil;
}
// 该方法的返回值决定指定分区内包含多少个表格行。
- (NSInteger)tableView:(UITableView*)tableView
	numberOfRowsInSection:(NSInteger)section
{
    // 由于该表格只有一个分区，直接返回books中集合元素个数代表表格的行数
    return 3;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
    [self performSegueWithIdentifier:@"info" sender:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destController = segue.destinationViewController;
    [destController setValue:idxpth forKey:@"indexpath"];
}

@end
