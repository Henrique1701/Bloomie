//
//  ChallengePopUpViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 03/12/20.
//

import UIKit

class ChallengePopUpViewController: UIViewController {
    @IBOutlet weak var acceptButton: UIButton!
    var summary: String = ""
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.acceptButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.contentView.layer.cornerRadius = 35
        self.summaryLabel.adjustsFontSizeToFitWidth = true
        //self.summaryLabel.minimumScaleFactor = 0.5
        // Do any additional setup after loading the view.
        //self.summaryLabel.text = summary
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.summaryLabel.text = summary
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func accept(_ sender: Any) {
        dismiss(animated: true)
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
