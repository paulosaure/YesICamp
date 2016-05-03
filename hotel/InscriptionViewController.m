//
//  InscriptionViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "InscriptionViewController.h"
#import "InscriptionUserAction.h"
#import "UITextField+Effects.h"
#import "UIButton+Effects.h"
#import "PrivacyPolicyView.h"

@interface InscriptionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UITextField *ageTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageProfileView;

@property (weak, nonatomic) IBOutlet UIButton *choosePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *inscriptionButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton;
@property (weak, nonatomic) IBOutlet UIButton *privacyPolicyButton;


@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSArray *fields;
@property (nonatomic, strong) IBOutlet PrivacyPolicyView *policyView;

@end

@implementation InscriptionViewController

#pragma mark - View lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    self.fields = @[self.firstNameTextView, self.lastNameTextView, self.emailTextView, self.passwordTextView, self.ageTextView];
    
    // Configuration
    [self configureUI];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [NOTIFICATION_CENTER removeObserver:self];
}

#pragma mark - Configuration

- (void)configureUI
{
    self.imageProfileView.layer.borderWidth = 1.0f;
    self.imageProfileView.contentMode = UIViewContentModeScaleAspectFit;
    self.choosePhotoButton.titleLabel.numberOfLines = 2;
    self.choosePhotoButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.passwordTextView.secureTextEntry = YES;
    
    NSDictionary *privacyAttributes = @{
                                        NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                        NSForegroundColorAttributeName:GREEN_COLOR
                                        };
    
    [self.privacyPolicyButton setAttributedTitle:[[NSAttributedString alloc] initWithString:LOCALIZED_STRING(@"inscription.privacy_policy.button") attributes:privacyAttributes] forState:UIControlStateNormal];
    
    
    [self.checkBoxButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.checkBoxButton.imageView setHidden:YES];
    [self.checkBoxButton setTintColor:GREEN_COLOR];
    
    // Warning : Customer didn't want photo
    self.choosePhotoButton.hidden = YES;
    self.imageProfileView.hidden = YES;
    
    
    [self.firstNameTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"inscription.firstname.placeholder")];
    [self.lastNameTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"inscription.lastname.placeholder")];
    [self.emailTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"inscription.email.placeholder")];
    [self.passwordTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"inscription.password.placeholder")];
    [self.ageTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"inscription.age.placeholder")];
    
    [self.choosePhotoButton addColorEffect:GREEN_COLOR text:LOCALIZED_STRING(@"inscription.select_picture.button")];
    [self.inscriptionButton addColorEffect:GREEN_COLOR text:LOCALIZED_STRING(@"inscription.inscription.button")];
    
    self.view.backgroundColor = BLACK_COLOR;
    self.spinner.hidden = YES;
}

#pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    self.image = image;
    self.imageProfileView.image = image;
    self.imageProfileView.layer.borderColor = GREEN_COLOR.CGColor;
}

#pragma mark - Notifications

- (void)handleInscriptionResponse:(NSNotification *)notification
{
    [self isSearching:NO];
    NSNumber *statusCode = notification.object;
    NSString *title = @"";
    NSString *message;
    
    if ([statusCode isEqualToNumber:@200])
    {
        message = LOCALIZED_STRING(@"inscription.registration_success.message");
    }
    else
    {
        title = LOCALIZED_STRING(@"globals.error");
        message = [statusCode stringValue];
    }
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:LOCALIZED_STRING(@"globals.ok")
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)choosePhoto:(id)sender
{
    UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
    pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerLibrary.delegate = self;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:pickerLibrary animated:YES completion:nil];
    }];
}

- (IBAction)startInscription:(id)sender
{
    NSString *errorMessage;
    BOOL allFielsComplete = YES;
    for (UITextField *field in self.fields)
    {
        if ([field.text isEqualToString:@""])
        {
            allFielsComplete = NO;
            errorMessage = LOCALIZED_STRING(@"homePage.error.fielsEmpty");
            break;
        }
    }
    
    // Minimum 8 caratères
    if (self.passwordTextView.text.length < 8)
    {
        allFielsComplete = NO;
        errorMessage = LOCALIZED_STRING(@"homePage.password_short.error");
    }
    else if (!self.checkBoxButton.isSelected)
    {
        allFielsComplete = NO;
        errorMessage = LOCALIZED_STRING(@"homePage.privacy_policy.error");
    }
    
    if (allFielsComplete)
    {
        [self isSearching:YES];
        [NOTIFICATION_CENTER addObserver:self selector:@selector(handleInscriptionResponse:) name:InscriptionReponseNotification object:nil];
        [[NetworkManagement sharedInstance] addNewAction:[InscriptionUserAction action:self.firstNameTextView.text
                                                                              lastName:self.lastNameTextView.text
                                                                                 email:self.emailTextView.text
                                                                              password:self.passwordTextView.text
                                                                                   age:self.ageTextView.text]
                                                  method:POST_METHOD];
    }
    else
    {
        PopUpInformation *informations = [[PopUpInformation alloc] initWithTitle:LOCALIZED_STRING(@"globals.error")
                                                                         message:errorMessage
                                                                   messageButton:LOCALIZED_STRING(@"globals.ok")];
        [NOTIFICATION_CENTER postNotificationName:popUpNotification object:informations];
    }
}

#pragma mark - Actions
- (IBAction)displayPrivacyPolicyAction:(id)sender
{
    [self animatePopUpShow];
}

- (IBAction)checkPrivacyPolicyAction:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
    [self.checkBoxButton.imageView setHidden:!sender.selected];
}


#pragma mark - Utils

- (void)animatePopUpShow
{
    self.policyView = [[[NSBundle mainBundle] loadNibNamed:@"PrivacyPolicyView" owner:self options:nil] firstObject];
    self.policyView.alpha = 0;
    self.policyView.frame = CGRectMake (160, 240, 0, 0);
    [self.view addSubview:self.policyView];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];

    self.policyView.alpha = 0.8f;
    self.policyView.frame = CGRectMake (30, 20, CGRectGetWidth(self.view.frame) - 60 , CGRectGetHeight(self.view.frame)- 150);
    
    [UIView commitAnimations];
}

- (void)isSearching:(BOOL)isSearching
{
    self.spinner.hidden = !isSearching;
    self.inscriptionButton.hidden = isSearching;
    isSearching ? [self.spinner startAnimating] : [self.spinner stopAnimating];
}

- (void)gestureRecognizer:(UISwipeGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    
    [self.policyView removeFromSuperview];
}

@end
