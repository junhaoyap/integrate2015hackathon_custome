//
//  NetworkUI.swift
//  GoodService-iOS
//
//  Created by Jingrong (: on 26/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkUI:NSObject {
    // Singleton pattern
    class var sharedInstance: NetworkUI {
        struct Static {
            static var instance: NetworkUI?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = NetworkUI()
        }
        
        return Static.instance!
    }
    
    /* Static URLs */
    
    let kBaseURL = "server_url"
    let kGetCustomerData = "service/"
    
    /* Functions */
    
    func getCustomerData(params:[String: AnyObject], success: (response: Result<AnyObject>) -> Void, failure: (error: ErrorType?) -> Void) {
        
        Alamofire.request(.GET, String(format: "%@%@", kBaseURL, kGetCustomerData), parameters: params)
            .responseJSON { request, response, result in
                if result.isSuccess {
                    success(response:result)
                    print ("customer pull done!")
                } else {
                    failure(error: result.error)
                    print ("customer pull fail!")                    
                }
                
        }
    }
}