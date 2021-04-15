//
//  delayedMissionViewController.swift
//  Bloomie
//
//  Created by Wilton Ramos on 14/04/21.
//

import UIKit

class DelayedMissionPopUpViewController: UIViewController {
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var doneMissionButton: UIButton!
    @IBOutlet weak var dismissMissionButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var challenge: Challenge?
    let dailyMissionManager = DailyMissionsManager.shared
    let haptics = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStyles()
    }
    
    // MARK: - Style
    
    private func setupStyles() {
        self.setupDoneMissionButtonStyle()
        self.setupContentViewStyle()
        self.setupMissionLabelStyle()
    }
    
    private func setupDoneMissionButtonStyle() {
        self.doneMissionButton.layer.cornerRadius = 35
    }
    
    private func setupContentViewStyle() {
        self.contentView.layer.cornerRadius = 35
    }
    
    private func setupMissionLabelStyle() {
        self.missionLabel.text = challenge?.summary
    }
    
    // MARK: - Actions
    
    @IBAction func doneMission(_ sender: Any) {
        dailyMissionManager.setDoneStatus(forChallenge: self.challenge)
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .delayedMissionToIslands, object: self)
        haptics.notificationOccurred(.success)
    }
    
    @IBAction func dismissMission(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
