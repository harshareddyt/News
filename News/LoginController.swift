//
//  LoginController.swift
//  News
//
//  Created by Sunny Reddy on 21/11/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    
    @IBOutlet weak var Usernametextfield: UITextField!
    
    @IBOutlet weak var Passwordtextfield: UITextField!
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        logincheck()
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        
        let view = self.storyboard?.instantiateViewController(withIdentifier:
            "RegisterController") as! RegisterController
        self.present( view, animated:false, completion:nil)
    }
    
    
    func logincheck()
    {
        
        let url:URL = URL(string:"https://reqres.in/api/login")!
        let postString = "email=\(Usernametextfield.text!)&password=\(Passwordtextfield.text!)"
        let postData:Data = postString.data(using: String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
        let postLength:NSString = String( postData.count ) as NSString
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        var reponseError: NSError?
        var response: URLResponse?
        var urlData: Data?
        do {
            urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
        } catch let error as NSError {
            reponseError = error
            urlData = nil
        }
        if ( urlData != nil ) {
            let res = response as! HTTPURLResponse!;
            print("Response code: %ld", res?.statusCode);
            if ((res?.statusCode)! == 200)
            {
                do {
                    let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
                    let token = (jsonData?.value(forKey:"token")) as! NSString
                        let view = self.storyboard?.instantiateViewController(withIdentifier:
                            "HomeController") as! HomeController
                        self.present( view, animated:false, completion:nil)
                }
            }
            else{
                let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
                let error = (jsonData?.value(forKey:"error")) as! NSString
                //show popup
            }
        }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Usernametextfield.text = "eve.holt@reqres.in"
        self.Passwordtextfield.text = "cityslicka"
            rechebil()
    }
    
    func rechebil()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            let alert = UIAlertController(title: "", message: "No Internet Connection", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Try Again", style: .default, handler: { action in
                self.rechebil()
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        case .online(.wwan):
            print("Connected via WWAN")
        case .online(.wiFi):
            print("Connected via WiFi")
        }
    }

    


}
