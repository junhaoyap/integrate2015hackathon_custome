//
//  UserPreviousAttributeViewHeaderCell.swift
//  GoodService-iOS
//
//  Created by Li Jia'En, Nicholette on 27/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import UIKit

class UserPreviousAttributeHeaderViewCell: UICollectionViewCell {
    // Storyboard connected variables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIImageView!
    @IBOutlet weak var dominantCharacteristic: UILabel!
    
    // Instance variables
    weak var parent : UserPreviousAttributeViewController!
    
}
