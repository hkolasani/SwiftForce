//
//  DataViewController.swift
//  SwiftForce
//
//  Created by Hari Kolasani on 9/21/14.
//  Copyright (c) 2014 BlueCloud Systems. All rights reserved.
//  http://www.bluecloudsystems.com.  http://www.moblu-app.com http://www.checkins-app.com
//

import UIKit

class DataViewController:UIViewController,UITableViewDataSource,UITableViewDelegate,SFAuthenticationManagerDelegate,SFUserAccountManagerDelegate {
    
    @IBOutlet
    var theTableView: UITableView!
    
    var users:[Dictionary<String,AnyObject>]?
    
    override func viewDidLoad() {
        self.getData()
    }
    
    func getData() {
        
        var query:String = "Select Id,Name from User "
        
        SFDCDataManager.runQuery(query, handler: { response,error in
            
            if(error == nil) {
                self.users = response as [Dictionary<String,AnyObject>]!
            
                dispatch_async(dispatch_get_main_queue(), {
                    self.theTableView.reloadData()
                })
            }
            else {
                self.showAlert("Data Access Error",message:error.localizedDescription)
            }

        })
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "USERS"
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.users != nil) {
            return self.users!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")

        cell.textLabel!.text = ""
        
        if let user = self.users![indexPath.row] as Dictionary<String,AnyObject>! {
            if let name: AnyObject = user["Name"] {
                cell.textLabel!.text = name as? String
            }
        }
        
       return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        if let user = self.users![indexPath.row] as Dictionary<String,AnyObject>! {
            if let name: AnyObject = user["Name"] {
                println("You selected: \(name)")
            }
        }
        
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
