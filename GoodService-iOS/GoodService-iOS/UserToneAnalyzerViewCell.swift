//
//  UserToneAnalyzerViewCell.swift
//  GoodService-iOS
//
//  Created by Jingrong (: on 27/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import UIKit

class UserToneAnalyzerViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    func setUpProgressBar(score: Double) {
        // Do something with progress bar
        let progressBarTransform = CGAffineTransformMakeScale(1.0, 4.0)
        self.progressBarView.transform = progressBarTransform
        self.progressBarView.setProgress(Float(score), animated: true)
        print (nameLabel.text)
        print (score)
        
    }
}
