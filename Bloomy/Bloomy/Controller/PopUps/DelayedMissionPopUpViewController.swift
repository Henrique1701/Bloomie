//
//  delayedMissionViewController.swift
//  Bloomie
//
//  Created by Wilton Ramos on 14/04/21.
//

import UIKit

class DelayedMissionPopUpViewController: UIViewController {
    @IBOutlet weak var doneMissionButton: UIButton!
    @IBOutlet weak var dismissMissionButton: UIButton!
    
    var challenge: Challenge?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func doneMission(_ sender: Any) {
    }
    
    @IBAction func dismissMission(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
