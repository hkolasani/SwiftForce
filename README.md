SwiftForce
==========
This is sample XCode project for building Force.com iOS apps usign theier Mobile SDK. It's entirely written in Swift . 
You should be able to just download and get it going, but if you want to start from scratch, these are the steps involved.

- Create a Swift Project in XCode

- Download and set up your XCode project as outlined in https://github.com/forcedotcom/SalesforceMobileSDK-iOS-Distribution

- In the Build Settings—>Header search paths. Add the following.
    $(PROJECT_DIR)/Dependencies/SalesforceOAuth/Headers
    $(PROJECT_DIR)/Dependencies/SalesforceNetworkSDK/Headers
    $(PROJECT_DIR)/Dependencies/SalesforceNativeSDK/Headers
    $(PROJECT_DIR)/Dependencies/SalesforceSDKCore/Headers
    $(PROJECT_DIR)/Dependencies/SalesforceCommonUtils/Headers
    $(PROJECT_DIR)/Dependencies/SalesforceSecurity/Headers
    $(PROJECT_DIR)/Dependencies/MKNetworkKit/Headers

- Add an Objective C file. It’ll ask if you want to configure a objective C bridging header. Click Yes and delete the Objective C file and just keep the birding header

- Add the following imports to the bidding header file
     import "SFRestAPI+Blocks.h"<br>
     import "SFAccountManager.h"<br>
     import "SFAuthenticationManager.h"<br>
     import "SFOAuthInfo.h"<br>

- Set up Remote App in Salesforce and get the clientid and callback URL to be added to SFDCSettings.swift
