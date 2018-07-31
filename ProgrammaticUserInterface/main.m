//
//  main.m
//  ProgrammaticUserInterface
//
//  Created by Qasim Abbas on 7/30/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark Square
@interface Square: UIView

@end

@implementation Square

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

@end


#pragma mark Calculator
@interface Calculator: UIView <UITextFieldDelegate>
@property(nonatomic, strong)UITextField *firstField;
@property(nonatomic, strong)UITextField *secondField;
@property(nonatomic, strong)UILabel *result;
@property(nonatomic, strong)UIButton *submit;

@end

@implementation Calculator
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createObjects];
        self.firstField.delegate = self;
        self.secondField.delegate = self;
    }
    return self;
}

-(void)createObjects{
    self.firstField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.15, self.frame.size.height * 0.5)];
    self.firstField.backgroundColor = [UIColor lightGrayColor];
    [self.firstField setTextColor:[UIColor whiteColor]];
    [self.firstField setTextAlignment:NSTextAlignmentCenter];
    
    self.secondField = [[UITextField alloc] initWithFrame:CGRectMake(self.firstField.frame.size.width + 10, 0, self.frame.size.width * 0.15, self.frame.size.height * 0.5)];
    self.secondField.backgroundColor = [UIColor lightGrayColor];
    [self.secondField setTextColor:[UIColor whiteColor]];
    [self.secondField setTextAlignment:NSTextAlignmentCenter];
    
    self.submit = [[UIButton alloc]  initWithFrame: CGRectMake(self.firstField.frame.size.width * 2  + 20, 0, self.frame.size.width * 0.15, self.frame.size.height * 0.5)];
    [self.submit addTarget:self action:@selector(btnSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.submit setTitle:@"GO" forState:UIControlStateNormal];
    [self.submit setTintColor:[UIColor blackColor]];
    
    self.submit.backgroundColor = [UIColor lightGrayColor];
    
    self.result = [[UILabel alloc] initWithFrame:CGRectMake(self.firstField.frame.size.width * 3 + 30, 0, self.frame.size.width * 0.15, self.frame.size.height * 0.5)];
    self.result.backgroundColor = [UIColor lightGrayColor];
    [self.result setTextColor:[UIColor whiteColor]];
    [self.result setTextAlignment:NSTextAlignmentCenter];
    //
    
    [self addSubview:self.firstField];
    [self addSubview:self.secondField];
    [self addSubview:self.submit];
    [self addSubview:self.result];
}


-(void)btnSubmit:(UIButton *)sender{
    int firstText = [self.firstField.text intValue];
    int secondText = [self.secondField.text intValue];
    self.result.text = [NSString stringWithFormat:@"%i", firstText + secondText];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}



@end

#pragma mark ViewController
@interface ViewController: UIViewController
@property(nonatomic, strong)Square *square;
@property(nonatomic, strong)Calculator *calculator;
@property(nonatomic, strong)UILabel *titleText;
@end

@interface ViewController()

@end

@implementation ViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSquare];
    [self createTitle];
    [self createCalculator];
}


#pragma mark Create Objects
-(void)createSquare{
    self.square = [[Square alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 75, self.view.bounds.size.height - 75, 50, 50)];
    [self.view addSubview:self.square];
}

-(void)createTitle{
    self.titleText = [[UILabel alloc] initWithFrame:CGRectMake(10, 20 , self.view.bounds.size.width, 44)];
    self.titleText.text = @"Programmatic User Interface";
    self.titleText.textColor = [UIColor darkGrayColor];
    [self.view addSubview:self.titleText];
}

-(void)createCalculator{
    
    self.calculator = [[Calculator alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height - 75
                                                                   , 300 , 44)];
    NSLog(@"Calculator is being created? %@", self.calculator.description);
    [self.view addSubview:self.calculator];
    
}

#pragma mark Keyboard
- (void)viewWillAppear:(BOOL)animated{
    
    [self keyboardInNotificationCenter];
    [super viewWillAppear:animated];
}

-(void)keyboardInNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    CGRect keyboard = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    float newVerticalPosition = -keyboard.size.height;
    [self moveFrameToVerticalPosition:newVerticalPosition forDuration:0.3f];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    [self moveFrameToVerticalPosition:0.0f forDuration:0.3f];
}


- (void)moveFrameToVerticalPosition:(float)position forDuration:(float)duration {
    CGRect frame = self.view.frame;
    frame.origin.y = position;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
   
    self.square.frame = CGRectMake(size.width - 75, size.height - 75, 50, 50);
    
    self.calculator.frame = CGRectMake(10, size.height - 75
                                      , 300 , 44);
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}


@end


#pragma mark AppDelegate

@interface AppDelegate: UIResponder <UIApplicationDelegate>

@property(nonatomic, strong)UIWindow *window;

@end

@interface AppDelegate()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    ViewController *rootController = [[ViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    rootController.view.frame = self.window.frame;
    [self.window setRootViewController:rootController];
    
//    UILayoutGuide * guide = self.window.safeAreaLayoutGuide;
//    [myView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor].active = YES;
//    [myView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor].active = YES;
//    [rootController.view.topAnchor constraintEqualToAnchor:guide.topAnchor].active = YES;
//    [myView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor].active = YES;
//    rootController.view.
    [self.window makeKeyAndVisible];
    
    return true;
    
}

@end

#pragma mark Main Setup
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
        
    }
}
