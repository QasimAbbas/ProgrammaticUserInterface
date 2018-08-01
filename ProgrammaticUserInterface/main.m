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
    //self.firstField.backgroundColor = [UIColor lightGrayColor];
    [self.firstField setTextColor:[UIColor grayColor]];
    [self.firstField setTextAlignment:NSTextAlignmentCenter];
    [self txtBorders:self.firstField];
    [self.firstField setPlaceholder:@"N1"];
    
    
    self.secondField = [[UITextField alloc] initWithFrame:CGRectMake(self.firstField.frame.size.width + 10, 0, self.frame.size.width * 0.15, self.frame.size.height * 0.5)];
    //self.secondField.backgroundColor = [UIColor lightGrayColor];
    [self.secondField setTextColor:[UIColor grayColor]];
    [self.secondField setTextAlignment:NSTextAlignmentCenter];
    [self txtBorders:self.secondField];
    [self.secondField setPlaceholder:@"N2"];
    
    self.submit = [[UIButton alloc]  initWithFrame: CGRectMake(self.firstField.frame.size.width * 2  + 20, 0, self.frame.size.width * 0.15, self.frame.size.height * 0.5)];
    
    self.submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.submit setFrame:CGRectMake(self.firstField.frame.size.width * 2  + 20, 0, self.frame.size.width * 0.15, self.frame.size.height * 0.5)];
    [self.submit addTarget:self action:@selector(btnSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.submit setTitle:@"GO" forState:UIControlStateNormal];
    [self.submit.titleLabel setTextColor:[UIColor blueColor]];
    //[self.submit setBackgroundColor:[UIColor blueColor]];
    

    
    //self.submit.backgroundColor = [UIColor lightGrayColor];
    
    self.result = [[UILabel alloc] initWithFrame:CGRectMake(self.firstField.frame.size.width * 3 + 30, 0, self.frame.size.width * 0.15, self.frame.size.height * 0.5)];
    //self.result.backgroundColor = [UIColor lightGrayColor];
    [self.result setTextColor:[UIColor grayColor]];
    [self.result setTextAlignment:NSTextAlignmentCenter];
    [self.result setText:@"ANS"];
    //
    
    [self addSubview:self.firstField];
    [self addSubview:self.secondField];
    [self addSubview:self.submit];
    [self addSubview:self.result];
}

-(void)txtBorders:(UITextField *)field{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, field.frame.size.height - 1, field.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [field.layer addSublayer:bottomBorder];
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
@interface ViewController: UIViewController <UIGestureRecognizerDelegate>
@property(nonatomic, strong)Square *square;
@property(nonatomic, strong)Calculator *calculator;
@property(nonatomic, strong)UILabel *titleText;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UIButton *infoButton;
@property(nonatomic, strong)UISegmentedControl *segmentControl;
@property CGFloat imageViewHeight;
@property CGFloat imageViewWidth;


@property(nonatomic, strong)UISwipeGestureRecognizer *swipeGestureRecognizerUp;
@property(nonatomic, strong)UISwipeGestureRecognizer *swipeGestureRecognizerDown;
@property(nonatomic, strong)UISwipeGestureRecognizer *swipeGestureRecognizerLeft;
@property(nonatomic, strong)UISwipeGestureRecognizer *swipeGestureRecognizerRight;

@property(nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;

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
    [self createImageView];
    [self createInfoButton];
    [self createSegmentedControl];
}


#pragma mark Create Objects


-(void)createInfoButton{

    self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [self.infoButton setFrame:CGRectMake(self.view.bounds.size.width - 50, 20,50, 50)];
    [self.infoButton addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.infoButton];
    
}
-(void)info:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Information" message:@"Many Gestures" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
    
}



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

#pragma mark Create SegmentedContoller

-(void)createSegmentedControl{
    self.segmentControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(10 , self.titleText.bounds.origin.y + self.titleText.bounds.size.height + 20, 200, 25)];
    
    [self.segmentControl insertSegmentWithTitle:@"Pan" atIndex:0 animated:true];
    [self.segmentControl insertSegmentWithTitle:@"Swipe" atIndex:1 animated:true];
    
    [self.segmentControl setSelectedSegmentIndex:0];
    
    [self.segmentControl addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.segmentControl];
}

-(void)selectedSegment:(UISegmentedControl *)selected{
    NSLog(@"%ld", [selected selectedSegmentIndex]);
    
    switch ([selected selectedSegmentIndex]) {
        case 0:
            [self panButton];
            break;
            
        case 1:
            [self swipeButton];
            break;
        default:
            break;
    }
}

-(void)panButton{
    [self removeSwipeGestureRecognizerFromImageView];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [self.imageView addGestureRecognizer:self.panGestureRecognizer];
}

-(void)swipeButton{
    
    [self.imageView removeGestureRecognizer:self.panGestureRecognizer];
    
    self.swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureDetected:)];
    self.swipeGestureRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    self.swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureDetected:)];
    self.swipeGestureRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    self.swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureDetected:)];
    self.swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureDetected:)];
    self.swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addSwipeGestureRecognizerToImageView];
}

