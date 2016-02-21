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

@interface InscriptionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UITextField *ageTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageProfileView;

@property (weak, nonatomic) IBOutlet UIButton *choosePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *inscriptionButton;


@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSArray *fields;

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

#pragma mark - Configuration

- (void)configureUI
{
    self.imageProfileView.layer.borderWidth = 1.0f;
    self.imageProfileView.contentMode = UIViewContentModeScaleAspectFit;
    self.choosePhotoButton.titleLabel.numberOfLines = 2;
    self.choosePhotoButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.passwordTextView.secureTextEntry = YES;
    
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
    NSString *response = notification.object;
    NSString *title = @"";
    NSString *message;
    if ([response isEqualToString:@""])
    {
        message = LOCALIZED_STRING(@"inscription.registration_success.message");
    }
    else
    {
        title = LOCALIZED_STRING(@"globals.error");
        message = response;
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
    BOOL allFielsComplete = YES;
    for (UITextField *field in self.fields)
    {
        if ([field.text isEqualToString:@""])
        {
            allFielsComplete = NO;
            [NOTIFICATION_CENTER postNotificationName:EmptyFieldsNotification object:LOCALIZED_STRING(@"homePage.error.fielsEmpty")];
            break;
        }
    }
    
    // Minimum 8 caratères
    if (self.passwordTextView.text.length < 8)
    {
        allFielsComplete = NO;
        [NOTIFICATION_CENTER postNotificationName:EmptyFieldsNotification object:LOCALIZED_STRING(@"homePage.password_short.error")];
    }
    
    if (allFielsComplete)
    {
        [NOTIFICATION_CENTER addObserver:self selector:@selector(handleInscriptionResponse:) name:InscriptionReponseNotification object:nil];
        [[NetworkManagement sharedInstance] addNewAction:[InscriptionUserAction action:self.firstNameTextView.text
                                                                              lastName:self.lastNameTextView.text
                                                                                 email:self.emailTextView.text
                                                                              password:self.passwordTextView.text
                                                                                   age:self.ageTextView.text]
                                                  method:POST_METHOD];
        NSLog(@"start inscription");
    }
}

#pragma mark - Utils

- (void)gestureRecognizer:(UISwipeGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

@end
