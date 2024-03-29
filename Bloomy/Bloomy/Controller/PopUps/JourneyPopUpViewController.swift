//
//  JourneyPopUpViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 26/01/21.
//

import UIKit

class JourneyPopUpViewController: UIViewController {

    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var image: UIImage?
    var summary: String?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.layer.cornerRadius = 35
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchedVisualEffectView))
        tapGesture.numberOfTapsRequired = 1
        self.visualEffectView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rewardImage.image = self.image
        summaryLabel.text = self.summary
        dateLabel.text = self.date
    }
    
    @IBAction func touchedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchedVisualEffectView() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func touchedShareButton(_ sender: Any) {
        StructsForShare.shared.setTextForImage(text: self.summary!)
        let image = StructsForShare.shared.getImageForShare()
        let custom = CustomActivity(title: "Stories")
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: [custom])
        
        present(activity, animated: true, completion: nil)
    }
}
