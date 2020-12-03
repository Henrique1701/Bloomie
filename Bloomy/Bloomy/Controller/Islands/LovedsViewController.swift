//
//  LovedsViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 01/12/20.
//

import UIKit

class LovedsViewController: UIViewController {
    let island = IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue)
    @IBOutlet weak var challengeDayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = IslandsNames.loveds.rawValue
        
        // Ajusta o tamaho do titulo do botão
        self.challengeDayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        setupNavigationController()
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
