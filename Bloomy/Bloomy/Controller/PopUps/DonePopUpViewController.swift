//
//  DonePopUpViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 07/12/20.
//

import UIKit

class DonePopUpViewController: UIViewController {
    var summary: String = ""
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func doneChallenge(_ sender: Any) {
        dismiss(animated: false)
        NotificationCenter.default.post(name: .doneChallenge, object: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.summaryLabel.text = summary
    }
    
    func setupStyle() {
        self.questionLabel.adjustsFontSizeToFitWidth = true
        self.summaryLabel.adjustsFontSizeToFitWidth = true
        self.doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.contentView.layer.cornerRadius = 35
    }
    
}
