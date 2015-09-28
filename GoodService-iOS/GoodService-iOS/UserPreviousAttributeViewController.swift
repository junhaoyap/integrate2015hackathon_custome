//
//  UserPreviousAttributeViewController.swift
//  GoodService-iOS
//
//  Created by Jingrong (: on 26/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import Foundation
import UIKit

class UserPreviousAttributeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /* Attributes */
    let userPreviousAttributesArray = ["Character", "Reputation", "Influence", "Mood"]
    let userPreviousAttributesArrayImages = ["user-outline", "mortar-board", "group", "heart-full-outline"]
    let customer = CustomerModel.sharedInstance
    
    // Storyboard outlets
    @IBOutlet weak var allMoodTiles: UICollectionView!
    
    
    override func viewDidLoad() {
        allMoodTiles.backgroundColor = UIColor.clearColor()
        allMoodTiles.delegate = self
        allMoodTiles.dataSource = self
    }
    
    // Collection View Stuff
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 4 Different attributes
        return 4
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = allMoodTiles.dequeueReusableCellWithReuseIdentifier("UserPreviousAttributeHeaderViewCell", forIndexPath: indexPath) as! UserPreviousAttributeHeaderViewCell
            cell.parent = self
            cell.nameLabel.text = self.userPreviousAttributesArray[indexPath.item]
            let attributes = [
                NSFontAttributeName : (UIFont) .typiconFontOfSize(50)]
            let text: NSMutableAttributedString = NSMutableAttributedString(string: (NSString) .typiconStringForIconName(userPreviousAttributesArrayImages[indexPath.item]), attributes: attributes)
            text.appendAttributedString(NSAttributedString(string: "   " + userPreviousAttributesArray[indexPath.item], attributes: [:]))
            
            cell.nameLabel!.attributedText = text
            
            // Set major feel
            cell.dominantCharacteristic.text = customer.getHighestCharacteristic()
            
            return cell

        }
        
        
        let cell = allMoodTiles.dequeueReusableCellWithReuseIdentifier("UserPreviousAttributeViewCell", forIndexPath: indexPath) as! UserPreviousAttributeViewCell
        cell.parent = self
        cell.nameLabel.text = self.userPreviousAttributesArray[indexPath.item]
        let attributes = [
            NSFontAttributeName : (UIFont) .typiconFontOfSize(50)]
        let text: NSMutableAttributedString = NSMutableAttributedString(string: (NSString) .typiconStringForIconName(userPreviousAttributesArrayImages[indexPath.item]), attributes: attributes)
        text.appendAttributedString(NSAttributedString(string: "   " + userPreviousAttributesArray[indexPath.item], attributes: [:]))
        
        cell.nameLabel!.attributedText = text
        
        // Set static data
        cell.highlightLabel.text = customer.getHighlightLabel(indexPath.item)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == 0 {
            self.performSegueWithIdentifier("ViewUserToneAnalyzerSegue", sender: self)

        }
    }
    
    
}
