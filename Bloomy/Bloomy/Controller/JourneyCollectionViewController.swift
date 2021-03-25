//
//  JourneyCollectionViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 20/01/21.
//

import UIKit

private let reuseIdentifier = "JourneyCollectionViewCell"

class JourneyCollectionViewController: UICollectionViewController {
    
    // MARK: - Global Variables
    
    let userManager = UserManager.shared
    let islandsManager = IslandManager.shared
    var island = Island()
    var doneChallenges: [Challenge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(named: "cor_fundo")
        self.title = island.name!
        self.setDoneChallenges()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.doneChallenges.isEmpty) {
            self.collectionView.setEmptyMessage()
        } else {
            self.collectionView.restore()
        }
        return doneChallenges.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JourneyCollectionViewCell", for: indexPath) as! JourneyCollectionViewCell
        
        cell.summaryLabel.text = doneChallenges[indexPath.row].summary
        let rewardID = doneChallenges[indexPath.row].reward?.id
        cell.rewardImageView.image = UIImage(named: rewardID!)
        cell.layer.cornerRadius = 12

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rewardID = doneChallenges[indexPath.row].reward?.id
        let image = UIImage(named: rewardID!)
        let summary = doneChallenges[indexPath.row].summary
        // Configura a data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: doneChallenges[indexPath.row].time!)
        
        showPopUp(image: image!, summary: summary!, date: dateString)
    }
    
    func showPopUp(image: UIImage, summary: String, date: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PopUps", bundle: nil)
        let popup = storyBoard.instantiateViewController(identifier: "JourneyPopUp") as JourneyPopUpViewController
        
        popup.image = image
        popup.summary = summary
        popup.date = date
        
        present(popup, animated: true, completion: nil)
    }

    // MARK: - Auxiliar Functions
    
    func setDoneChallenges() {
        self.doneChallenges = []
        for challenge in islandsManager.getChallenges(fromIsland: self.island.name!)! where challenge.done {
            self.doneChallenges.append(challenge)
        }
    }
}

class JourneyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var rewardImageView: UIImageView!
    
}

extension UICollectionView {

    func setEmptyMessage() {
        let noJourneyviewController: UIViewController = UIStoryboard(name: "JornadaVazia", bundle: nil).instantiateViewController(withIdentifier: "JornadaVaziaViewController") as UIViewController
        
        self.backgroundView = noJourneyviewController.view
    }

    func restore() {
        self.backgroundView = nil
    }
}
