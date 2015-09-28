//
//  LoginViewController.swift
//  GoodService-iOS
//
//  Created by Jingrong (: on 27/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//


import UIKit

class LoginViewController: UIViewController {
    
    /* Attributes */
    let customer = CustomerModel.sharedInstance
    
    override func viewDidLoad() {
        customer.updateNewCustomer(["":""])
    }

}

