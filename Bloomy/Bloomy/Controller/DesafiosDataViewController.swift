//
//  DesafiosDataViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 09/12/20.
//

import UIKit

class DesafiosDataViewController: UIViewController {
    
    var islandName: String?
    var cardImage: UIImage!
    var summaryText: String!
    var index: Int?
    var lastScreen: Bool?
    var islandsManager = IslandManager.shared
    
    @IBOutlet weak var card: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        summaryLabel.text = summaryText
        card.image = cardImage
        card.clipsToBounds = true
        card.layer.cornerRadius = 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? IslandsViewController
        destination?.senderWasDesafios = true
        
        if islandName == IslandsNames.health.rawValue {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.health.rawValue)!
            destination?.sceneName = "HealthIsland"
        } else if islandName == IslandsNames.leisure.rawValue {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue)!
            destination?.sceneName = "LeisureIsland"
        } else if islandName == IslandsNames.mindfulness.rawValue {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue)!
            destination?.sceneName = "MindfulnessIsland"
        } else if islandName == IslandsNames.loveds.rawValue {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue)!
            destination?.sceneName = "LovedsIsland"
        }
    }
    
}
