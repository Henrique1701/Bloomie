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
    var summaryText = ""
    var dateText = ""
    var rewardID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.summaryLabel.text

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.summaryLabel.text = summaryText
        self.dateLabel.text = dateText
        self.rewardImage.image = UIImage(named: rewardID)
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
