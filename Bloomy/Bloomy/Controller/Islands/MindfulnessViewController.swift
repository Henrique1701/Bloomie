//
//  MindfulnessViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 01/12/20.
//

import UIKit

class MindfulnessViewController: UIViewController {

    @IBOutlet weak var challengeDayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ajusta o tamaho do titulo do botão
        self.challengeDayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // Configura a navigation controller
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "Atenção Plena"
        self.navigationController?.navigationBar.layoutIfNeeded()
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
