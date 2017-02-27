//
//  GameViewController.m
//  Colour Memory
//
//  Created by Dipen Sekhsaria on 26/02/17.
//  Copyright © 2017 Dipen Sekhsaria. All rights reserved.
//

#import "GameViewController.h"
#import "CardCollectionViewCell.h"
#import "NSMutableArray+Shuffle.h"
#import "SelectionStatusViewController.h"
#import "EnterScoreViewController.h"

@interface GameViewController () {
    
    SelectionStatusViewController* selectionStatusView;
    EnterScoreViewController* enterScoreView;
    
}

@end

@implementation GameViewController

static NSString * const reuseIdentifier = @"CardCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupDataSourceForGame];
    [self setupScore];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.cardsCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 344, 0);
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setupSelectionStatusView];
    [self setupEnterScoreView];
    
}

#pragma mark - Initial Setup helpers

- (void) setupDataSourceForGame {
    
    [self.cardsCollectionView registerNib:[UINib nibWithNibName:@"CardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    cardsArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<16; i++) {
        
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        
        int imgFactor = (i+1)%8;
        if (imgFactor == 0) {
            imgFactor = 8;
        }
        
        [dict setObject:[NSString stringWithFormat:@"colour%d.png",imgFactor] forKey:@"image"];
        [dict setObject:[NSString stringWithFormat:@"%d",imgFactor] forKey:@"type"];
        [dict setObject:@"0" forKey:@"isSelected"];
        
        [cardsArr addObject:dict];
        
    }
    
    [cardsArr shuffle];
    
}

- (void) setupSelectionStatusView {
    
    UIStoryboard *homeSlaveStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    selectionStatusView = (SelectionStatusViewController*)[homeSlaveStoryboard instantiateViewControllerWithIdentifier:@"SelectionStatusViewController"];
    selectionStatusView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ;
    
}

- (void) setupEnterScoreView {
    
    UIStoryboard *homeSlaveStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    enterScoreView = (EnterScoreViewController*)[homeSlaveStoryboard instantiateViewControllerWithIdentifier:@"EnterScoreViewController"];
    enterScoreView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ;
    enterScoreView.parentController = self;
    
}

- (void) setupScore {
    
    _totalScoreLabel.text = [NSString stringWithFormat:@"Score  %d",totalScore];
    
}

- (void) resetAllSelectedCardsToUnselected {

    for (int i = 0; i<16; i++) {
        
        NSMutableDictionary* cardDict = [cardsArr objectAtIndex:i];
        if ([[cardDict valueForKey:@"isSelected"] intValue] == 1) {
            [cardDict setObject:@"0" forKey:@"isSelected"];
        }
        
    }
    
    selectedCard = nil;
    [_cardsCollectionView reloadData];
    
}

#pragma mark - CollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return cardsArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CardCollectionViewCell *cell = (CardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self populateContentForCell:cell atIndexPath:indexPath];
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.frame.size.width-30)/4.,(collectionView.frame.size.height-30)/4.);
    
}


#pragma mark - CollectionView Delegates

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary* cardDict = [cardsArr objectAtIndex:indexPath.row];
    
    if ([[cardDict valueForKey:@"isSelected"] intValue] != -1 && [[cardDict valueForKey:@"isSelected"] intValue] != 1) {
        
        [cardDict setObject:@"1" forKey:@"isSelected"];
        [collectionView reloadData];
        
        if (selectedCard) {
            
            if ([[selectedCard valueForKey:@"type"] isEqualToString:[cardDict valueForKey:@"type"]]) {
                
                selectedSecondCard = cardDict;
                totalScore = totalScore + 2;
                [self showSelectionStatusMaskViewWithMsg:@"Right Answer !!!"];
                
            }
            else {
                
                totalScore = totalScore - 1;
                [self showSelectionStatusMaskViewWithMsg:@"Wrong Answer !!!"];
                
            }
            
        }
        else {
            
            selectedCard = cardDict;
            
        }
        
    }
 
}


#pragma mark - Populate Content

- (void) populateContentForCell:(CardCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSMutableDictionary* cardDict = [[NSMutableDictionary alloc] initWithDictionary:[cardsArr objectAtIndex:indexPath.row]];
    
    if ([[cardDict valueForKey:@"isSelected"] intValue] == 0) {
        cell.cardImgView.image = [UIImage imageNamed:@"card_bg.png"];
    }
    else if ([[cardDict valueForKey:@"isSelected"] intValue] == -1) {
        cell.cardImgView.image = nil;
    }
    else{
        cell.cardImgView.image = [UIImage imageNamed:[cardDict valueForKey:@"image"]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Mask View helpers

- (void) showSelectionStatusMaskViewWithMsg:(NSString *) msg {
    
    selectionStatusView.view.alpha = 0.0;
    selectionStatusView.statusLabel.text = msg;
    [self.view addSubview:selectionStatusView.view];
    
    [UIView animateWithDuration:0.7 delay:0.0 options:0 animations:^{
        selectionStatusView.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        if ([msg isEqualToString:@"Right Answer !!!"]) {
            [selectedSecondCard setObject:@"-1" forKey:@"isSelected"];
            [selectedCard setObject:@"-1" forKey:@"isSelected"];
        }
        
        [self performSelector:@selector(hideSelectionStatusMaskView) withObject:nil afterDelay:0.5];
    }];
    
}

- (void) hideSelectionStatusMaskView {
    
    [UIView animateWithDuration:0.7 delay:0.0 options:0 animations:^{
        selectionStatusView.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [selectionStatusView.view removeFromSuperview];
        [self setupScore];
        [self resetAllSelectedCardsToUnselected];
        
        if ([self checkIfGameOver]) {
            [self showEnterScoreView];
        }
        
    }];
    
}

#pragma mark - Game Helpers


- (BOOL) checkIfGameOver {
    
    int count = 0;
    
    for (int i = 0; i < cardsArr.count; i++) {
        
        if ([[[cardsArr objectAtIndex:i] valueForKey:@"isSelected"] intValue] == -1) {
            count++;
        }
        
    }
    
    if (count == cardsArr.count) {
        return YES;
    }
    
    return NO;
    
}

#pragma mark - Enter Score View Helpers

- (void) showEnterScoreView {
    
    enterScoreView.view.alpha = 0.0;
    enterScoreView.headingLabel.text = [NSString stringWithFormat:@"Congrats!!! Your score is %d",totalScore];
    enterScoreView.score = [NSString stringWithFormat:@"%d",totalScore];
    [self.view addSubview:enterScoreView.view];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
        enterScoreView.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    
}

@end
