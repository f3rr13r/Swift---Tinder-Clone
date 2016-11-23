//
//  LoginViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Harry Ferrier on 8/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    
    
    @IBAction func login(_ sender: AnyObject) {
        
        showActivityIndicator()
        
        if usernameTextField.text != "" && passwordTextField.text != "" {
        
            let username = usernameTextField.text!
            let password = passwordTextField.text!
            
            PFUser.logInWithUsername(inBackground: username, password: password, block: { (user, error) in
                
                self.hideActivityIndicator()
                
                if user != nil {
                
                    self.showAlertBox(title: "Login Sucessful", message: "Welcome back to Tinder")
                    
                    self.performSegue(withIdentifier: "loginToSwipe", sender: self)
                    
                } else if let error = error {
                
                    self.showAlertBox(title: "Error", message: "\(error.localizedDescription)")
                
                } else {
                
                    self.showAlertBox(title: "Error", message: "Please try again later")
                
                }
                
                
            })
            
            
            
            
        
        } else {
        
            showAlertBox(title: "Error", message: "Please enter a username and password")
        
        }
        
        
    }
    
    @IBAction func toSignup(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "toSignup", sender: self)
        
    }
    
    
    func showAlertBox(title: String, message: String) {
        
        let alert = UIAlertView(title: title, message: message, delegate: view, cancelButtonTitle: "OK")
        
        alert.show()
        
    }

    
    func showActivityIndicator() {
        
        loginButton.setTitle("", for: .normal)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        loginButton.addSubview(activityIndicator)
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    
    
    func hideActivityIndicator() {
        
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        
        UIApplication.shared.endIgnoringInteractionEvents()
        
        loginButton.setTitle("Log In", for: .normal)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
