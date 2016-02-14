//
//  HotDealCell.m
//  hotel
//
//  Created by Paul Lavoine on 30/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HotDealCell.h"

@interface HotDealCell ()

// Outlet
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

// Data
@property (weak) NSTimer *repeatingTimer;
@property (nonatomic, assign) CGFloat currMinute;
@property (nonatomic, assign) CGFloat currSeconds;

@end

@implementation HotDealCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"HotDealCell" bundle:nil];
    });
    
    return cellNib;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)configureWithInformationsHotDeal:(Camping *)camping lastRequest:(NSDate *)lastRequest
{
    self.titleLabel.text = camping.title;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.priceLabel.text = [NSString stringWithFormat:@"%.f - %.f%@", [self minPriceWithCamping:camping], [self maxPriceWithCamping:camping], LOCALIZED_STRING(@"hotdeal.price_unity.label")];

//    [self startTimer:hotDeal];
}

- (void)setSeparatorVisiblity:(BOOL)isLast
{
    self.separatorView.hidden = isLast;
}

- (CGFloat)minPriceWithCamping:(Camping *)camping
{
    CGFloat minPrice = [((Offer *)[camping.offers firstObject]).price floatValue];
    for (Offer *offer in camping.offers)
    {
        if ([offer.price floatValue] <= minPrice)
        {
            minPrice = [offer.price floatValue];
        }
    }
    return minPrice;
}

- (CGFloat)maxPriceWithCamping:(Camping *)camping
{
    CGFloat maxPrice = [((Offer *)[camping.offers firstObject]).price floatValue];
    for (Offer *offer in camping.offers)
    {
        if ([offer.price floatValue] >= maxPrice)
        {
            maxPrice = [offer.price floatValue];
        }
    }
    return maxPrice;
}

 /*
  *
  * Cette partie n'est pas utilisé pour le moment. Elle servait pour les timer des hotDeals
  *
  */
- (void)startTimer:(HotDeal *)hotDeal
{
    NSLog(@"test date : %@", [hotDeal remainingTimeWithRequestDate]);
    
    self.currMinute = 3;
    self.currSeconds = 00;
    
    // Cancel a preexisting timer.
    [self.repeatingTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(targetMethod:)
                                                    userInfo:nil
                                                     repeats:YES];
    self.repeatingTimer = timer;
}

- (void)targetMethod:(NSTimer*)theTimer
{
    if((self.currMinute > 0 || self.currSeconds >= 0) && self.currMinute >=0)
    {
        if (self.currSeconds==0)
        {
            self.currMinute-=1;
            self.currSeconds=59;
        }
        else if (self.currSeconds>0)
        {
            self.currSeconds-=1;
        }
        if (self.currMinute>-1)
        {
            NSString *timeString = [NSString stringWithFormat:@"%lu%@%02lu",(unsigned long)self.currMinute,@":",(unsigned long)self.currSeconds];
            self.timerLabel.text = timeString;
        }
    }
    else
    {
        [self.repeatingTimer invalidate];
    }
}

@end
