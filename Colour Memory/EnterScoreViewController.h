//
//  EnterScoreViewController.h
//  Colour Memory
//
//  Created by Dipen Sekhsaria on 27/02/17.
//  Copyright © 2017 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterScoreViewController : UIViewController

@property (nonatomic, strong) UIViewController* parentController;
@property (nonatomic, strong) NSString* score;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end
