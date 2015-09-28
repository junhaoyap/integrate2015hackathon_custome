//
//  UserToneAnalyzerViewController.swift
//  GoodService-iOS
//
//  Created by Jingrong (: on 27/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import UIKit

class UserToneAnalyzerViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /* Attributes */
    
    // Storyboard outlets
    @IBOutlet weak var allCharacterTiles: UICollectionView!
    let customer = CustomerModel.sharedInstance
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clearColor()
        allCharacterTiles.backgroundColor = UIColor.clearColor()
        allCharacterTiles.delegate = self
        allCharacterTiles.dataSource = self
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    // Collection View Stuff
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 9 watson entities
        return 9
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = allCharacterTiles.dequeueReusableCellWithReuseIdentifier("UserToneAnalyzerViewCell", forIndexPath: indexPath) as! UserToneAnalyzerViewCell
        cell.nameLabel.text = customer.getCustomerCharacterTitle(indexPath.item)
        cell.setUpProgressBar(customer.getCustomerCharacterScore(cell.nameLabel.text!)!)
        return cell
    }
    
}
