//
//  GameViewController.h
//  Colour Memory
//
//  Created by Dipen Sekhsaria on 26/02/17.
//  Copyright © 2017 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController {
    
    NSMutableArray* cardsArr;
    NSMutableDictionary* selectedCard;
    NSMutableDictionary* selectedSecondCard;
    int totalScore;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *cardsCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;

@end

