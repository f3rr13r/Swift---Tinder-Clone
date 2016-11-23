//
//  UserDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Harry Ferrier on 8/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var genderSwitch: UISwitch!
    
    @IBOutlet weak var interestedInSwitch: UISwitch!
    
    
    @IBOutlet weak var uploadDetailsButton: UIButton!
    
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    
    @IBAction func choosePhoto(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            photo.image = image
        
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func uploadDetails(_ sender: AnyObject) {
        
        showActivityIndicator()
        
        let user = PFUser.current()
        
        if genderSwitch.isOn {
        
            user?["isFemale"] = "YES"
        
        } else {
        
            user?["isFemale"] = "NO"
        
        }
        
        if interestedInSwitch.isOn {
        
            user?["isInterestedInFemales"] = "YES"
        
        } else {
        
            user?["isInterestedInFemales"] = "NO"
        
        }
        
        
        let image = photo.image
        
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        
        let imageFile = PFFile(name: "photo.jpg", data: imageData!)
        
        
        user?["photo"] = imageFile
        
        
        user?.saveInBackground(block: { (success, error) in
            
            self.hideActivityIndicator()
            
            
            if success {
            
                self.showAlertBox(title: "User Detail Success", message: "We have successfully stored your details")
                
                self.performSegue(withIdentifier: "userDetailsToSwipe", sender: self)
                
            
            } else if let error = error {
            
                self.showAlertBox(title: "Error", message: "\(error.localizedDescription)")
            
            } else {
            
                self.showAlertBox(title: "Unknown Error", message: "Please try again later")
            
            }
            
        })
        
    }
    
    
    
    func showAlertBox(title: String, message: String) {
        
        let alert = UIAlertView(title: title, message: message, delegate: view, cancelButtonTitle: "OK")
        
        alert.show()
        
    }
    
    
    
    
    func showActivityIndicator() {
        
        uploadDetailsButton.setTitle("", for: .normal)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        uploadDetailsButton.addSubview(activityIndicator)
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    
    
    func hideActivityIndicator() {
        
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        
        UIApplication.shared.endIgnoringInteractionEvents()
        
        uploadDetailsButton.setTitle("Upload Details", for: .normal)
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
