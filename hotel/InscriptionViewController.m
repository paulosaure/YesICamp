//
//  InscriptionViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "InscriptionViewController.h"

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

@end

@implementation InscriptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *Swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    Swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:Swipe];
    
    // Configuration
    [self configureUI];
}

- (void)configureUI
{
    self.imageProfileView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageProfileView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageProfileView.layer.borderWidth = 1.0f;
    self.choosePhotoButton.titleLabel.numberOfLines = 0;
    self.choosePhotoButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.firstNameTextView.placeholder = LOCALIZED_STRING(@"inscription.firstname.placeholder");
    self.lastNameTextView.placeholder = LOCALIZED_STRING(@"inscription.lastname.placeholder");
    self.emailTextView.placeholder = LOCALIZED_STRING(@"inscription.email.placeholder");
    self.passwordTextView.placeholder = LOCALIZED_STRING(@"inscription.password.placeholder");
    self.ageTextView.placeholder = LOCALIZED_STRING(@"inscription.age.placeholder");
    
    [self.choosePhotoButton setTitle:LOCALIZED_STRING(@"inscription.select_picture.button") forState:UIControlStateNormal];
    [self.inscriptionButton setTitle:LOCALIZED_STRING(@"inscription.inscription.button") forState:UIControlStateNormal];
    
    self.view.backgroundColor = BLACK_COLOR;
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    self.image = image;
    self.imageProfileView.image = image;
}

- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)sender
{
    [self.view endEditing:YES];
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
    
}

@end
