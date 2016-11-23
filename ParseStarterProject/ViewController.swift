/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    @IBAction func signup(_ sender: AnyObject) {
        
        if usernameTextField.text != "" && passwordTextField.text != "" {
            
            showActivityIndicator()
        
            let newUser = PFUser()
            let username = usernameTextField.text
            let password = passwordTextField.text
            
            newUser.username = username
            newUser.password = password
            
            let acl = PFACL()
            acl.getPublicReadAccess = true
            acl.getPublicWriteAccess = true
            
            newUser.acl = acl
            
            
            newUser.signUpInBackground(block: { (success, error) in
                
                self.hideActivityIndicator()
                
                if success {
                
                    self.showAlertBox(title: "Sign Up Success", message: "Welcome to Tinder")
                    
                    self.performSegue(withIdentifier: "signupToUserDetails", sender: self)
                
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
    
    @IBAction func toLogin(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "toLogin", sender: self)
        
    }
    
    
    
    func showAlertBox(title: String, message: String) {
    
        let alert = UIAlertView(title: title, message: message, delegate: view, cancelButtonTitle: "OK")
        
        alert.show()
    
    }
    
    
    
    func showActivityIndicator() {
    
        signupButton.setTitle("", for: .normal)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        signupButton.addSubview(activityIndicator)
        
        UIApplication.shared.beginIgnoringInteractionEvents()
    
    }
    
    
    
    func hideActivityIndicator() {
    
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        
        UIApplication.shared.endIgnoringInteractionEvents()
        
        signupButton.setTitle("Sign Up", for: .normal)
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            if PFUser.current()?["isFemale"] != nil && PFUser.current()?["isInterestedInFemales"] != nil && PFUser.current()?["photo"] != nil {
                
                performSegue(withIdentifier: "signupToSwipe", sender: self)
                
            }
            
        }

        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
