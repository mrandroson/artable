//
//  RegisterVC.swift
//  Artable
//
//  Created by Andros on 5/5/20.
//  Copyright © 2020 Andros. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    
    //Outlets
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var passimgCheck: UIImageView!
    
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }
    

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let passTxt = passwordTxt.text else {return}
        
        
        
        //If we have started typing in the confirm pass text field
        if textField == confirmPassTxt {
            passimgCheck.isHidden = false
            confirmPassCheckImg.isHidden = false
            
        } else {
            if passTxt.isEmpty {
                passimgCheck.isHidden = true
                confirmPassCheckImg.isHidden = true
                confirmPassTxt.text = ""
            }
        }
        
        //Make it so when the passwords match, the checkmarks turn green
        
        if passwordTxt.text == confirmPassTxt.text {
            confirmPassCheckImg.image = UIImage(named: AppImages.GreenCheck)
            passimgCheck.image = UIImage(named: AppImages.GreenCheck)
        } else { confirmPassCheckImg.image = UIImage(named: AppImages.RedCheck)
            passimgCheck.image = UIImage(named: AppImages.RedCheck)}
    }
    

    @IBAction func registerClicked(_ sender: Any) {
        
        guard let email = emailTxt.text , email.isNotEmpty ,
            let username = usernameTxt.text , username.isNotEmpty ,
            let password = passwordTxt.text , password.isNotEmpty else { return }
        
        
            
        activityIndicator.startAnimating()
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
           
            if let error = error {
                debugPrint(error)
                return
                
            }
            self.activityIndicator.stopAnimating()
            
            print("succesfully registered new user.")
            
        }
    }
    

    
    
}
