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
    var selectefLeisure: Bool = false
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
        if selectefLeisure == false {
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
    
    func changeStateButtons(islandName: String, selected: Bool) {
        switch islandName {
        case "mindfulness":
            if selected == true {
                selectedMindfulness = true
                mindfulnessButton.setImage(UIImage(named: "botao_on_atencao_plena"), for: .normal)
                selectedCount += 1
                userDefaults.set(true, forKey: UserDefaultsKeys.selectedMindfulness)
            } else {
                selectedMindfulness = false
                mindfulnessButton.setImage(UIImage(named: "botao_atencao_plena"), for: .normal)
                selectedCount -= 1
                userDefaults.set(false, forKey: UserDefaultsKeys.selectedMindfulness)
            }
        case "loveds":
            if selected == true {
                selectedLoveds = true
                lovedsButton.setImage(UIImage(named: "botao_on_pessoas_queridas"), for: .normal)
                selectedCount += 1
                userDefaults.set(true, forKey: UserDefaultsKeys.selectedLoveds)
            } else {
                selectedLoveds = false
                lovedsButton.setImage(UIImage(named: "botao_pessoas_queridas"), for: .normal)
                selectedCount -= 1
                userDefaults.set(false, forKey: UserDefaultsKeys.selectedLoveds)
            }
        case "leisure":
            if selected == true {
                selectefLeisure = true
                leisureButton.setImage(UIImage(named: "botao_on_lazer"), for: .normal)
                selectedCount += 1
                userDefaults.set(true, forKey: UserDefaultsKeys.selectedLeisure)
            } else {
                selectefLeisure = false
                leisureButton.setImage(UIImage(named: "botao_lazer"), for: .normal)
                selectedCount -= 1
                userDefaults.set(false, forKey: UserDefaultsKeys.selectedLeisure)
            }
        default: // "health"
            if selected == true {
                selectedHealth = true
                healthButton.setImage(UIImage(named: "botao_on_saude"), for: .normal)
                selectedCount += 1
                userDefaults.set(true, forKey: UserDefaultsKeys.selectedHealth)
            } else {
                selectedHealth = false
                healthButton.setImage(UIImage(named: "botao_saude"), for: .normal)
                selectedCount -= 1
                userDefaults.set(false, forKey: UserDefaultsKeys.selectedHealth)
            }
        }
    }
}
