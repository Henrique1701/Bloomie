//
//  ComoSeChamaViewController.swift
//  Bloomy
//
//  Created by Alexandra Zarzar on 30/11/20.
//

import UIKit

class ComoSeChamaViewController: UIViewController {

    @IBOutlet weak var nomeUsuarioTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Passa o nome do usuario para o próximo View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AreasSegue", case let nextVC = segue.destination as? AreasViewController {
            nextVC?.nomeUsuario = nomeUsuarioTextField.text
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
