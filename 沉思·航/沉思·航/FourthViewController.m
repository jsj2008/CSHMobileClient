

#import "FourthViewController.h"
#import "AppDelegate.h"
#import "ZuSimpelColor.h"
#import "LoginController.h"
#import "Func.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

NSDictionary *dic;

UIToolbar *toolbar;
UITableView *table;

NSIndexPath *idxpth;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", [ud valueForKey:@"user"]);
    // Do any additional setup after loading the view, typically from a nib.
    float x = self.view.frame.size.width;
    float y = self.view.frame.size.height;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [NSKeyedUnarchiver unarchiveObjectWithData:[ud valueForKey:@"scheme"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.view addSubview:toolbar];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, y * 0.096, x, y * 0.904) style:UITableViewStylePlain];
    table.tableFooterView = [UIView new]; //去掉多余的行显示
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    else {
        return 55;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *firstcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    firstcell.textLabel.text = @"个人信息";
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    firstcell.imageView.image = [NSKeyedUnarchiver unarchiveObjectWithData:[ud valueForKey:@"portrait"]];
    firstcell.imageView.tag = indexPath.row;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.cancelsTouchesInView = YES;
    tap.delegate = self;
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [firstcell.imageView addGestureRecognizer:tap];
    firstcell.imageView.userInteractionEnabled = YES;
    UITableViewCell *secondcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    secondcell.textLabel.text = @"用户偏好设置";
    UITableViewCell *thirdcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    thirdcell.textLabel.text = @"关于";
    UITableViewCell *fourthcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    fourthcell.textLabel.text = @"退出当前账户";
    switch (indexPath.row) {
        case 0:
            return firstcell;
        case 1:
            return secondcell;
        case 2:
            return thirdcell;
        case 3:
            return fourthcell;
    }
    return nil;
}

- (void)handleTap:(UITapGestureRecognizer *)recongnizer
{
    [Func showAlert:@"You have tapped on the portrait!!!"];
}

// 该方法的返回值决定指定分区内包含多少个表格行。
- (NSInteger)tableView:(UITableView*)tableView
	numberOfRowsInSection:(NSInteger)section
{
    // 由于该表格只有一个分区，直接返回books中集合元素个数代表表格的行数
    return 4;
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
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"info" sender:self.view];
    }
    else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"theme" sender:self.view];
    }
    else if (indexPath.row == 2)
        [self performSegueWithIdentifier:@"about" sender:self.view];
    else {
        [self performSegueWithIdentifier:@"backlogin" sender:self.view];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"user"];
        [ud removeObjectForKey:@"portrait"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destController = segue.destinationViewController;
    BOOL isLogin = [destController isKindOfClass:LoginController.class];
    if (!isLogin) {
        [destController setValue:idxpth forKey:@"indexpath"];
    }
}

@end
