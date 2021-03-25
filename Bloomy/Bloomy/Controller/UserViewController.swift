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
    @IBOutlet weak var stackView: UIStackView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userNameLabel.text = UserManager.shared.getUserName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.buttonsToShow()
        self.organizePositionButtons()
    }
    
    func showAlert(islandName: String) {
        let alert = UIAlertController(title: "", message: "Tente ir em 'Editar ilhas' que fica nas configurações e selecionar a ilha de \(islandName)", preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "fechar", style: .default) { _ in }
        alert.addAction(closeButton)
        present(alert, animated: true, completion: nil)
    }
    
    func showJourney(islandName: String) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Journey", bundle: nil)
        let destination = storyboard.instantiateInitialViewController() as! JourneyCollectionViewController
        destination.island = IslandManager.shared.getIsland(withName: islandName)!
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    @IBAction func touchedHealthButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedHealth") {
            showJourney(islandName: IslandsNames.health.rawValue)
        } else {
            showAlert(islandName: "saúde")
        }
    }
    
    @IBAction func touchedLeisureButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedLeisure") {
            showJourney(islandName: IslandsNames.leisure.rawValue)
        } else {
            showAlert(islandName: "lazer")
        }
    }
    
    @IBAction func touchedMindfulnessButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedMindfulness") {
            showJourney(islandName: IslandsNames.mindfulness.rawValue)
        } else {
            showAlert(islandName: "atenção plena")
        }
    }
    
    @IBAction func touchedLovedButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedLoveds") {
            showJourney(islandName: IslandsNames.loveds.rawValue)
        } else {
            showAlert(islandName: "pessoas queridas")
        }
    }
    
    func buttonsToShow() {
        if (defaults.bool(forKey: "selectedHealth")) {
            self.healthButton.alpha = 1
        } else {
            self.healthButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedLeisure")) {
            self.leisureButton.alpha = 1
        } else {
            self.leisureButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedMindfulness")) {
            self.mindfulnessButton.alpha = 1
        } else {
            self.mindfulnessButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedLoveds")) {
            self.lovedsButton.alpha = 1
        } else {
            self.lovedsButton.alpha = 0.6
        }
    }
    
    func organizePositionButtons() {
        var buttons = stackView.arrangedSubviews
        var index = 0
        var control = 0
        while(index < buttons.count) {
            if buttons[index].alpha != 1 {
                let viewRemove = self.stackView.arrangedSubviews[index]
                self.stackView.removeArrangedSubview(viewRemove)
                self.stackView.addArrangedSubview(viewRemove)
                buttons = stackView.arrangedSubviews
            } else {
                index += 1
            }
            if control == buttons.count-1 {
                index = buttons.count
            } else {
                control += 1
            }
        }
    }
}
