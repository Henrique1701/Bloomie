//
//  HomeViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 19/11/20.
//

import UIKit
import AVFoundation

var backgroundAudioPlayer: AVAudioPlayer?
class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var healthStackView: UIStackView!
    @IBOutlet weak var leisureStackView: UIStackView!
    @IBOutlet weak var mindfulnessStackView: UIStackView!
    @IBOutlet weak var lovedsStackView: UIStackView!
    @IBOutlet weak var healthLeftButton: UIButton!
    @IBOutlet weak var healthRightButton: UIButton!
    @IBOutlet weak var leisureLeftButton: UIButton!
    @IBOutlet weak var leisureRightButton: UIButton!
    @IBOutlet weak var mindfulnessLeftButton: UIButton!
    @IBOutlet weak var mindfulnessRightButton: UIButton!
    @IBOutlet weak var lovedsLeftButton: UIButton!
    @IBOutlet weak var lovedsRightButton: UIButton!
    @IBOutlet weak var cloudsConstraint5: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint4: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint3: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint2: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint1: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint6: NSLayoutConstraint!
    
    // MARK: Global Variables
    let userManager = UserManager.shared
    let islandsManager = IslandManager.shared
    var stopAnimation = false
    let islands = UserManager.shared.getIslands()
    var quantityIslands: Int = 4
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "background")
        
        quantityIslands = userDefaults.integer(forKey: UserDefaultsKeys.quantityIslands)
        setUpIslandsDisplay(quantityIslands: self.quantityIslands)
        
        //Observa se já carregou os challenges para aquele dia
        if (!isSameDay(firstDate: userManager.getLastSeen() ?? Date(), secondDate: Date())) {
            self.daysOfUserActivation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Esconde a navigation bar de todas as telas
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Inicia a animação das nuvens
        self.moveCloudsToRight()
        
        if userDefaults.bool(forKey: UserDefaultsKeys.islandsChange) {
            userDefaults.set(false, forKey: UserDefaultsKeys.islandsChange)
            self.updateIslandsView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Mostra a navigation bar de todas as telas
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Para a animação das nuvens
        self.stopAnimation = true
    }

    private func daysOfUserActivation() {
        var daysOfUserActivation = userDefaults.integer(forKey: UserDefaultsKeys.userDaysOfActivation)
        daysOfUserActivation += 1
        userDefaults.set(daysOfUserActivation, forKey: UserDefaultsKeys.userDaysOfActivation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? IslandsViewController
        
        if segue.identifier == "homeToHealth" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.health.rawValue)!
            destination?.sceneName = "HealthIsland"
        } else if segue.identifier == "homeToLeisure" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue)!
            destination?.sceneName = "LeisureIsland"
        } else if segue.identifier == "homeToMindfulness" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue)!
            destination?.sceneName = "MindfulnessIsland"
        } else if segue.identifier == "homeToLoveds" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue)!
            destination?.sceneName = "LovedsIsland"
        }
    }
}

// MARK: Configura a animação das nuvens
extension HomeViewController {
    /// Configura a animação das nuvens
    ///
    /// Move a posição de todas as nuvens em +20 pontos
    func moveCloudsToRight() {
        if stopAnimation {
            self.stopAnimation = false
            return
        }
        self.cloudsConstraint5.constant += 20
        self.cloudsConstraint4.constant += 20
        self.cloudsConstraint3.constant += 20
        self.cloudsConstraint2.constant += 20
        self.cloudsConstraint1.constant += 20
        self.cloudsConstraint6.constant += 20
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.moveCloudsToLeft()
        })
    }
    
    /// Move a posição de todas as nuvens em -20 pontos
    func moveCloudsToLeft() {
        if stopAnimation {
            self.stopAnimation = false
            return
        }
        self.cloudsConstraint5.constant -= 20
        self.cloudsConstraint4.constant -= 20
        self.cloudsConstraint3.constant -= 20
        self.cloudsConstraint2.constant -= 20
        self.cloudsConstraint1.constant -= 20
        self.cloudsConstraint6.constant -= 20
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.moveCloudsToRight()
        })
    }
}

