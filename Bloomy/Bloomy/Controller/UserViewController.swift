//
//  UserViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 09/12/20.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet var healthButton: UIButton!
    @IBOutlet var leisureButton: UIButton!
    @IBOutlet var mindfulnessButton: UIButton!
    @IBOutlet var lovedsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userNameLabel.text = UserManager.shared.getUserName()
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
