//
//  DonePopUpViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 07/12/20.
//

import UIKit
import Firebase

class DonePopUpViewController: UIViewController {
    var summary: String = ""
    var islandName: String = ""
    let haptics = UINotificationFeedbackGenerator()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.summaryLabel.text = summary
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func doneChallenge(_ sender: Any) {
        sendDateCompletionForAnalytics()
        dismiss(animated: false)
        NotificationCenter.default.post(name: .doneChallenge, object: self)
        haptics.notificationOccurred(.success)
    }
    @IBAction func tappedShareButton(_ sender: Any) {
        StructsForShare.shared.setTextForImage(text: self.summary)
        let image = StructsForShare.shared.getImageForShare()
        let custom = CustomActivity(title: "Stories")
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: [custom])
        present(activity, animated: true, completion: nil)
    }
    
    func configureIslandName() {
        let islandsNamesPT = ["Atenção Plena", "Saúde", "Pessoas Queridas", "Lazer"]
        let islandsNames = ["Mindfulness", "Health", "Loveds", "Leisure"]
        for index in 0..<islandsNamesPT.count where
            islandsNamesPT[index] == self.islandName {
            self.islandName = islandsNames[index]
        }
    }
    
    func sendDateCompletionForAnalytics() {
        configureIslandName()
        let dateWasAccepted = userDefaults.value(forKey: UserDefaultsKeys.dateWasAccepted+"\(islandName)") as! Date
        let dateWasAcceptedTreated = dateWasAccepted.timeIntervalSince1970
        let dateWasDone = Date()
        let dateWasDoneTreated = dateWasDone.timeIntervalSince1970
        let dateDifference = dateWasDoneTreated - dateWasAcceptedTreated
        let dateDifferenceTreated = round(Double(dateDifference) / 60)
        Analytics.logEvent("completion_a_mission", parameters: ["time_in_minutes" : NSNumber(value: dateDifferenceTreated)])
    }
    
    func setupStyle() {
        self.questionLabel.adjustsFontSizeToFitWidth = true
        self.summaryLabel.adjustsFontSizeToFitWidth = true
        self.doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.contentView.layer.cornerRadius = 35
    }
    
}
