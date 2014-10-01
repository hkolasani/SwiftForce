//
//  SFDCDataManager.swift
//  SwiftForce
//
//  Created by Hari Kolasani on 9/21/14.
//  Copyright (c) 2014 BlueCloud Systems. All rights reserved.
//  http://www.bluecloudsystems.com.  http://www.moblu-app.com http://www.checkins-app.com
//

import Foundation

class SFDCDataManager {
       
    class func login(handler:(Bool,NSError!)->Void) {
        
        var sfdcSettings:SFDCSettings = SFDCSettings()
        
        SFUserAccountManager.sharedInstance().oauthClientId = sfdcSettings.clientId
        SFUserAccountManager.sharedInstance().oauthCompletionUrl = sfdcSettings.callbackURL
        
        SFAuthenticationManager.sharedManager().loginWithCompletion( { oAuthInfo in
            handler(true,nil)
            }, failure: { oAuthInfo,error in
                handler(false,error)
        })
    }
    
    class func runQuery(query:String,handler:([Dictionary<String,AnyObject>]!,NSError!)->Void) {
                
        SFRestAPI.sharedInstance().performSOQLQuery(query, failBlock: { error in
            handler(nil,error)
            }) { queryResponse in
                handler(queryResponse["records"]! as? [Dictionary<String,AnyObject>] ,nil)
        }
    }
}
