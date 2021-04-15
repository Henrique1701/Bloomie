//
//  JourneyPopUpViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 26/01/21.
//

import UIKit

class JourneyPopUpViewController: UIViewController {

    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var image: UIImage?
    var summary: String?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.layer.cornerRadius = 35
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchedVisualEffectView))
        tapGesture.numberOfTapsRequired = 1
        self.visualEffectView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rewardImage.image = self.image
        summaryLabel.text = self.summary
        dateLabel.text = self.date
    }
    
    @IBAction func touchedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchedVisualEffectView() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func touchedShareButton(_ sender: Any) {
        let alert = UIAlertController(title: "Compartilhar", message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = .black
        
        let buttonCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        let buttonInsta = UIAlertAction(title: "Instagram", style: .default) { _ in
            self.shareInstagram()
        }
        
        let buttonTwitter = UIAlertAction(title: "Twitter", style: .default) { _ in
            // TODO: Criar função para compartilhar no Twitter
        }
        
        let buttonSave = UIAlertAction(title: "Salvar", style: .default) { _ in
            // TODO: Criar função para salvar imagem na galeria
        }
        
        alert.addAction(buttonInsta)
        alert.addAction(buttonTwitter)
        alert.addAction(buttonSave)
        alert.addAction(buttonCancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func shareInstagram() {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.view.bounds.width, height: self.view.bounds.height),
            false,
            2
        )
        
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        if let urlScheme = URL(string: "instagram-stories://share") {
            
            if UIApplication.shared.canOpenURL(urlScheme) {
                
                let image = UIImage(named: "AA1")
                
                let imageData: Data = screenshot.pngData()!
                
                let items = [["com.instagram.sharedSticker.backgroundImage, "com.instagram.sharedSticker.stickerImage": imageData]]
                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                
                UIPasteboard.general.setItems(items, options: pasteboardOptions)
                
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            }
        }
    }
}
