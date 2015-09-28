//
//  CustomerModel.swift
//  GoodService-iOS
//
//  Created by Jingrong (: on 26/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class CustomerModel {
    // Singleton
    class var sharedInstance: CustomerModel {
        struct Static {
            static var instance: CustomerModel?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CustomerModel()
        }
        
        return Static.instance!
    }
    
    /* Attributes */
    var userID:String!
    var customerDataJSON:JSON!
    var customerSentimentJSON:JSON!
    var customerToneJSON:JSON!
    var customerData = Dictionary<String, String>()
    var customerCharacter = Dictionary<String, Double>()
    
    /* Functions */
    func updateNewCustomer(parameters: [String: AnyObject]) {
        NetworkUI.sharedInstance.getCustomerData(parameters, success: { (response) -> Void in
            
            let arrayJSON = JSON(response.value!)
            self.customerDataJSON = arrayJSON["call_logs"]["records"][0]
            self.customerSentimentJSON = arrayJSON["sentiment_analysis"]["aggregate"]
            self.customerToneJSON = arrayJSON["tone_analysis"]["children"]
            
            self.updateCustomerData()
            self.updateCustomerCharacter()
            
            print (self.customerData)
            
            }) { (error) -> Void in
                print ("buang")
        }
        
    }
    
    private func updateCustomerData() {
        self.customerData["customerNumber"] = self.customerDataJSON["from"]["phoneNumber"].string
        self.customerData["customerLocation"] = self.customerDataJSON["from"]["location"].string
        self.customerData["numberDialedTo"] = self.customerDataJSON["to"].string
        self.customerData["startTime"] = self.customerDataJSON["startTime"].string
        self.customerData["sessionId"] = self.customerDataJSON["sessionId"].string
        self.customerData["id"] = self.customerDataJSON["id"].string
    }
    
    private func updateCustomerCharacter() {
        /*
        * 0: Emotion
        * 1: Writing
        * 2: Social Tone
        */
        
        // Emotion
        self.customerCharacter["Cheerfulness"]      = self.customerToneJSON[0]["children"][0]["normalized_score"].double
        self.customerCharacter["Negative"]          = self.customerToneJSON[0]["children"][1]["normalized_score"].double
        self.customerCharacter["Anger"]             = self.customerToneJSON[0]["children"][2]["normalized_score"].double
        
        // Writing
        self.customerCharacter["Analytical"]        = self.customerToneJSON[1]["children"][0]["normalized_score"].double
        self.customerCharacter["Confident"]         = self.customerToneJSON[1]["children"][1]["normalized_score"].double
        self.customerCharacter["Tentative"]         = self.customerToneJSON[1]["children"][2]["normalized_score"].double
        
        // Social Tone
        self.customerCharacter["Openness"]          = self.customerToneJSON[2]["children"][0]["normalized_score"].double
        self.customerCharacter["Agreeableness"]     = self.customerToneJSON[2]["children"][1]["normalized_score"].double
        self.customerCharacter["Conscientiousness"] = self.customerToneJSON[2]["children"][2]["normalized_score"].double
        
        // HP Haven Sentiment
        self.customerCharacter["Sentiment"]         = self.customerSentimentJSON["score"].double
    }
    
    func getCustomerCharacterTitle(index: Int) -> String {
        let arrayOfText =  [
            "Cheerfulness",
            "Negative",
            "Anger",
            "Analytical",
            "Confident",
            "Tentative",
            "Openness",
            "Agreeableness",
            "Conscientiousness",
        ]
        
        return arrayOfText[index]
    }
    
    func getCustomerCharacterScore(index: String) -> Double? {
//        let arrayOfScore = [
//            "Cheerfulness":     self.customerToneJSON[0]["children"][0]["normalized_score"].double as Double?,
//            "Negative":         self.customerToneJSON[0]["children"][1]["normalized_score"].double as Double?,
//            "Anger":            self.customerToneJSON[0]["children"][2]["normalized_score"].double as Double?,
//            "Analytical":       self.customerToneJSON[1]["children"][0]["normalized_score"].double as Double?,
//            "Confident":        self.customerToneJSON[1]["children"][1]["normalized_score"].double as Double?,
//            "Tentative":        self.customerToneJSON[1]["children"][2]["normalized_score"].double as Double?,
//            "Openness":         self.customerToneJSON[2]["children"][0]["normalized_score"].double as Double?,
//            "Agreeableness":    self.customerToneJSON[2]["children"][1]["normalized_score"].double as Double?,
//            "Conscientiousness":self.customerToneJSON[2]["children"][2]["normalized_score"].double as Double?,
//            
        //        ]
        // only use if server has been set up
        let arrayOfScore =  [
            "Cheerfulness" : 0.1,
            "Negative" : 0.2,
            "Anger" : 0.3 ,
            "Analytical" : 0.4 ,
            "Confident" : 0.5 ,
            "Tentative" : 0.6 ,
            "Openness" : 0.7,
            "Agreeableness": 0.8,
            "Conscientiousness" : 0.9,
        ]
        
        return arrayOfScore[index]!
    }
    
    func getHighestCharacteristic() -> String {
//        let arrayOfScore = [
//            "Cheerfulness":     self.customerToneJSON[0]["children"][0]["normalized_score"].double as Double?,
//            "Negative":         self.customerToneJSON[0]["children"][1]["normalized_score"].double as Double?,
//            "Anger":            self.customerToneJSON[0]["children"][2]["normalized_score"].double as Double?,
//            "Analytical":       self.customerToneJSON[1]["children"][0]["normalized_score"].double as Double?,
//            "Confident":        self.customerToneJSON[1]["children"][1]["normalized_score"].double as Double?,
//            "Tentative":        self.customerToneJSON[1]["children"][2]["normalized_score"].double as Double?,
//            "Openness":         self.customerToneJSON[2]["children"][0]["normalized_score"].double as Double?,
//            "Agreeableness":    self.customerToneJSON[2]["children"][1]["normalized_score"].double as Double?,
//            "Conscientiousness":self.customerToneJSON[2]["children"][2]["normalized_score"].double as Double?,
//            
        //        ]
        // only use if server has been set up
        let arrayOfScore =  [
            "Cheerfulness" : 0.1,
            "Negative" : 0.2,
            "Anger" : 0.3 ,
            "Analytical" : 0.4 ,
            "Confident" : 0.5 ,
            "Tentative" : 0.6 ,
            "Openness" : 0.7,
            "Agreeableness": 0.8,
            "Conscientiousness" : 0.9,
        ]

        var maxCharString = "conscientiousness"
        var maxCharValue = -1.0
//        
//        for (eachKey, eachValue) in arrayOfScore {
//            // New Max identified
//            if (eachValue > maxCharValue) {
//                maxCharString = eachKey
//                maxCharValue = eachValue!
//            }
//        }
        // only use if server has been set up
        return maxCharString

    }
    
    func getHighlightLabel (index: Int) -> String {
        if (index == 1) {
            // Reputation
            return "0.738"
        } else if (index == 2) {
            // Influence
            return "0.613"
        } else if (index == 3) {
            // Mood ( HP )
            if let _sentiment = self.customerCharacter["Sentiment"] {
                if (_sentiment != 0.0) {
                    return String(self.customerCharacter["Sentiment"])
                } else {
                    return String("0.385")
                }
            }
        }
        
        // Should never reach here!
        return "0.1415926535"
    }
}
