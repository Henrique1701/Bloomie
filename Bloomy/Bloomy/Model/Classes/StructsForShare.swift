//
//  StructsForShare.swift
//  Bloomie
//
//  Created by José Henrique Fernandes Silva on 16/04/21.
//

import Foundation
import UIKit

struct StructsForShare {
    
    static var shared = StructsForShare()
    private var textForImage: String = ""
    
    mutating func setTextForImage(text: String) {
        self.textForImage = text
    }
    
    func shareInstagram() {
        let background = UIImage(named: "background_stories")
        let image = getImageForShare()
        
        if let urlScheme = URL(string: "instagram-stories://share") {
            
            if UIApplication.shared.canOpenURL(urlScheme) {
                
                let items = [["com.instagram.sharedSticker.backgroundImage": background, "com.instagram.sharedSticker.stickerImage": image]]
                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                
                UIPasteboard.general.setItems(items, options: pasteboardOptions)
                
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func getImageForShare() -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: 330, height: 370),
            false,
            scale
        )
        
        // View
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 330, height: 370)
        view.layer.cornerRadius = 35
        view.backgroundColor = .white
        
        // Text
        let text = UILabel()
        text.frame = CGRect(x: 30, y: 47, width: 270, height: 209)
        text.textColor = #colorLiteral(red: 0.2431372549, green: 0.2470588235, blue: 0.2745098039, alpha: 1)
        text.textAlignment = .center
        text.font = UIFont(name: "Poppins-SemiBold", size: 24)
        text.lineBreakMode = .byClipping
        text.adjustsFontSizeToFitWidth = true
        text.minimumScaleFactor = 0.5
        text.numberOfLines = 0
        text.text = self.textForImage
        view.addSubview(text)
        
        // Button
        let button = UIButton()
        button.frame = CGRect(x: 72, y: 286, width: 186, height: 54)
        button.setBackgroundImage(UIImage(named: "botao_desafio_do_dia"), for: .normal)
        let buttonTitle = "missão do dia"
        let buttonFont = UIFont(name: "Poppins-Bold", size: 18)
        let attributes = [NSAttributedString.Key.font: buttonFont]
        let attributedButtonTitle = NSAttributedString(string: buttonTitle, attributes: attributes)
        button.setAttributedTitle(attributedButtonTitle, for: .normal)
        view.addSubview(button)
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}

