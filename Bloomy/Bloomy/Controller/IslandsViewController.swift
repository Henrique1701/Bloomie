//
//  IslandsViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 07/01/21.
//

import UIKit
import SpriteKit
import GameplayKit
import StoreKit
import Firebase

class IslandsViewController: UIViewController {
    @IBOutlet weak var challengeDayButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var acceptedFeedbackMessage: UIImageView!
    @IBOutlet var doneFeedbackMessage: UIImageView!
    
    var island = Island()
    var challengeObserver: NSObjectProtocol?
    var doneObserver: NSObjectProtocol?
    var scene = SKScene()
    var animationObserver: NSObjectProtocol?
    var rewardIdToAnimate = ""
    var originalScaleFromIsland = CGAffineTransform()
    var originalFrameFromIsland = CGRect()
    var sceneName = ""
    var senderWasDesafios = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = SKScene(fileNamed: sceneName)!
        
        self.setupStyle()
        self.setupSKScene()
        self.chooseButtonToShow()
        
        self.view.addSubview(challengeDayButton)
        self.view.addSubview(doneButton)
        self.view.addSubview(acceptedFeedbackMessage)
        self.view.addSubview(doneFeedbackMessage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        challengeObserver = NotificationCenter.default.addObserver(forName: .acceptChallenge, object: nil, queue: OperationQueue.main) { _ in
            self.acceptChallenge()
        }
        
        doneObserver = NotificationCenter.default.addObserver(forName: .doneChallenge, object: nil, queue: OperationQueue.main) { _ in
            self.doneChallenge()
            self.chooseButtonToShow()
            self.showRewardPopUp()
            self.loadViewIfNeeded()
        }
        
        // Espera uma notificação para ativar animação da recompensa
        animationObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "animationObserver"), object: nil, queue: OperationQueue.main) { _ in
            self.rewardAnimation()
        }
        
        // Exibe o popup de concluir quando chamado por DesafiosDataViewController
        if (senderWasDesafios) {
            self.performSegue(withIdentifier: "toDonePopUpViewControllerSegue" , sender: self)
            self.senderWasDesafios = false
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
            let popup = segue.destination as? ChallengePopUpViewController
            popup!.summary = island.dailyChallenge?.summary ?? ""
            popup!.islandName = island.name!
        } else if (segue.identifier == "toDonePopUpViewControllerSegue") {
            let popup = segue.destination as? DonePopUpViewController
            popup!.summary = island.dailyChallenge?.summary ?? ""
            popup!.islandName = island.name!
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
        self.island.dailyChallenge?.time = Date()
        _ = IslandManager.shared.saveContext()
    }
    
    func setupSKScene() {
        let islandView = SKView(frame: CGRect(x: self.view.center.x-(366/2), y: self.view.center.y-(364/2), width: 366, height: 364))
        islandView.backgroundColor = .black
        
        // Configura gestos
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(sender:)))
        islandView.addGestureRecognizer(pinch)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resizeIsland(sender:)))
        self.originalFrameFromIsland = islandView.frame
        self.originalScaleFromIsland = islandView.transform
        tapGesture.numberOfTapsRequired = 2
        islandView.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragIsland(sender:)))
        islandView.addGestureRecognizer(panGesture)
        
        self.view.addSubview(islandView)
        
        if let view = islandView as SKView? {
            scene.scaleMode = .aspectFill
            self.showRewards()
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }
    
    func setupStyle() {
        self.title = island.name
        // Ajusta o tamaho do titulo do botão
        self.challengeDayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func chooseButtonToShow() {
        if (!(self.island.dailyChallenge?.accepted)!) {
            //se o desafio não foi aceito
            self.doneButton.isHidden = true
            self.challengeDayButton.isHidden = false
            self.challengeDayButton.isEnabled = true
            self.challengeDayButton.alpha = 1
            self.acceptedFeedbackMessage.isHidden = true
            self.doneFeedbackMessage.isHidden = true
        } else if ((self.island.dailyChallenge?.accepted)! && !(self.island.dailyChallenge?.done)!) {
            //se o desafio foi aceito mas n foi concluído
            self.challengeDayButton.isHidden = true
            self.doneButton.isHidden = false
            self.acceptedFeedbackMessage.isHidden = false
            self.doneFeedbackMessage.isHidden = true
        } else {
            //desafio aceito e concluído
            self.challengeDayButton.isHidden = false
            self.challengeDayButton.alpha = 0.5
            self.challengeDayButton.isEnabled = false
            self.doneButton.isHidden = true
            self.acceptedFeedbackMessage.isHidden = true
            self.doneFeedbackMessage.isHidden = false
        }
    }
    
    func showRewardPopUp() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PopUps", bundle: nil)
        let popup = storyBoard.instantiateViewController(identifier: "RewardPopUp") as? RewardPopUpViewController
        let rewards = IslandManager.shared.getRewards(fromIsland: island.name!)!
        if let availableReward = getAvailableReward(inRewards: rewards) {
            popup!.rewardImage = UIImage(named: "\(availableReward.id!)")
            popup!.modalTransitionStyle = .crossDissolve
            popup!.modalPresentationStyle = .overCurrentContext
            self.rewardIdToAnimate = availableReward.id!
            self.present(popup!, animated: true)
            availableReward.isShown = true
            availableReward.rewardToChallenge = self.island.dailyChallenge
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
            let node = self.scene.childNode(withName: "\(reward.id!)") as? SKSpriteNode
            node?.alpha = 1
        }
    }
    
    @objc func rewardAnimation() {
        let node = self.scene.childNode(withName: self.rewardIdToAnimate) as? SKSpriteNode
        
        let nodeSize = node?.size
        let positionXInitial = node?.position.x
        let positionYInitial = node?.position.y
        
        node?.alpha = 1
        node?.position = CGPoint(x: 0, y: 0)
        node?.size = CGSize(width: nodeSize!.width*3, height: nodeSize!.height*3)
        
        let resizeAction = SKAction.resize(toWidth: nodeSize!.width, height: nodeSize!.height, duration: 3)
        let moveAction = SKAction.move(to: CGPoint(x: positionXInitial!, y: positionYInitial!), duration: 3)
        let waitAction = SKAction.wait(forDuration: 1)
        
        let concurrentAction = SKAction.group([resizeAction, moveAction])
        let sequentialAction = SKAction.sequence([waitAction, concurrentAction])
        
        node?.run(sequentialAction)
        self.requestReviewIfPossible()
    }
    
    fileprivate func presentFirstAlert() {
        let alert = UIAlertController(title: "Curtindo o Bloomie?", message: "", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Sim", style: .default, handler: { _ in
            self.requestReview()
        })
        let noButton = UIAlertAction(title: "Não", style: .cancel, handler: { _ in
            self.presentFeedbackAlert()
        })
        alert.addAction(noButton)
        alert.addAction(yesButton)
        alert.preferredAction = yesButton
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func presentFeedbackAlert() {
        let alert = UIAlertController(title: "Enviar feedback", message: "Você poderia nos dar um feedback?\nAssim, podemos melhorar a rede Bloomie (:", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let sendButton = UIAlertAction(title: "Enviar", style: .default, handler: { _ in
            let userFeedback = (alert.textFields![0].text ?? "") as String
            if (userFeedback != "") {
                Analytics.logEvent("user_feedback", parameters: [
                    "feedback_from_user" : NSString(string: userFeedback)
                ])
            }
            self.dismiss(animated: true, completion: nil)
        })
        let noButton = UIAlertAction(title: "Não", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(sendButton)
        alert.addAction(noButton)
        alert.preferredAction = sendButton
        self.present(alert, animated: true, completion: nil)
    }
    
    private func requestReviewIfPossible() {
        let userDaysActivity = UserDefaults.standard.integer(forKey: DefaultsConstants.userDays.rawValue)
        let didReviewPrompted = UserDefaults.standard.bool(forKey: DefaultsConstants.review.rawValue)
        
        if (userDaysActivity == 3 && !didReviewPrompted) {
            UserDefaults.standard.setValue(true, forKey: DefaultsConstants.review.rawValue)
    
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.presentFirstAlert()
            }
            
        }
    }
    
    private func requestReview() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
        
    }
    
    @objc func handlePinch(sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else { return }
        
        if sender.state == .began || sender.state == .changed {
            
            let transformA = (sender.view?.transform.a)!
            if (transformA > self.view.frame.width/100 && sender.scale > 1) || transformA < 1 && sender.scale < 1 {
                return
            }
            
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        }
    }
    
    @objc func resizeIsland(sender: UITapGestureRecognizer) {
        self.scene.view?.transform = self.originalScaleFromIsland
        self.scene.view?.frame = self.originalFrameFromIsland
    }
    
    @objc func dragIsland(sender: UIPanGestureRecognizer) {
        let view = sender.view!
        let translation = sender.translation(in: sender.view)
        
        if !(view.frame.intersects(self.challengeDayButton.frame)) &&
            !(view.frame.intersects(self.doneButton.frame)) {
            
        }
        if  sender.state == .began || sender.state == .changed {
            //  Precisei multiplicar o translation.x e translation.y para acelerar movimentação da view
            // quando o usuário dar zoom
            let translationX = translation.x * (sender.view?.frame.width)!/self.originalFrameFromIsland.width
            let translationY = translation.y * (sender.view?.frame.width)!/self.originalFrameFromIsland.width
            view.center = CGPoint(x: view.center.x + translationX, y: view.center.y + translationY)
            sender.setTranslation(CGPoint.zero, in: sender.view)
            
        }
    }
}
