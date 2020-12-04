//
//  ComoSeChamaViewController.swift
//  Bloomy
//
//  Created by Alexandra Zarzar on 30/11/20.
//

import UIKit
import CoreData

class ComoSeChamaViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nomeUsuarioTextField: UITextField!
    @IBOutlet weak var continuarButton: UIButton!
    //Gerenciador das funções CRUD de Usuário
    let user = UserManager()
    var nomeUsuario:String?
    
    // MARK: Dismiss keyboard
    //tapGesture para ocultar o teclado ao clicar fora dele
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ComoSeChamaViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    //Ocultar o teclado ao tocar no botão Retorno
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: Deactivate button if textfield is empty
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (nomeUsuarioTextField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty {
            continuarButton.isEnabled = false
            continuarButton.alpha = 0.5
        } else {
            continuarButton.isEnabled = true
            continuarButton.alpha = 1.0
        }
        return true
    }
    
    // MARK: Create user on Core Data
    @IBAction func salvarUsuario(_ sender: Any) {
        nomeUsuario = nomeUsuarioTextField.text
        if (self.user.getUser() != nil) {
            user.updateUserName(to: nomeUsuario!)
        } else{
            user.newUser(withName: nomeUsuario!)
        }
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18) ?? UIFont()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tapGesture para clicar fora do teclado
        configureTapGesture()
        
        //Delegate para o botao de Retorno ocultar o teclado
        self.nomeUsuarioTextField.delegate = self
                
        //Desativar o botão de Continuar se o textField estiver vazio
        continuarButton.isEnabled = false
        continuarButton.alpha = 0.5
        
        //Modificar a navigation Bar
        setupNavigationController()
    }

}
