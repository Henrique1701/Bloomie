//
//  LovedsViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 01/12/20.
//

import UIKit

class LovedsViewController: UIViewController {
    @IBOutlet weak var challengeDayButton: UIButton!
    let island = IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue)!
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseButtonToShow()
        setupStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observer = NotificationCenter.default.addObserver(forName: .acceptChallenge, object: nil, queue: OperationQueue.main) { (notification) in
            let popup = notification.object as! ChallengePopUpViewController
            self.island.dailyChallenge?.accepted = true
            IslandManager.shared.saveContext()
            self.challengeDayButton.isHidden = true
            self.loadViewIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if observer != nil {
            NotificationCenter.default
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChallengePopUpViewControllerSegue" {
            let popup = segue.destination as! ChallengePopUpViewController
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
        self.title = IslandsNames.loveds.rawValue
        // Ajusta o tamaho do titulo do botão
        self.challengeDayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // Configura a navigation controller
        setupNavigationController()
    }
    
    func chooseButtonToShow() {
        if (self.island.dailyChallenge?.accepted ?? false) {
            self.challengeDayButton.isHidden = true
        } else if (self.island.dailyChallenge?.accepted ?? true) {
            //Mostra o challengeDayButton
            //Esconde o botão de concluir
            //Ainda tem o caso em que o botão tá desativado
        }
    }

}