-(void)addSwipeGestureRecognizerToImageView{
    [self.imageView addGestureRecognizer:self.swipeGestureRecognizerUp];
    [self.imageView addGestureRecognizer:self.swipeGestureRecognizerDown];
    [self.imageView addGestureRecognizer:self.swipeGestureRecognizerLeft];
    [self.imageView addGestureRecognizer:self.swipeGestureRecognizerRight];
}

-(void)removeSwipeGestureRecognizerFromImageView{
    [self.imageView removeGestureRecognizer:self.swipeGestureRecognizerUp];
    [self.imageView removeGestureRecognizer:self.swipeGestureRecognizerDown];
    [self.imageView removeGestureRecognizer:self.swipeGestureRecognizerLeft];
    [self.imageView removeGestureRecognizer:self.swipeGestureRecognizerRight];
}

#pragma mark Create and Gesture Image
-(void)createImageView{
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, self.view.bounds.size.height/2 - 50, 100, 100)];
    [self.imageView setBackgroundColor:UIColor.clearColor];
    self.imageView.image = [UIImage imageNamed:@"Apple"];
    self.imageView.image = [self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.tintColor = UIColor.blackColor;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageViewHeight = self.imageView.bounds.size.height;
    self.imageViewWidth = self.imageView.bounds.size.width;
    
    [self.imageView setUserInteractionEnabled:true];
    
    
    // create and configure the pinch gesture
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureDetected:)];
    [self.imageView addGestureRecognizer:pinchGestureRecognizer];
    
    // create and configure the rotation gesture
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureDetected:)];
    [self.imageView addGestureRecognizer:rotationGestureRecognizer];
    
    // creat and configure the pan gesture
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [self.imageView addGestureRecognizer:self.panGestureRecognizer];
    
    
    //create and configure the tap gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDetected:)];
    [self.imageView addGestureRecognizer:tapGestureRecognizer];
    
    //create and configure the swipe gesture
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureDetected:)];
    [self.imageView addGestureRecognizer:longPressGestureRecognizer];
    
    [self.view addSubview:self.imageView];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)longPressGestureDetected:(UILongPressGestureRecognizer *)recognizer{
     UIGestureRecognizerState state = [recognizer state];
    
    if(state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"BOP" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
    
}

- (void)pinchGestureDetected:(UIPinchGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"Image View Scale");
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
        [recognizer setScale:1.0];
    }
    
    self.imageViewHeight = self.imageView.bounds.size.height;
    self.imageViewWidth = self.imageView.bounds.size.width;
}

- (void)rotationGestureDetected:(UIRotationGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        
        NSLog(@"Image View Rotation");
        CGFloat rotation = [recognizer rotation];
        [recognizer.view setTransform:CGAffineTransformRotate(recognizer.view.transform, rotation)];
        [recognizer setRotation:0];
    }
}

- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"Image View Pan");
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}

-(void)tapGestureDetected:(UITapGestureRecognizer *)recognizer{
    
    UIGestureRecognizerState state = [recognizer state];
    
    if(state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateChanged){
        
        if(self.imageView.tintColor == UIColor.blackColor){
            self.imageView.tintColor = [UIColor greenColor];
            NSLog(@"Image View Tap");
        }else{
            self.imageView.tintColor = UIColor.blackColor;
        }
    }
}

-(void)swipeGestureDetected:(UISwipeGestureRecognizer *)recognizer{
    UIGestureRecognizerState state = [recognizer state];
    
    if(state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateChanged){
        NSLog(@"Image View Swiped");
        NSLog(@"%lu", (unsigned long)recognizer.direction);
        switch (recognizer.direction) {
            case UISwipeGestureRecognizerDirectionUp:
                
                [self.imageView setTransform:CGAffineTransformTranslate(self.imageView.transform, self.imageView.bounds.origin.x, self.imageView.bounds.origin.y - 10)];
                
                break;
            case UISwipeGestureRecognizerDirectionDown:
                
                [self.imageView setTransform:CGAffineTransformTranslate(self.imageView.transform, self.imageView.bounds.origin.x, self.imageView.bounds.origin.y + 10)];
                
                break;
            case UISwipeGestureRecognizerDirectionLeft:
                
                [self.imageView setTransform:CGAffineTransformTranslate(self.imageView.transform, self.imageView.bounds.origin.x - 10, self.imageView.bounds.origin.y)];
                
                break;
            case UISwipeGestureRecognizerDirectionRight:
                
                [self.imageView setTransform:CGAffineTransformTranslate(self.imageView.transform, self.imageView.bounds.origin.x + 10, self.imageView.bounds.origin.y)];
                
                break;
                
            default:
                break;
        }
    }
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
    
    NSLog(@"%f, %f ", self.imageView.frame.size.width, self.imageView.frame.size.height);
    CGRect r = [self.imageView frame];
    r.origin.y = self.imageView.bounds.origin.x;
    r.origin.x = self.imageView.bounds.origin.y;
    [self.imageView setFrame:r];
    
    self.square.frame = CGRectMake(size.width - 75, size.height - 75, 50, 50);
    [self.infoButton setFrame:CGRectMake(size.width - 50, 20,50, 50)];
    self.calculator.frame = CGRectMake(10, size.height - 75, 300 , 44);
    
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
