//
//  HighScoreTableViewCell.h
//  Colour Memory
//
//  Created by Dipen Sekhsaria on 27/02/17.
//  Copyright © 2017 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