// MARK: Configura os botões das ilhas
extension HomeViewController {
    @objc func updateIslandsView() {
        DispatchQueue.main.async {
            self.hideIsland()
            self.enableIslandButtons()
            self.quantityIslands = userDefaults.integer(forKey: UserDefaultsKeys.quantityIslands)
            self.setUpIslandsDisplay(quantityIslands: self.quantityIslands)
        }
    }
    
    func setUpIslandsDisplay(quantityIslands: Int) {
        switch quantityIslands {
        case 1:
            self.setUpDisplayOneIsland()
        case 2:
            self.setUpDisplayTwoIsland()
        case 3:
            self.setUpDisplayThreeIsland()
        case 4:
            self.setUpDisplayFourIsland()
        default:
            return
        }
    }
    
    func setUpDisplayOneIsland() {
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedMindfulness) {
            mindfulnessStackView.isHidden = false
            mindfulnessRightButton.isHidden = false
        } else if userDefaults.bool(forKey: UserDefaultsKeys.selectedLeisure) {
            leisureStackView.isHidden = false
            leisureRightButton.isHidden = false
        } else if userDefaults.bool(forKey: UserDefaultsKeys.selectedHealth) {
            healthStackView.isHidden = false
            healthRightButton.isHidden = false
        } else if userDefaults.bool(forKey: UserDefaultsKeys.selectedLoveds) {
            lovedsStackView.isHidden = false
            lovedsRightButton.isHidden = false
        } else {
            print("Nenhuma ilha foi selecionada")
        }
        
    }
    
    func setUpDisplayTwoIsland() {
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedMindfulness) {
            mindfulnessStackView.isHidden = false
            mindfulnessRightButton.isHidden = false
        }
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedLeisure) {
            leisureStackView.isHidden = false
            leisureRightButton.isHidden = false
        }
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedHealth) {
            healthStackView.isHidden = false
            healthRightButton.isHidden = false
        }
        if userDefaults.bool(forKey: UserDefaultsKeys.selectedLoveds) {
            lovedsStackView.isHidden = false
            lovedsRightButton.isHidden = false
        }
    }
    
    func setUpDisplayThreeIsland() {
        var selectedMindfulness = userDefaults.bool(forKey: UserDefaultsKeys.selectedMindfulness)
        var selectedLoveds = userDefaults.bool(forKey: UserDefaultsKeys.selectedLoveds)
        var selectedLeisure = userDefaults.bool(forKey: UserDefaultsKeys.selectedLeisure)
        var selectedHealth = userDefaults.bool(forKey: UserDefaultsKeys.selectedHealth)
        
        for index in 1...3 {
            if index%2 == 0 {
                if selectedHealth {
                    selectedHealth = false
                    self.showIslandRight(island: "health")
                } else if selectedLeisure {
                    selectedLeisure = false
                    self.showIslandRight(island: "leisure")
                } else if selectedMindfulness {
                    selectedMindfulness = false
                    self.showIslandRight(island: "mindfulness")
                } else if selectedLoveds {
                    selectedLoveds = false
                    self.showIslandRight(island: "loveds")
                }
            } else {
                if selectedHealth {
                    selectedHealth = false
                    self.showIslandLeft(island: "health")
                } else if selectedLeisure {
                    selectedLeisure = false
                    self.showIslandLeft(island: "leisure")
                } else if selectedMindfulness {
                    selectedMindfulness = false
                    self.showIslandLeft(island: "mindfulness")
                } else if selectedLoveds {
                    selectedLoveds = false
                    self.showIslandLeft(island: "loveds")
                }
            }
        }
    }
    
    func setUpDisplayFourIsland() {
        self.healthStackView.isHidden = false
        self.healthLeftButton.isHidden = false
        self.healthRightButton.isHidden = false
        self.leisureStackView.isHidden = false
        self.leisureLeftButton.isHidden = false
        self.leisureRightButton.isHidden = false
        self.mindfulnessStackView.isHidden = false
        self.mindfulnessLeftButton.isHidden = false
        self.mindfulnessRightButton.isHidden = false
        self.lovedsStackView.isHidden = false
        self.lovedsLeftButton.isHidden = false
        self.lovedsRightButton.isHidden = false
        
        self.lovedsRightButton.isEnabled = false
        self.lovedsRightButton.alpha = 0
        self.mindfulnessLeftButton.isEnabled = false
        self.mindfulnessLeftButton.alpha = 0
        self.leisureRightButton.isEnabled = false
        self.leisureRightButton.alpha = 0
        self.healthLeftButton.isEnabled = false
        self.healthLeftButton.alpha = 0
    }
    
    func showIslandLeft(island: String) {
        switch island {
        case "health":
            self.healthStackView.isHidden = false
            self.healthRightButton.isHidden = false
            self.healthLeftButton.isHidden = false
            self.healthLeftButton.isEnabled = false
            self.healthLeftButton.alpha = 0
        case "leisure":
            self.leisureStackView.isHidden = false
            self.leisureRightButton.isHidden = false
            self.leisureLeftButton.isHidden = false
            self.leisureLeftButton.isEnabled = false
            self.leisureLeftButton.alpha = 0
        case "mindfulness":
            self.mindfulnessStackView.isHidden = false
            self.mindfulnessRightButton.isHidden = false
            self.mindfulnessLeftButton.isHidden = false
            self.mindfulnessLeftButton.isEnabled = false
            self.mindfulnessLeftButton.alpha = 0
        case "loveds":
            self.lovedsStackView.isHidden = false
            self.lovedsRightButton.isHidden = false
            self.lovedsLeftButton.isHidden = false
            self.lovedsLeftButton.isEnabled = false
            self.lovedsLeftButton.alpha = 0
        default:
            fatalError("Caso não existente")
        }
    }
    
    func showIslandRight(island: String) {
        switch island {
        case "health":
            self.healthStackView.isHidden = false
            self.healthRightButton.isHidden = false
            self.healthLeftButton.isHidden = false
            self.healthRightButton.isEnabled = false
            self.healthRightButton.alpha = 0
        case "leisure":
            self.leisureStackView.isHidden = false
            self.leisureRightButton.isHidden = false
            self.leisureLeftButton.isHidden = false
            self.leisureRightButton.isEnabled = false
            self.leisureRightButton.alpha = 0
        case "mindfulness":
            self.mindfulnessStackView.isHidden = false
            self.mindfulnessRightButton.isHidden = false
            self.mindfulnessLeftButton.isHidden = false
            self.mindfulnessRightButton.isEnabled = false
            self.mindfulnessRightButton.alpha = 0
        case "loveds":
            self.lovedsStackView.isHidden = false
            self.lovedsRightButton.isHidden = false
            self.lovedsLeftButton.isHidden = false
            self.lovedsRightButton.isEnabled = false
            self.lovedsRightButton.alpha = 0
        default:
            fatalError("Caso não existente")
        }
    }
    
    func hideIsland() {
        self.healthStackView.isHidden = true
        self.healthLeftButton.isHidden = true
        self.healthRightButton.isHidden = true
        self.mindfulnessStackView.isHidden = true
        self.mindfulnessLeftButton.isHidden = true
        self.mindfulnessRightButton.isHidden = true
        self.lovedsStackView.isHidden = true
        self.lovedsLeftButton.isHidden = true
        self.lovedsRightButton.isHidden = true
        self.leisureStackView.isHidden = true
        self.leisureLeftButton.isHidden = true
        self.leisureRightButton.isHidden = true
    }
    
    func enableIslandButtons() {
        self.healthLeftButton.isEnabled = true
        self.healthLeftButton.alpha = 1
        self.healthRightButton.isEnabled = true
        self.healthRightButton.alpha = 1
        self.mindfulnessLeftButton.isEnabled = true
        self.mindfulnessLeftButton.alpha = 1
        self.mindfulnessRightButton.isEnabled = true
        self.mindfulnessRightButton.alpha = 1
        self.lovedsLeftButton.isEnabled = true
        self.lovedsLeftButton.alpha = 1
        self.lovedsRightButton.isEnabled = true
        self.lovedsRightButton.alpha = 1
        self.leisureLeftButton.isEnabled = true
        self.leisureLeftButton.alpha = 1
        self.leisureRightButton.isEnabled = true
        self.leisureRightButton.alpha = 1
    }
}
