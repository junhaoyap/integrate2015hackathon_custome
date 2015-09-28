//
//  SortViewController.swift
//  GoodService-iOS
//
//  Created by Jun Hao Yap on 9/27/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import Foundation
import UIKit

class SortViewController: UIViewController {
    let user1 = [
        "+1 (206) 822-7801",
        "1:13", // 1
        "0.4", // 5
        "0.5", // 4
        "0.93", // 1
        "100" // 3
    ]
    let user2 = [
        "+1 (206) 822-7802",
        "0:59", // 2
        "0.5", // 4
        "0.6", // 3
        "0.54", // 4
        "-107" // 5
    ]
    let user3 = [
        "+1 (206) 822-7803",
        "0:53", // 3
        "0.6", // 3
        "0.7", // 2
        "0.62", // 3
        "725" // 1
    ]
    let user4 = [
        "+1 (206) 822-7804",
        "0:49", // 4
        "0.7", // 2
        "0.8", // 1
        "0.77", // 2
        "0" // 4
    ]
    let user5 = [
        "+1 (206) 822-7805",
        "0:42", // 5
        "0.8", // 1
        "0.4", // 5
        "0.21", // 5
        "123" // 2
    ]

    @IBAction func sortDuration(sender: AnyObject) {
        let durationSortUsers = [
            user1,
            user2,
            user3,
            user4,
            user5
        ]
        for controller in self.childViewControllers {
            if controller.isKindOfClass(CustomersViewController) {
                let thatController = controller as! CustomersViewController
                thatController.update(durationSortUsers)
            }
        }
    }

    @IBAction func sortHappiness(sender: AnyObject) {
        let durationHappinessUsers = [
            user5,
            user4,
            user3,
            user2,
            user1
        ]
        for controller in self.childViewControllers {
            if controller.isKindOfClass(CustomersViewController) {
                let thatController = controller as! CustomersViewController
                thatController.update(durationHappinessUsers)
            }
        }
    }

    @IBAction func sortInfluence(sender: AnyObject) {
        let durationInfluenceUsers = [
            user4,
            user3,
            user2,
            user1,
            user5
        ]
        for controller in self.childViewControllers {
            if controller.isKindOfClass(CustomersViewController) {
                let thatController = controller as! CustomersViewController
                thatController.update(durationInfluenceUsers)
            }
        }
    }

    @IBAction func sortReputation(sender: AnyObject) {
        let durationReputationUsers = [
            user1,
            user4,
            user3,
            user2,
            user5
        ]
        for controller in self.childViewControllers {
            if controller.isKindOfClass(CustomersViewController) {
                let thatController = controller as! CustomersViewController
                thatController.update(durationReputationUsers)
            }
        }

    }
    
    @IBAction func sortPriority(sender: AnyObject) {
        let durationPriorityUsers = [
            user3,
            user5,
            user1,
            user4,
            user2
        ]
        for controller in self.childViewControllers {
            if controller.isKindOfClass(CustomersViewController) {
                let thatController = controller as! CustomersViewController
                thatController.update(durationPriorityUsers)
            }
        }
    }
}
