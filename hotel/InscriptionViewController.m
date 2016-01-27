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
@property (weak, nonatomic) IBOutlet UIImageView *imageProfileView;

@property (weak, nonatomic) IBOutlet UIButton *choosePhotoButton;


@property (nonatomic, strong) UIImage *image;

@end

@implementation InscriptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.image = image;
    self.imageProfileView.image = image;
}

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
