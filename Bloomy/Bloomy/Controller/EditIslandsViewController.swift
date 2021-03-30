//
//  EditIslandsViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 07/01/21.
//

import UIKit

class EditIslandsViewController: UIViewController {
    
    @IBOutlet weak var mindfulnessButton: UIButton!
    @IBOutlet weak var lovedsButton: UIButton!
    @IBOutlet weak var leisureButton: UIButton!
    @IBOutlet weak var healthButton: UIButton!
    var selectedMindfulness: Bool = false
    var selectedLoveds: Bool = false
    var selectedLeisure: Bool = false
    var selectedHealth: Bool = false
    var selectedCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Editar ilhas"
        self.configureSelectedIslandButtons()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Salva no User Default a quantidade de ilhas selecionadas
        userDefaults.set(selectedCount, forKey: UserDefaultsKeys.quantityIslands)
        
        userDefaults.set(true, forKey: UserDefaultsKeys.islandsChange)
    }
    
    @IBAction func tappedMindfulnessButton(_ sender: Any) {
        if selectedMindfulness == false {
            changeStateButtons(islandName: "mindfulness", selected: true)
        } else {
            changeStateButtons(islandName: "mindfulness", selected: false)
        }
    }
    
    @IBAction func tappedLovedsButton(_ sender: Any) {
        if selectedLoveds == false {
            changeStateButtons(islandName: "loveds", selected: true)
        } else {
            changeStateButtons(islandName: "loveds", selected: false)
        }
    }
    
    @IBAction func tappedLeisureButton(_ sender: Any) {
        if selectedLeisure == false {
            changeStateButtons(islandName: "leisure", selected: true)
        } else {
            changeStateButtons(islandName: "leisure", selected: false)
        }
    }
    
    @IBAction func tappedHealthButton(_ sender: Any) {
        if selectedHealth == false {
            changeStateButtons(islandName: "health", selected: true)
        } else {
            changeStateButtons(islandName: "health", selected: false)
        }
    }
    
    func configureSelectedIslandButtons() {
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedMindfulness) == true {
            changeStateButtons(islandName: "mindfulness", selected: true)
        }
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedLoveds) == true {
            changeStateButtons(islandName: "loveds", selected: true)
        }
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedLeisure) == true {
            changeStateButtons(islandName: "leisure", selected: true)
        }
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedHealth) == true {
            changeStateButtons(islandName: "health", selected: true)
        }
    }
    
    // MARK: - State Buttons status
    
    func changeStateButtons(islandName: String, selected: Bool) {
        switch islandName {
        case "mindfulness":
            if selected == true {
                self.setMindfulnessStatus(to: true)
            } else {
                self.setMindfulnessStatus(to: false)
            }
        case "loveds":
            if selected == true {
                self.setLovedsStatus(to: true)
            } else {
                self.setLovedsStatus(to: false)
            }
        case "leisure":
            if selected == true {
                self.setLeisureStatus(to: true)
            } else {
                self.setLeisureStatus(to: false)
            }
        case "health":
            if selected == true {
                self.setHealthStatus(to: true)
            } else {
                self.setHealthStatus(to: false)
            }
        default:
            fatalError("Could not find Island \(islandName)")
        }
    }
    
    private func setMindfulnessStatus(to status: Bool) {
        selectedMindfulness = status
        selectedCount += 1
        userDefaults.set(status, forKey: UserDefaultsKeys.selectedMindfulness)
        if (status) {
            mindfulnessButton.setImage(UIImage(named: "botao_on_atencao_plena"), for: .normal)
        } else {
            mindfulnessButton.setImage(UIImage(named: "botao_atencao_plena"), for: .normal)
        }
    }
    
    private func setLovedsStatus(to status: Bool) {
        selectedLoveds = status
        userDefaults.set(status, forKey: UserDefaultsKeys.selectedLoveds)
        if (status) {
            selectedCount += 1
            lovedsButton.setImage(UIImage(named: "botao_on_pessoas_queridas"), for: .normal)
        } else {
            selectedCount -= 1
            lovedsButton.setImage(UIImage(named: "botao_pessoas_queridas"), for: .normal)
        }
    }
    
    private func setLeisureStatus(to status: Bool) {
        selectedLeisure = status
        userDefaults.set(status, forKey: UserDefaultsKeys.selectedLeisure)
        if (status) {
            selectedCount += 1
            leisureButton.setImage(UIImage(named: "botao_on_lazer"), for: .normal)
        } else {
            selectedCount -= 1
            leisureButton.setImage(UIImage(named: "botao_lazer"), for: .normal)
        }
    }
    
    private func setHealthStatus(to status: Bool) {
        selectedHealth = status
        userDefaults.set(status, forKey: UserDefaultsKeys.selectedHealth)
        if (status) {
            selectedCount += 1
            healthButton.setImage(UIImage(named: "botao_on_saude"), for: .normal)
        } else {
            selectedCount -= 1
            healthButton.setImage(UIImage(named: "botao_saude"), for: .normal)
        }
    }
}
