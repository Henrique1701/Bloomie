//
//  RewardPopUpViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 07/12/20.
//

import UIKit

class RewardPopUpViewController: UIViewController {
    var rewardImage: UIImage?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var rewardImageView: UIImageView!
    @IBOutlet weak var getButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
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
}
