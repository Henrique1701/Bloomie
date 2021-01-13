//
//  DesafiosDataViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 09/12/20.
//

import UIKit

class DesafiosDataViewController: UIViewController {
    
    // Esse View Controller define como serão as páginas do PageViewController
    
    // Outlets
    @IBOutlet weak var card: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var concluirButtonOutlet: UIButton!
    
    // Botão concluir missão
    @IBAction func concluirButton(_ sender: Any) {
        
    }
    
    // Global variables
    var cardImage: UIImage!
    var summaryText: String!
    var index: Int?
    var lastScreen: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        summaryLabel.text = summaryText
        card.image = cardImage
        card.clipsToBounds = true
        card.layer.cornerRadius = 20
    }
}
