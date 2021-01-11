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
    private var quantityIslands: Int?
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "background")

        self.quantityIslands = islands!.count
        setUpIslandsDisplay(quantityIslands: self.quantityIslands!)
        
        //Escolher os challenges depois do onboarding
        if (userManager.getLastSeen() == nil) {
            setDailyChallenges()
        }
        //Observa se já carregou os challenges para aquele dia
        if (!isSameDay(userDate: userManager.getLastSeen() ?? Date(), actualDate: Date())) {
            setDailyChallenges()
        }
        //Atualiza o último visto do usuário para data atual do sistema
        _ = userManager.updateLastSeen(to: Date())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Esconde a navigation bar de todas as telas
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Inicia a animação das nuvens
        self.moveCloudsToRight()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Mostra a navigation bar de todas as telas
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Para a animação das nuvens
        self.stopAnimation = true
    }
    
    func isSameDay(userDate: Date, actualDate: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: userDate, to: actualDate)
        
        if diff.day == 0 {
            return true
        }
    
        return false
    }
    
    func randomNumber(maximum: Int) -> Int {
        let randomInt = Int.random(in: 0..<maximum)
        return randomInt
    }
    
    /// Muda o status de done para os desafios que foram aceitos mas não foram concluídos
    /// - Parameter withName: String com o nome da ilha
    /// - Returns: Bool que indica se alguma ilha mudou o status
    func refreshDoneStatus(forIsland withName: String) -> Bool {
        var thereIsUndoneChallenge = false
        guard let islandChallenges = IslandManager.shared.getChallenges(fromIsland: withName) else { return false}
        for challenge in islandChallenges where challenge.accepted && !challenge.done {
            thereIsUndoneChallenge = true
            challenge.accepted = false
        }
        return thereIsUndoneChallenge
    }
    
    func setDailyChallenges() {
        //Coleta as ilhas do usuário
        guard let userIslands = userManager.getIslands() else {
            fatalError("Usuário não tem ilhas associadas")
        }
        
        //Seleciona algum challenge que ainda não foi aceito
        for island in userIslands {
            guard let islandChallenges = islandsManager.getChallenges(fromIsland: island.name ?? "") else { return }
            if let availableChallenge = searchForAvailableChallenge(inChallenges: islandChallenges) {
                _ = islandsManager.updateDailyChallenge(forIsland: island.name ?? "", toChallenge: availableChallenge)
            } else if (refreshDoneStatus(forIsland: island.name ?? "")) {
                setDailyChallenges()
            } else {
                let alert = UIAlertController(title: "Acabou missão para ilha \(String(island.name!))", message: "Parabéns! Você concluiu todas missões da ilha \(String(island.name!)). Como você está se sentindo?\n Em breve, teremos mais missões nessa ilha (:", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func searchForAvailableChallenge(inChallenges challenges: [Challenge]) -> Challenge? {
        var randomIndex = randomNumber(maximum: challenges.count)
        var challengesCount = challenges.count //Auxiliar para garantir saída do while
        
        while(challenges[randomIndex].accepted && challengesCount > 0) {
            challengesCount -= 1
            randomIndex = (randomIndex + 1) % challenges.count
        }
        
        if (!challenges[randomIndex].accepted) {
            return challenges[randomIndex]
        } else {
            return nil
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
        guard let islands = self.islands else {
            print("Nenhuma ilha foi selecionada")
            return
        }
        for island in islands {
            switch island.name {
            case "Saúde":
                healthStackView.isHidden = false
                healthRightButton.isHidden = false
            case "Lazer":
                leisureStackView.isHidden = false
                leisureRightButton.isHidden = false
            case "Atenção Plena":
                mindfulnessStackView.isHidden = false
                mindfulnessRightButton.isHidden = false
            default:
                lovedsStackView.isHidden = false
                lovedsRightButton.isHidden = false
            }
        }
    }
    
    func setUpDisplayTwoIsland() {
        guard let islands = self.islands else {
            print("Nenhuma ilha foi selecionada")
            return
        }
        for island in islands {
            switch island.name {
            case "Saúde":
                healthStackView.isHidden = false
                healthRightButton.isHidden = false
            case "Lazer":
                leisureStackView.isHidden = false
                leisureRightButton.isHidden = false
            case "Atenção Plena":
                mindfulnessStackView.isHidden = false
                mindfulnessRightButton.isHidden = false
            default:
                lovedsStackView.isHidden = false
                lovedsRightButton.isHidden = false
            }
        }
    }
    
    func setUpDisplayThreeIsland() {
        guard let islands = self.islands else {
            print("Nenhuma ilha foi selecionada")
            return
        }
        let organizedIslands = self.organizeIslands(islands: islands)
        for index in 0..<3 {
            if index%2 == 0 {
                self.showIslandLeft(islands: organizedIslands, index: index)
            } else {
                self.showIslandRight(islands: organizedIslands, index: index)
            }
        }
    }
    
    func organizeIslands(islands: [Island]) -> [Island] {
        var organizedIslands: [Island] = []
        let islandsNames = [
            IslandsNames.health.rawValue,
            IslandsNames.leisure.rawValue,
            IslandsNames.mindfulness.rawValue,
            IslandsNames.loveds.rawValue
        ]
        
        for islandName in islandsNames {
            if let island = islandsManager.getIsland(withName: islandName) {
                organizedIslands.append(island)
            }
        }
        
        return organizedIslands
    }
    
    func showIslandLeft(islands: [Island], index: Int) {
        switch islands[index].name {
        case "Saúde":
            self.healthStackView.isHidden = false
            self.healthRightButton.isHidden = false
            self.healthLeftButton.isHidden = false
            self.healthLeftButton.isEnabled = false
            self.healthLeftButton.alpha = 0
        case "Lazer":
            self.leisureStackView.isHidden = false
            self.leisureRightButton.isHidden = false
            self.leisureLeftButton.isHidden = false
            self.leisureLeftButton.isEnabled = false
            self.leisureLeftButton.alpha = 0
        case "Atenção Plena":
            self.mindfulnessStackView.isHidden = false
            self.mindfulnessRightButton.isHidden = false
            self.mindfulnessLeftButton.isHidden = false
            self.mindfulnessLeftButton.isEnabled = false
            self.mindfulnessLeftButton.alpha = 0
        default:
            self.lovedsStackView.isHidden = false
            self.lovedsRightButton.isHidden = false
            self.lovedsLeftButton.isHidden = false
            self.lovedsLeftButton.isEnabled = false
            self.lovedsLeftButton.alpha = 0
        }
    }
    
    func showIslandRight(islands: [Island], index: Int) {
        switch islands[index].name {
        case "Saúde":
            self.healthStackView.isHidden = false
            self.healthRightButton.isHidden = false
            self.healthLeftButton.isHidden = false
            self.healthRightButton.isEnabled = false
            self.healthRightButton.alpha = 0
        case "Lazer":
            self.leisureStackView.isHidden = false
            self.leisureRightButton.isHidden = false
            self.leisureLeftButton.isHidden = false
            self.leisureRightButton.isEnabled = false
            self.leisureRightButton.alpha = 0
        case "Atenção Plena":
            self.mindfulnessStackView.isHidden = false
            self.mindfulnessRightButton.isHidden = false
            self.mindfulnessLeftButton.isHidden = false
            self.mindfulnessRightButton.isEnabled = false
            self.mindfulnessRightButton.alpha = 0
        default:
            self.lovedsStackView.isHidden = false
            self.lovedsRightButton.isHidden = false
            self.lovedsLeftButton.isHidden = false
            self.lovedsRightButton.isEnabled = false
            self.lovedsRightButton.alpha = 0
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
