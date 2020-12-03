//
//  MindfulnessViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 01/12/20.
//

import UIKit

class MindfulnessViewController: UIViewController {

    @IBOutlet weak var challengeDayButton: UIButton!
    let island = IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue)
    //let challengeView: UIView = ChallengeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = IslandsNames.mindfulness.rawValue
        
        // Ajusta o tamaho do titulo do botão
        self.challengeDayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // Configura a navigation controller
        setupNavigationController()
        
        // Configura a challenge view
        //setupChallengeView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChallengePopUpViewControllerSegue" {
            let popup = segue.destination as! ChallengePopUpViewController
            popup.summary = island?.dailyChallenge?.summary ?? ""
        }
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
    }
    
//    func setupChallengeView() {
//        self.view.addSubview(challengeView)
//        self.challengeView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.challengeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            self.challengeView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
//            self.challengeView.widthAnchor.constraint(equalToConstant: 400 ),
//            self.challengeView.heightAnchor.constraint(equalToConstant: 400)
//        ])
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
