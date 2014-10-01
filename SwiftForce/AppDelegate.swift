//
//  AppDelegate.swift
//  SwiftForce
//
//  Created by Hari Kolasani on 9/21/14.
//  Copyright (c) 2014 BlueCloud Systems. All rights reserved.
//  http://www.bluecloudsystems.com.  http://www.moblu-app.com http://www.checkins-app.com
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,SFAuthenticationManagerDelegate,SFUserAccountManagerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self .initializeAppViewState()
        
        // Override point for customization after application launch.
    
        SFAuthenticationManager.sharedManager().addDelegate(self)
        SFUserAccountManager.sharedInstance().addDelegate(self)
        
        var sfdcSettings:SFDCSettings = SFDCSettings()
        
        SFUserAccountManager.sharedInstance().oauthClientId = sfdcSettings.clientId
        SFUserAccountManager.sharedInstance().oauthCompletionUrl = sfdcSettings.callbackURL
        
        self.loginToSFDC()
        
        return true
    }
    
    func loginToSFDC() {
        
        SFAuthenticationManager.sharedManager().loginWithCompletion( { oAuthInfo in
             self.setupRootViewController()
            }, failure: { oAuthInfo,error in
                SFAuthenticationManager.sharedManager().logout()
        })
    }
    
    func initializeAppViewState() {
        
        var initialViewController: InitialViewController? = InitialViewController(nibName:"InitialViewController", bundle: nil)
        
        self.window?.rootViewController = initialViewController
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
    }
    
    func setupRootViewController() {
        
        let storyboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        var dataViewController:DataViewController = storyboard.instantiateViewControllerWithIdentifier("DataView") as DataViewController
        self.window?.rootViewController = dataViewController
    }
    
    func userAccountManager(userAccountManager: SFUserAccountManager!, didSwitchFromUser fromUser: SFUserAccount!, toUser: SFUserAccount!) {
        //self.showAlert("Info", message: "Login Host Changed")
        self.loginToSFDC()
    }
    
    func authManagerDidLogout(manager: SFAuthenticationManager!) {
        //self.showAlert("Info", message: "Logged Out")
        self.loginToSFDC()
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func showAlert(title:String,message:String) {
        
        var alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = title;
        alertView.message = message;
        
        dispatch_async(dispatch_get_main_queue(), {
            alertView.show();
        })
    }


}

