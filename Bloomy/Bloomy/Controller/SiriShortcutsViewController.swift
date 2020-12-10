//
//  SiriShortcutsViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 10/12/20.
//

import UIKit

class SiriShortcutsViewController: UIViewController {

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
    }

}
