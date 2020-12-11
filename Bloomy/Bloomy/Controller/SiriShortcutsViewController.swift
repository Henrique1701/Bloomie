//
//  SiriShortcutsViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 10/12/20.
//

import UIKit
import IntentsUI

class SiriShortcutsViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Atalhos da Siri"
        self.setupNavigationController()
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
        
        if #available(iOS 12.0, *) {
            let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
                button.shortcut = INShortcut(intent: intent )
                button.delegate = self
                button.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(button)
                view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
                view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
                
            }
    }
    
//    func addSiriButton(to view: UIView) {
//    if #available(iOS 12.0, *) {
//        let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
//            button.shortcut = INShortcut(intent: intent )
//            button.delegate = self
//            button.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(button)
//            view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
//            view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
//        }
//    
//    }
    
    func showMessage() {
        let alert = UIAlertController(title: "Done!", message: "This is your first shortcut action!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

 extension SiriShortcutsViewController {
    @available(iOS 12.0, *)
    public var intent: DoSomethingIntent {
        let testIntent = DoSomethingIntent()
        testIntent.suggestedInvocationPhrase = "Test command"
        return testIntent
    }
}

extension SiriShortcutsViewController: INUIAddVoiceShortcutButtonDelegate {
    @available(iOS 12.0, *)
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
    
}

extension SiriShortcutsViewController: INUIAddVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

extension SiriShortcutsViewController: INUIEditVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
