//
//  SwipeViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Harry Ferrier on 8/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipeViewController: UIViewController {

    
    @IBOutlet weak var photo: UIImageView!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logout" {
        
            PFUser.logOut()
        
        }
        
    }
    
    
    @IBAction func logout(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "logout", sender: self)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(SwipeViewController.wasDragged(gesture:)))

        photo.addGestureRecognizer(gesture)

        photo.isUserInteractionEnabled = true
        
        updateImage()

    }
    
    
    
    
    func wasDragged(gesture: UIPanGestureRecognizer) {

        
        let label = gesture.view!

        
        let translation = gesture.translation(in: view)

        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height
            / 2 + translation.y)
        
        // ** TINDER STYLE SWIPE LEFT AND RIGHT IMPLEMENTATION..

        let xFromCenter = label.center.x - self.view.bounds.width / 2

        let scale =  min(abs(100 / xFromCenter), 1)

        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)

        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)

        label.transform = stretchAndRotation

        if gesture.state == .ended {

            if label.center.x < 100 {
                
                print("Not Chosen")
                
                updateImage()

            } else if label.center.x > self.view.bounds.width - 100 {
                
                print("Chosen")
                
                updateImage()
                
            }

            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)

            rotation = CGAffineTransform(rotationAngle: 0)

            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)

            label.transform = stretchAndRotation
            
        }
        
        
        
    }

    
    
    func updateImage() {
    
        let query = PFUser.query()
        
        query?.whereKey("isFemale", equalTo: PFUser.current()?["isInterestedInFemales"])
        query?.whereKey("isInterestedInFemales", equalTo: PFUser.current()?["isFemale"])
        
        query?.limit = 1
        
        query?.getFirstObjectInBackground(block: { (objects, error) in
            
            if error == nil {
            
                print("No error")
            
            } else {
            
                print("There was an error")
            
            }
            
        })
    
    }
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
