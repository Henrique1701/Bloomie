//
//  JornadaVaziaViewController.swift
//  Bloomie
//
//  Created by Mayara Mendonça de Souza on 15/03/21.
//

import UIKit

class JornadaVazia: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    // MARK: Navigation Bar
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
}
