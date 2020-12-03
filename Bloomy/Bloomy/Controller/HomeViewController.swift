//
//  HomeViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 19/11/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var fourthStackView: UIStackView!
    @IBOutlet weak var firstLeftButton: UIButton!
    @IBOutlet weak var firstRightButton: UIButton!
    @IBOutlet weak var secondLeftButton: UIButton!
    @IBOutlet weak var secondRightButton: UIButton!
    @IBOutlet weak var thirdLeftButton: UIButton!
    @IBOutlet weak var thirdRightButton: UIButton!
    @IBOutlet weak var fourthLeftButton: UIButton!
    @IBOutlet weak var fourthRightButton: UIButton!
    @IBOutlet weak var cloudsConstraint5: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint4: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint3: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint2: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint1: NSLayoutConstraint!
    @IBOutlet weak var cloudsConstraint6: NSLayoutConstraint!
    
    // MARK: Global Variables
    private let quantityIslands: Int = 4
    let userManager = UserManager.shared
    let islandsNames: [String] = ["Saúde", "Lazer", "Atenção Plena", "Pessoas Queridas"]
    var stopAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Pegar a quantidade de ilhas selecionadas pelo usuário
        setUpIslandsDisplay(quantityIslands: self.quantityIslands)
        SeedDataBase.shared.seed()
        if (!isSameDay(userDate: userManager.getLastSeen() ?? Date(), actualDate: Date())) {
            _ = userManager.updateLastSeen(to: Date())
            getDailyChallenges()
        }
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
    func getDailyChallenges() {
        var challenges: NSSet = NSSet()
        for island in islandsNames {
            guard let islandChallenges = IslandManager.shared.getChallenges(fromIsland: island) else { return } // TODO: arrumar o erro
            var randomInt = randomNumber(maximum: islandChallenges.count)
            var auxCount = islandChallenges.count
            while(!islandChallenges[randomInt].accepted && auxCount > 0) {
                auxCount -= 1
                randomInt = (randomInt + 1) % islandChallenges.count
            }
            
            if (!islandChallenges[randomInt].accepted) {
                let dailyChallenge = islandChallenges[randomInt]
                challenges = challenges.adding(dailyChallenge) as NSSet
            } else {
                refreshDoneStatus(forIsland: island)
                getDailyChallenges()
            }
        }
        _ = UserManager.shared.updateDailyChallenges(to: challenges)
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
        self.fourthStackView.isHidden = true
        self.thirdStackView.isHidden = true
        self.secondStackView.isHidden = true
        self.firstRightButton.isHidden = true
        // TODO: Definir qual a ilha será exibida
    }
    
    func setUpDisplayTwoIsland() {
        self.fourthStackView.isHidden = true
        self.thirdStackView.isHidden = true
        self.secondRightButton.isHidden = true
        self.firstRightButton.isHidden = true
        // TODO: Definir quais ilhas serão exibidas
    }
    
    func setUpDisplayThreeIsland() {
        self.fourthStackView.isHidden = true
        self.thirdRightButton.isEnabled = false
        self.thirdRightButton.alpha = 0
        self.secondLeftButton.isEnabled = false
        self.secondLeftButton.alpha = 0
        self.firstRightButton.isEnabled = false
        self.firstRightButton.alpha = 0
        // TODO: Definir quais ilhas serão exibidas
    }
    
    func setUpDisplayFourIsland() {
        self.fourthRightButton.isEnabled = false
        self.fourthRightButton.alpha = 0
        self.thirdLeftButton.isEnabled = false
        self.thirdLeftButton.alpha = 0
        self.secondRightButton.isEnabled = false
        self.secondRightButton.alpha = 0
        self.firstLeftButton.isEnabled = false
        self.firstLeftButton.alpha = 0
        // TODO: Definir a ordem das ilhas
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
