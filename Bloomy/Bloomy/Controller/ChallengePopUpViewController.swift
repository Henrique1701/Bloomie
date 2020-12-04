//
//  ChallengePopUpViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 03/12/20.
//

import UIKit

class ChallengePopUpViewController: UIViewController {
    var summary: String = ""
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func accept(_ sender: Any) {
        NotificationCenter.default.post(name: .acceptChallenge, object: self)
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.summaryLabel.text = summary
    }
    
    func setupStyle() {
        self.acceptButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.contentView.layer.cornerRadius = 35
        self.summaryLabel.adjustsFontSizeToFitWidth = true
    }

}
