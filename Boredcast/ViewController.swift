//
//  ViewController.swift
//  Boredcast
//
//  Created by Rudolf Dani on 2018. 09. 22..
//  Copyright © 2018. Rudolf Dani. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginBtnPushed(_ sender: Any) {
        
        let username = userNameText.text
        let password = passwordText.text
        
        if (username?.isEmpty)! || (password?.isEmpty)! {
            
            displayMessage(userMessage: "Mindket mezot ki kell tolteni!")
            return
        }
        
        self.logInRequest {
            
            let MessengerVC = self.storyboard?.instantiateViewController(withIdentifier: "MessengerVC") as! MessengerVC
            self.present(MessengerVC, animated: true)
            
            
        }
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)   	        
        }
    }
    
    func logInRequest (completed:@escaping downloadCompleted) {
        
        let username = userNameText.text!
        let password = passwordText.text!
        
        let parameters : Parameters = [
            "username" : username,
            "password" : password
        ]
        
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = self.view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        self.view.addSubview(myActivityIndicator)
        
        Alamofire.request(BASEURL, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            print(response)
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                print("fos")
                if let loginOK = dict["valami"] as? String {
                    
                    if loginOK == "false" {
                        
                        self.displayMessage(userMessage: "Wrong Username or Password!")
                        
                        self.removeActivityIndcator(activityIndicator: myActivityIndicator)
                        completed()
                        return
                        
                    }
                }
            }
            
            
        }
        self.removeActivityIndcator(activityIndicator: myActivityIndicator)
        completed()
    }
    
    func removeActivityIndcator(activityIndicator: UIActivityIndicatorView) {
        
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
        }
        
    }
    
}

