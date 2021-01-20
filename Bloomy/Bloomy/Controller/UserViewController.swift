//
//  UserViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 09/12/20.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet var healthButton: UIButton!
    @IBOutlet var leisureButton: UIButton!
    @IBOutlet var mindfulnessButton: UIButton!
    @IBOutlet var lovedsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userNameLabel.text = UserManager.shared.getUserName()
        self.buttonsToShow()
        self.setupNavigationController()
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
    }
    
    func buttonsToShow() {
        if (IslandManager.shared.getIsland(withName: IslandsNames.health.rawValue) == nil) {
            self.healthButton.isHidden = true
        }
        
        if (IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue) == nil) {
            self.leisureButton.isHidden = true
        }
        
        if (IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue) == nil) {
            self.mindfulnessButton.isHidden = true
        }
        
        if (IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue) == nil) {
            self.lovedsButton.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? JourneyCollectionViewController
        
        if segue.identifier == "healthToJourney" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.health.rawValue)!
        } else if segue.identifier == "leisureToJourney" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue)!
        } else if segue.identifier == "mindfulnessToJourney" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue)!
        } else if segue.identifier == "lovedsToJourney" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue)!
        }
    }
}
