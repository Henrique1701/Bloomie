//
//  ComoVaiViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 04/12/20.
//

import UIKit

class ComoVaiViewController: UIViewController {

    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18) ?? UIFont()]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        self.navigationController!.navigationBar.isHidden = false
    }
    
}
