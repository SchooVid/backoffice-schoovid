//
//  AuthenticationViewController.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import UIKit


class AuthenticationViewController: UIViewController {
    
    var authService: AuthenticationService = AuthenticationService()

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.setNavigationBarHidden(true,animated:animated)
    }

    @IBAction func loginButton(_ sender: Any) {
        
        let username = self.usernameTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
    
        guard username.count > 0, password.count > 0 else {
            let alert = UIAlertController(title:"Erreur",message:"Champs obligatoires",preferredStyle: .alert)
            self.present(alert, animated: true){
                Timer.scheduledTimer(withTimeInterval: 1, repeats:false){ (_) in
                    alert.dismiss(animated:true)
                    
                }
            }
            
            return
        }
        
        let auth = Authentication(username: username, password: password)
       
        self.authService.auth(login: auth){ (userInfo) in
            DispatchQueue.main.sync {
                
                if(userInfo?.id != nil){
                    
                    self.navigationController?.pushViewController(HomeViewController(), animated : true)
                    
                   
                    
                } else {
                    let alertError = UIAlertController(title:"Erreur",message:"Votre nom d'utilisateur ou votre mot de passe est incorrect",preferredStyle: .alert)
                    
                    self.present(alertError,animated:true){
                        Timer.scheduledTimer(withTimeInterval: 1, repeats:false){ (_) in
                            alertError.dismiss(animated:true)
                        }
                    }
                }
            
            }
        
        
        }
    
    }
    
}
