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
        //se nao tiver imagem salva no core data, a imagem de perfil é a da menina do onbording
        //se tiver, a imagem salva no core data é a imagem de perfil
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
    
    @IBAction func showImagePicker(_ sender: UIButton) {
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
        self.profileImage.image = image
        profileImage.layer.cornerRadius = (profileImage.frame.size.width)/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.layoutIfNeeded()
    }
}

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
