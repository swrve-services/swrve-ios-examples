#import "ViewController.h"
#import "UserSampleIdUtils.h"
#import "swrve.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* swrveUserId = [[Swrve sharedInstance] userID];
    NSString* userSampleId = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"userSampleId"] intValue]];
    
    self.userIdLabel.text = swrveUserId;
    self.UserSampleIdLabel.text = userSampleId;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
