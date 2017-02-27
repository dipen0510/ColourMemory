//
//  EnterScoreViewController.m
//  Colour Memory
//
//  Created by Dipen Sekhsaria on 27/02/17.
//  Copyright © 2017 Dipen Sekhsaria. All rights reserved.
//

#import "EnterScoreViewController.h"

@interface EnterScoreViewController ()

@end

@implementation EnterScoreViewController

@synthesize parentController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonTapped:(id)sender {
    
    if ([self checkIfNameIsValid]) {
        [[SharedClass sharedInstance] insertNewHighScoreEntryWithName:_nameTxtField.text andScore:_score];
        [self hideEnterScoreView];
    }
    
}

- (void) hideEnterScoreView {
    
    [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [parentController dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

- (BOOL) checkIfNameIsValid {
    
    _errorLabel.hidden = NO;
    
    if ([_nameTxtField.text isEqualToString:@""]) {
        return NO;
    }
    else if (!_nameTxtField.text) {
        return NO;
    }
    
    _errorLabel.hidden = YES;
    return YES;
    
}
@end
