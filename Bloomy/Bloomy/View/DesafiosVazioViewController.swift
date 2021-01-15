//
//  DesafiosVazioViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 14/01/21.
//

import UIKit

class DesafiosVazioViewController: UIViewController {

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
