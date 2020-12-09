//
//  LeisureViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 01/12/20.
//

import UIKit
import SpriteKit
import GameplayKit

class LeisureViewController: UIViewController {
    @IBOutlet weak var challengeDayButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    let island = IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue)!
    var challengeObserver: NSObjectProtocol?
    var doneObserver: NSObjectProtocol?
    let scene = SKScene(fileNamed: "LeisureIsland")
    var animationObserver: NSObjectProtocol?
    var rewardIdToAnimate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupStyle()
        self.setupSKScene()
        self.chooseButtonToShow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        challengeObserver = NotificationCenter.default.addObserver(forName: .acceptChallenge, object: nil, queue: OperationQueue.main) { (notification) in
            self.acceptChallenge()
        }
        
        doneObserver = NotificationCenter.default.addObserver(forName: .doneChallenge, object: nil, queue: OperationQueue.main) { (notification) in
            self.doneChallenge()
            self.chooseButtonToShow()
            self.showRewardPopUp()
            self.loadViewIfNeeded()
        }
        
        // Espera uma notificação para ativar animação da recompensa
        animationObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "animationObserver"), object: nil, queue: OperationQueue.main) { _ in
            self.rewardAnimation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if challengeObserver != nil {
            NotificationCenter.default.removeObserver(challengeObserver!)
        }
        
        if doneObserver != nil {
            NotificationCenter.default.removeObserver(doneObserver!)
        }
        
        if animationObserver != nil {
            NotificationCenter.default.removeObserver(animationObserver!)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChallengePopUpViewControllerSegue" {
            let popup = segue.destination as! ChallengePopUpViewController
            popup.summary = island.dailyChallenge?.summary ?? ""
        } else if (segue.identifier == "toDonePopUpViewControllerSegue") {
            let popup = segue.destination as! DonePopUpViewController
            popup.summary = island.dailyChallenge?.summary ?? ""
        }
    }
    
    func acceptChallenge() {
        self.island.dailyChallenge?.accepted = true
        _ = IslandManager.shared.saveContext()
        self.chooseButtonToShow()
        self.loadViewIfNeeded()
    }
    
    func doneChallenge() {
        self.island.dailyChallenge?.done = true
        _ = IslandManager.shared.saveContext()
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
    }
    
    func setupSKScene() {
        let islandView = SKView(frame: CGRect(x: self.view.center.x-(366/2), y: self.view.center.y-(364/2), width: 366, height: 364))
        islandView.backgroundColor = .black
        self.view.addSubview(islandView)
        
        if let view = islandView as SKView? {
            scene!.scaleMode = .aspectFill
            self.showRewards()
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }
    
    func setupStyle() {
        self.title = IslandsNames.leisure.rawValue
        // Ajusta o tamaho do titulo do botão
        self.challengeDayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // Configura a navigation controller
        setupNavigationController()
    }
    
    func chooseButtonToShow() {
        if (!(self.island.dailyChallenge?.accepted)!) {
            //se o desafio não foi aceito
            self.doneButton.isHidden = true
            self.challengeDayButton.isHidden = false
            self.challengeDayButton.isEnabled = true
            self.challengeDayButton.alpha = 1
        } else if ((self.island.dailyChallenge?.accepted)! && !(self.island.dailyChallenge?.done)!) {
            //se o desafio foi aceito mas n foi concluído
            self.challengeDayButton.isHidden = true
            self.doneButton.isHidden = false
        } else {
            //desafio aceito e concluído
            self.challengeDayButton.isHidden = false
            self.challengeDayButton.alpha = 0.5
            self.challengeDayButton.isEnabled = false
            self.doneButton.isHidden = true
        }
    }
    
    func showRewardPopUp() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PopUps", bundle: nil)
        let popup = storyBoard.instantiateViewController(identifier: "RewardPopUp") as! RewardPopUpViewController
        let rewards = IslandManager.shared.getRewards(fromIsland: island.name!)!
        if let availableReward = getAvailableReward(inRewards: rewards) {
            popup.rewardImage = UIImage(named: "\(availableReward.id!)")
            popup.modalTransitionStyle = .crossDissolve
            popup.modalPresentationStyle = .overCurrentContext
            self.rewardIdToAnimate = availableReward.id!
            self.present(popup, animated: true)
            availableReward.isShown = true
            _ = RewardManager.shared.saveContext()
        } else {
            fatalError("There is no available reward")
        }
    }
    
    func randomNumber(maximum: Int) -> Int {
        let randomInt = Int.random(in: 0..<maximum)
        return randomInt
    }
    
    func getAvailableReward(inRewards rewards: [Reward]) -> Reward? {
        var randomIndex = randomNumber(maximum: rewards.count)
        var rewardsCount = rewards.count //Auxiliar para garantir saída do while
        
        while(rewards[randomIndex].isShown && rewardsCount > 0) {
            rewardsCount -= 1
            randomIndex = (randomIndex + 1) % rewards.count
        }
        
        return rewards[randomIndex]
    }
    
    func showRewards() {
        let rewards = IslandManager.shared.getRewards(fromIsland: self.island.name!)!
        for reward in rewards where reward.isShown {
            let node = self.scene!.childNode(withName: "\(reward.id!)") as? SKSpriteNode
            node?.alpha = 1
        }
    }
    
    @objc func rewardAnimation() {
        let node = self.scene?.childNode(withName: self.rewardIdToAnimate) as? SKSpriteNode
        let nodeSize = node?.size
        node?.alpha = 1
        let increase = SKAction.resize(toWidth: nodeSize!.width*2, height: nodeSize!.height*2, duration: 1.5)
        let decrease = SKAction.resize(toWidth: nodeSize!.width, height: nodeSize!.height, duration: 1.5)
        let sequentialAction = SKAction.sequence([increase, decrease, increase, decrease])
        node?.run(sequentialAction)
    }
}
