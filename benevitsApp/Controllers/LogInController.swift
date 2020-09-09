//
//  ViewController.swift
//  benevitsApp
//
//  Created by Pedro Antonio Vazquez Rodriguez on 08/09/20.
//  Copyright © 2020 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit

class LogInController: UIViewController, UITextFieldDelegate {

    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        logInButton.layer.cornerRadius = logInButton.frame.height/2
        mailTextField.keyboardType = .emailAddress
        mailTextField.delegate = self
        passwordTextField.delegate = self
        //agregamos las acciones a los textFields para activar y desactivarlos
        mailTextField.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: UIControl.Event.editingChanged)
    }
    
    //revisa Cambios en textField
    @objc func textFieldChanged(_ target:UITextField) {
        let email = mailTextField.text
        let password = passwordTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setLoginButtonEnabled(enabled: formFilled)
    }

    //Activao desactiva el boton de entrar
    func setLoginButtonEnabled(enabled:Bool) {
        if enabled {
            logInButton.backgroundColor = UIColor(named: "rojoInfonavit")
            logInButton.isEnabled = true
        } else {
            logInButton.backgroundColor = UIColor(named: "grisInfonavit")
            logInButton.isEnabled = false
        }
    }
    //hace el cambio entre los TextFields y manda la peticion POST
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
      {

         if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
         } else {
            if logInButton.isEnabled{
                logIn()
            }
            textField.resignFirstResponder()
         }
         return false
      }
    // barra de estatus en blanco
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBAction func EnterButton(_ sender: Any) {
        logIn()
    }
    //metodo post para el logIn
    func logIn(){
        guard let mail:String = mailTextField.text else {
           return
        }
        guard let pass:String = passwordTextField.text else{
            return
        }
         let service = Service()
        service.postLogIn(user: LoginData(email: mail, password: pass))
        service.loginCompletitionHandler{ [weak self](auth,status,message) in
            if status{
                 let VC = ContainerController()
                       VC.modalPresentationStyle = .fullScreen
                self!.present(VC, animated: true, completion: nil)
                
            }else{
                let alert = UIAlertController(title: "Usuario y contraseña Incorrectos", message: "Intente de nuevo", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self!.present(alert, animated: true)
            }
            
        }
        let VC = ContainerController()
                              VC.modalPresentationStyle = .fullScreen
                       self.present(VC, animated: true, completion: nil)
       
    }

}


