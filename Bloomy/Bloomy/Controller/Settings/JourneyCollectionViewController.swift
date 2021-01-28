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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(named: "cor_fundo")
        self.title = island.name!
        self.setDoneChallenges()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    // MARK: - Auxiliar Functions
    
    func setDoneChallenges() {
        self.doneChallenges = []
        for challenge in islandsManager.getChallenges(fromIsland: self.island.name!)! where challenge.done {
            self.doneChallenges.append(challenge)
        }
    }


}
