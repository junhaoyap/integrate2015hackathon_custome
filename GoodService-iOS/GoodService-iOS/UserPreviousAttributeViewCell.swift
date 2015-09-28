//
//  UserPreviousAttributeViewCell.swift
//  GoodService-iOS
//
//  Created by Jingrong (: on 26/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import UIKit

class UserPreviousAttributeViewCell: UICollectionViewCell {
    // Storyboard connected variables
    @IBOutlet weak var nameLabel: UILabel!
    //    @IBOutlet weak var opacityBackground: UIView!
    //    @IBOutlet weak var deleteButton: UIButton!
    
    // Instance variables
    weak var parent : UserPreviousAttributeViewController!
    
    @IBOutlet weak var highlightLabel: UILabel!
}
