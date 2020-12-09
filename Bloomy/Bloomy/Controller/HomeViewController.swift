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
    private var quantityIslands: Int = 0
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pathToBGSound = Bundle.main.path(forResource: "background", ofType: "mp3")!
        let urlbg = URL(fileURLWithPath: pathToBGSound)
        do{
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: urlbg)
            backgroundAudioPlayer?.prepareToPlay()
            backgroundAudioPlayer?.numberOfLoops = -1
            backgroundAudioPlayer?.play()
        } catch let error as NSError {
            print(error.description)
        }
        
        quantityIslands = islands!.count
        setUpIslandsDisplay(quantityIslands: self.quantityIslands)
        
        if (userManager.getLastSeen() == nil) {
            setDailyChallenges()
        }
        if (!isSameDay(userDate: userManager.getLastSeen() ?? Date(), actualDate: Date())) {
            setDailyChallenges()
        }
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
    
    func refreshDoneStatus(forIsland withName: String) {
        guard let islandChallenges = IslandManager.shared.getChallenges(fromIsland: withName) else { return }
        for challenge in islandChallenges where challenge.accepted && !challenge.done {
            challenge.accepted = false
        }
    }
    
    //TODO: Caso esteja tudo terminado
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
            } else {
                refreshDoneStatus(forIsland: island.name ?? "")
                setDailyChallenges()

            }
        }
    }
    
    func searchForAvailableChallenge(inChallenges challenges: [Challenge]) -> Challenge? {
        var randomIndex = randomNumber(maximum: challenges.count)
        var challengesCount = challenges.count //Auxiliar para garantir saída do while
        
        while(!challenges[randomIndex].accepted && challengesCount > 0) {
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
        for islandPos in 0..<3 {
            if islandPos%2 == 0 {
                switch islands[islandPos].name {
                case "Saúde":
                    healthStackView.isHidden = false
                    healthRightButton.isHidden = false
                    healthLeftButton.isHidden = false
                    healthLeftButton.isEnabled = false
                    healthLeftButton.alpha = 0
                case "Lazer":
                    leisureStackView.isHidden = false
                    leisureRightButton.isHidden = false
                    leisureLeftButton.isHidden = false
                    leisureLeftButton.isEnabled = false
                    leisureLeftButton.alpha = 0
                case "Atenção Plena":
                    mindfulnessStackView.isHidden = false
                    mindfulnessRightButton.isHidden = false
                    mindfulnessLeftButton.isHidden = false
                    mindfulnessLeftButton.isEnabled = false
                    mindfulnessLeftButton.alpha = 0
                default:
                    lovedsStackView.isHidden = false
                    lovedsRightButton.isHidden = false
                    lovedsLeftButton.isHidden = false
                    lovedsLeftButton.isEnabled = false
                    lovedsLeftButton.alpha = 0
                }
            } else {
                switch islands[islandPos].name {
                case "Saúde":
                    healthStackView.isHidden = false
                    healthRightButton.isHidden = false
                    healthLeftButton.isHidden = false
                    healthRightButton.isEnabled = false
                    healthRightButton.alpha = 0
                case "Lazer":
                    leisureStackView.isHidden = false
                    leisureRightButton.isHidden = false
                    leisureLeftButton.isHidden = false
                    leisureRightButton.isEnabled = false
                    leisureRightButton.alpha = 0
                case "Atenção Plena":
                    mindfulnessStackView.isHidden = false
                    mindfulnessRightButton.isHidden = false
                    mindfulnessLeftButton.isHidden = false
                    mindfulnessRightButton.isEnabled = false
                    mindfulnessRightButton.alpha = 0
                default:
                    lovedsStackView.isHidden = false
                    lovedsRightButton.isHidden = false
                    lovedsLeftButton.isHidden = false
                    lovedsRightButton.isEnabled = false
                    lovedsRightButton.alpha = 0
                }
            }
        }
    }
    
    func setUpDisplayFourIsland() {
        healthStackView.isHidden = false
        healthLeftButton.isHidden = false
        healthRightButton.isHidden = false
        leisureStackView.isHidden = false
        leisureLeftButton.isHidden = false
        leisureRightButton.isHidden = false
        mindfulnessStackView.isHidden = false
        mindfulnessLeftButton.isHidden = false
        mindfulnessRightButton.isHidden = false
        lovedsStackView.isHidden = false
        lovedsLeftButton.isHidden = false
        lovedsRightButton.isHidden = false
        
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
}
