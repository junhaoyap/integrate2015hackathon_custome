//
//  UsersViewController.swift
//  GoodService-iOS
//
//  Created by Li Jia'En, Nicholette on 27/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import Foundation
import UIKit

class CustomersViewController: UITableViewController {
    // default sort by duration
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
    var dummyCustomers = [[String]]()

    init() {
        super.init(style: .Plain)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dummyCustomers = [
            user1,
            user2,
            user3,
            user4,
            user5
        ]
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CustomersHeaderCell",
                forIndexPath: indexPath) as UITableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomerCell",
            forIndexPath: indexPath) as! CustomersTableViewCell
        let currentUserData = dummyCustomers[indexPath.row - 1]

        cell.customerNumber.alpha = 0
        cell.durationLabel.alpha = 0
        cell.customerHappiness.alpha = 0
        cell.customerInfluence.alpha = 0
        cell.customerReputation.alpha = 0
        cell.customerPriority.alpha = 0

        UIView.animateWithDuration(0.75, animations: {
            cell.customerNumber.alpha = 1.0
            cell.durationLabel.alpha = 1.0
            cell.customerHappiness.alpha = 1.0
            cell.customerInfluence.alpha = 1.0
            cell.customerReputation.alpha = 1.0
            cell.customerPriority.alpha = 1.0
        })

        cell.customerNumber.text = currentUserData[0]
        cell.durationLabel.text = currentUserData[1]
        cell.customerHappiness.text = currentUserData[2]
        cell.customerInfluence.text = currentUserData[3]
        cell.customerReputation.text = currentUserData[4]
        cell.customerPriority.text = currentUserData[5]

        return cell
    }

    func update(dummyCustomers: [[String]]) {
        self.dummyCustomers = dummyCustomers
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView?.reloadData()
        }
    }
}