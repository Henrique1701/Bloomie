//
//  LeisureViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 01/12/20.
//

import UIKit

class LeisureViewController: UIViewController {
    @IBOutlet weak var challengeDayButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    let island = IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue)!
    var challengeObserver: NSObjectProtocol?
    var doneObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseButtonToShow()
        setupStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        challengeObserver = NotificationCenter.default.addObserver(forName: .acceptChallenge, object: nil, queue: OperationQueue.main) { (notification) in
            self.island.dailyChallenge?.accepted = true
            _ = IslandManager.shared.saveContext()
            self.chooseButtonToShow()
            self.loadViewIfNeeded()
        }
        
        doneObserver = NotificationCenter.default.addObserver(forName: .doneChallenge, object: nil, queue: OperationQueue.main) { (notification) in
            self.island.dailyChallenge?.done = true
            _ = IslandManager.shared.saveContext()
            self.chooseButtonToShow()
            self.loadViewIfNeeded()
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
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
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
            
        } else if ((self.island.dailyChallenge?.accepted)! && !(self.island.dailyChallenge?.done)!) {
            //se o desafio foi aceito mas n foi concluído
            self.challengeDayButton.isHidden = true
            self.doneButton.isHidden = false
            //Mostra o challengeDayButton
            //Esconde o botão de concluir
            //Ainda tem o caso em que o botão tá desativado
        } else {
            //desafio aceito e concluído
            //precisa setar uma forma inativa para o challengeDayButton
            self.challengeDayButton.isHidden = true
            self.doneButton.isHidden = true
        }
    }
    
}
