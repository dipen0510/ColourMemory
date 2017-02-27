//
//  HighScoreViewController.h
//  Colour Memory
//
//  Created by Dipen Sekhsaria on 27/02/17.
//  Copyright © 2017 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreTableViewCell.h"

@interface HighScoreViewController : UIViewController {
    
    NSMutableArray* highScoreArr;
    
}

@property (weak, nonatomic) IBOutlet UITableView *highScoreTblView;
- (IBAction)backButtonTapped:(id)sender;

@end
