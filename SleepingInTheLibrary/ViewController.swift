//
//  ViewController.swift
//  SleepingInTheLibrary
//
//  Created by Jarrod Parkes on 11/3/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var grabImageButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func grabNewImage(_ sender: AnyObject) {
        setUIEnabled(false)
        getImageFromFlickr()
    }
    
    // MARK: Configure UI
    
    private func setUIEnabled(_ enabled: Bool) {
        photoTitleLabel.isEnabled = enabled
        grabImageButton.isEnabled = enabled
        
        if enabled {
            grabImageButton.alpha = 1.0
        } else {
            grabImageButton.alpha = 0.5
        }
    }
    
    // MARK: Make Network Request
    
    private func getImageFromFlickr() {
        
        // TODO: Write the network code here!
        
        let methodParameters = [Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.SearchMethod,
                                Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
                                Constants.FlickrParameterKeys.brand: Constants.FlickrParameterValues.brandValue,
                                Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
                                Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback,
                                Constants.FlickrParameterKeys.authToken: Constants.FlickrParameterValues.authTokenValue]
        
        let urlString = Constants.Flickr.APIBaseURL + escapedParameters(methodParameters as [String:AnyObject])
        if let url = URL(string: urlString){
            print("items nuwrapped succesfully")
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    print(data)
                }
            }
            
            task.resume()

        } else {
            print("item cannot be unwarapped \(urlString)")
        }
        

    }
    
    private func escapedParameters(_ parameters:[String:AnyObject]) -> String {
        if parameters.isEmpty {
            return "url is empty"
        } else {
            var keyValuePairs = [String]()
            for(key,value) in parameters {
                let stringValue = "\(value)"
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                keyValuePairs.append(key+"="+"\(escapedValue)")
            }
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
}
