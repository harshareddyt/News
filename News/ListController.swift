//
//  ListController.swift
//  News
//
//  Created by Sunny Reddy on 02/11/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class ListController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataObject = NSArray()
   // var postID = NSNumber()


    
    @IBOutlet weak var TableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("check value:")
        print(dataObject.count)
        return dataObject.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell",for: indexPath) as!ListTableViewCell
        
        
        let NameTitle = (self.dataObject.object(at:indexPath.row) as! NSDictionary).value(forKey:"name")
        if NameTitle is NSNull{
            print("null values")
        }
        else{
            var title = NameTitle as! NSString
            cell.NameLabel.text = NameTitle as? String
        }
        
        let jobTitle = (self.dataObject.object(at:indexPath.row) as! NSDictionary).value(forKey:"color")
        if jobTitle is NSNull{
            print("null values")
        }
        else{
            var title = jobTitle as! NSString
            cell.JobLabel.text = jobTitle as? String
        }
        
        
        
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let x = indexPath.row
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListDetailController")as!ListDetailController
        let ID = (self.dataObject.object(at: indexPath.row) as! NSDictionary).value(forKey: "id") as! NSNumber
        vc.texts = "\(ID)"
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeData()

    }
    
    
    func homeData(){
        
        let url:URL = URL(string: "https://reqres.in/api/unknown")!
        
        let postString = ""
        print("postString:::\(postString)")
        let postData:Data = postString.data(using: String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
        let postLength:NSString = String( postData.count ) as NSString
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        
        request.httpMethod = "GET"
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
            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
            {
                let responseData:NSString  = NSString(data:urlData!,    encoding:String.Encoding.utf8.rawValue)!
                NSLog("Response ==> %@", responseData);
            }
        }
        do {
            let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
            dataObject = (jsonData?.value(forKey:"data")) as! NSArray
            print("dataString:::\(dataObject)")
          
        }
    }
}
