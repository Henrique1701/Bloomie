//
//  ModalViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 20/01/21.
//

import UIKit

class ModalViewController: UIViewController {
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    var summaryText = ""
    var dateText = ""
    var rewardID = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.summaryLabel.text = summaryText
        self.dateLabel.text = dateText
        self.rewardImage.image = UIImage(named: rewardID)
    }

    @IBAction func touchedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
