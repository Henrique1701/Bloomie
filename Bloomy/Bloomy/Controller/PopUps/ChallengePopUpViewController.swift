//
//  ChallengePopUpViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 03/12/20.
//

import UIKit

class ChallengePopUpViewController: UIViewController {
    var summary: String = ""
    var islandName: String = ""
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.summaryLabel.text = summary
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func accept(_ sender: Any) {
        NotificationCenter.default.post(name: .acceptChallenge, object: self)
        getDateWasAccepted()
        dismiss(animated: true)
    }
    
    func configureIslandName() {
        let islandsNamesPT = ["Atenção Plena", "Saúde", "Pessoas Queridas", "Lazer"]
        let islandsNames = ["Mindfulness", "Health", "Loveds", "Leisure"]
        for index in 0..<islandsNamesPT.count where
            islandsNamesPT[index] == self.islandName {
            self.islandName = islandsNames[index]
        }
    }
    
    func getDateWasAccepted() {
        configureIslandName()
        let dateWasAccepted = Date()
        UserDefaults.standard.setValue(dateWasAccepted, forKey: UserDefaultsKeys.dateWasAccepted+"\(islandName)")
    }
    
    func setupStyle() {
        self.acceptButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.contentView.layer.cornerRadius = 35
        self.summaryLabel.adjustsFontSizeToFitWidth = true
    }

}
