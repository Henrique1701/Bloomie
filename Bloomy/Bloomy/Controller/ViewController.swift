//
//  ViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 12/11/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let user = UserManager()
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var updateUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (user.getUser()?.name != nil) {
            userName.text = user.getUser()?.name
        } else {
            userName.text = "Tá sem usuário"
        }
    }
    @IBAction func saveUserButton(_ sender: Any) {
        if let name = userTextField.text {
            if (user.newUser(withName: name) != nil) {
                userName.text = user.getUser()?.name
            }
        } else {
            print("Sem nome")
        }
    }
    
    
    @IBAction func deleteUserButton(_ sender: Any) {
        if user.deleteUser(withName: userName.text!) {
            userName.text = "sem usuário"
        } else { return }
    }
        
    @IBAction func updateUserNameButton(_ sender: Any) {
        if let name = updateUserName.text {
            if  (user.updateUserName(name: name)) {
                userName.text = user.getUser()?.name
            } else {
                print("Não rolou")
            }
        } else {
            print("Sem nome para atualizar")
        }
    }
    
}
