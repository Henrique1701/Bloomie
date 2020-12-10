//
//  RewardPopUpViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 07/12/20.
//

import UIKit
import AVFoundation

class RewardPopUpViewController: UIViewController {
    var rewardImage: UIImage?
    var rewardAudioPlayer: AVAudioPlayer?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var rewardImageView: UIImageView!
    @IBOutlet weak var getButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
        playRewardSound()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Mandar um sinal para animação começar na tela de ilha
        NotificationCenter.default.post(name: Notification.Name("animationObserver"), object: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func getReward(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setupStyle() {
        self.getButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.contentView.layer.cornerRadius = 35
        if rewardImage != nil {
            self.rewardImageView.image = rewardImage
        }
    }
    
    func playRewardSound() {
        let pathToSound = Bundle.main.path(forResource: "reward", ofType: "mp3")!
        let urlReward = URL(fileURLWithPath: pathToSound)
        do {
            rewardAudioPlayer = try AVAudioPlayer(contentsOf: urlReward)
            rewardAudioPlayer?.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
}
