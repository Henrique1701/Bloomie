//
//  UserViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 09/12/20.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet var healthButton: UIButton!
    @IBOutlet var leisureButton: UIButton!
    @IBOutlet var mindfulnessButton: UIButton!
    @IBOutlet var lovedsButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    //@IBOutlet var profileImageButton: UIButton!
    @IBOutlet weak var profileImageButton: UIButton!
    var imagePicker: ImagePicker!
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var editProfileImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let savedImage:UIImage? = UserManager.shared.getUserImage()
        if(savedImage != nil){
            let width = defaults.double(forKey: "width")
            let height = defaults.double(forKey: "height")
            self.profileImage.frame = CGRect(x: 0, y: 0, width: width, height: height)
            self.profileImage.image = savedImage
            self.profileImage.layer.cornerRadius = (profileImage.frame.width)/2
            print("WIDTH = \(width)")
            print("HEIGHT = \(height)")
            self.profileImage.layer.masksToBounds = false
            self.profileImage.clipsToBounds = true
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.layoutIfNeeded()
            //profileImage.maskCircle(anyImage: savedImage!)
        } else {
            self.profileImage.image = #imageLiteral(resourceName: "avatar")
        }
        
        self.userNameLabel.text = UserManager.shared.getUserName()
        self.setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.buttonsToShow()
        self.organizePositionButtons()
    }
    
    func showAlert(islandName: String) {
        let alert = UIAlertController(title: "", message: "Tente ir em 'Editar ilhas' que fica nas configurações e selecionar a ilha de \(islandName)", preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "fechar", style: .default) { _ in }
        alert.addAction(closeButton)
        present(alert, animated: true, completion: nil)
    }
    
    func showJourney(islandName: String) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Journey", bundle: nil)
        let destination = storyboard.instantiateInitialViewController() as! JourneyCollectionViewController
        destination.island = IslandManager.shared.getIsland(withName: islandName)!
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    @IBAction func touchedHealthButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedHealth") {
            showJourney(islandName: IslandsNames.health.rawValue)
        } else {
            showAlert(islandName: "saúde")
        }
    }
    
    @IBAction func touchedLeisureButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedLeisure") {
            showJourney(islandName: IslandsNames.leisure.rawValue)
        } else {
            showAlert(islandName: "lazer")
        }
    }
    
    @IBAction func touchedMindfulnessButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedMindfulness") {
            showJourney(islandName: IslandsNames.mindfulness.rawValue)
        } else {
            showAlert(islandName: "atenção plena")
        }
    }
    
    @IBAction func touchedLovedButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedLoveds") {
            showJourney(islandName: IslandsNames.loveds.rawValue)
        } else {
            showAlert(islandName: "pessoas queridas")
        }
    }
    
    @IBAction func editProfileImage(_ sender: UIButton) {
        print("quero editar a imagem de perfil")
        self.imagePicker.present(from: sender)
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
    }
    
    func buttonsToShow() {
        if (defaults.bool(forKey: "selectedHealth")) {
            self.healthButton.alpha = 1
        } else {
            self.healthButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedLeisure")) {
            self.leisureButton.alpha = 1
        } else {
            self.leisureButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedMindfulness")) {
            self.mindfulnessButton.alpha = 1
        } else {
            self.mindfulnessButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedLoveds")) {
            self.lovedsButton.alpha = 1
        } else {
            self.lovedsButton.alpha = 0.6
        }
    }
    
    func organizePositionButtons() {
        var buttons = stackView.arrangedSubviews
        var index = 0
        var control = 0
        while(index < buttons.count) {
            print(buttons[index].alpha)
            if buttons[index].alpha != 1 {
                print(" Entrou")
                let viewRemove = self.stackView.arrangedSubviews[index]
                self.stackView.removeArrangedSubview(viewRemove)
                self.stackView.addArrangedSubview(viewRemove)
                buttons = stackView.arrangedSubviews
            } else {
                index += 1
            }
            if control == buttons.count-1 {
                index = buttons.count
            } else {
                control += 1
            }
        }
    }
}

extension UserViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if(image != nil){
            self.profileImage.image = image
            self.profileImage.layer.cornerRadius = (profileImage.frame.size.width)/2
            self.profileImage.clipsToBounds = true
            self.profileImage.contentMode = .scaleAspectFit
            self.profileImage.layoutIfNeeded()
            
            let width = profileImage.frame.width
            defaults.set(width, forKey: "width")
            let height = profileImage.frame.height
            defaults.set(height, forKey: "height")
            print("WIDTH = \(width)")
            print("HEIGHT = \(height)")
            
        }
        
        UserManager.shared.updateUserImage(to: image ?? #imageLiteral(resourceName: "plant"))
    }
}

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        //self.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
