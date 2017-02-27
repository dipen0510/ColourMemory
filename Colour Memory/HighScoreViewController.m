//
//  HighScoreViewController.m
//  Colour Memory
//
//  Created by Dipen Sekhsaria on 27/02/17.
//  Copyright © 2017 Dipen Sekhsaria. All rights reserved.
//

#import "HighScoreViewController.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _highScoreTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    highScoreArr = [[SharedClass sharedInstance] getAllHighScoreEntries];
    
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

- (IBAction)backButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma - mark TableView Datasource and Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return highScoreArr.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"HighScoreTableViewCell";
    HighScoreTableViewCell *cell = (HighScoreTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = (HighScoreTableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.nameLabel.font = [UIFont systemFontOfSize:15.0];
    cell.rankLabel.font = [UIFont systemFontOfSize:15.0];
    cell.scoreLabel.font = [UIFont systemFontOfSize:15.0];
    
    if (indexPath.row == 0) {
        cell.rankLabel.text = @"RANK";
        cell.nameLabel.text = @"NAME";
        cell.scoreLabel.text = @"SCORE";
        cell.nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cell.rankLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cell.scoreLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    else {
        cell.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell.nameLabel.text = [[highScoreArr objectAtIndex:indexPath.row-1] valueForKey:@"name"];
        cell.scoreLabel.text = [[highScoreArr objectAtIndex:indexPath.row-1] valueForKey:@"score"];
    }
    
    
    
    return cell;
}

@end
