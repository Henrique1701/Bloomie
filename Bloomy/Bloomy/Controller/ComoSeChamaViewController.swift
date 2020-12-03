//
//  ComoSeChamaViewController.swift
//  Bloomy
//
//  Created by Alexandra Zarzar on 30/11/20.
//

import UIKit

class ComoSeChamaViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nomeUsuarioTextField: UITextField!
    @IBOutlet weak var continuarButton: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tapGesture para clicar fora do teclado
        configureTapGesture()
        
        //Delegate para o botao de Retorno ocultar o teclado
        self.nomeUsuarioTextField.delegate = self
        
        //Desativar o botão de Continuar se o textField estiver vazio
        continuarButton.isEnabled = false
        continuarButton.alpha = 0.5
    }
    
    //Passa o nome do usuario para o próximo View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AreasSegue", case let nextVC = segue.destination as? AreasViewController {
            nextVC?.nomeUsuario = nomeUsuarioTextField.text
        }
    }

}
