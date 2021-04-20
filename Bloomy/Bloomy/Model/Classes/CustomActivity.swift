//
//  CustomActivity.swift
//  Bloomie
//
//  Created by José Henrique Fernandes Silva on 16/04/21.
//

import Foundation
import UIKit

class CustomActivity: UIActivity {
    
    var title: String = ""
    
    
    init(title: String) {
        self.title = title
    }
 
    //Returns custom activity title
    override var activityTitle: String?{
        return self.title
    }
    
    //Returns thumbnail image for the custom activity
    override var activityImage: UIImage?{
        return UIImage(named: "instagram")
    }
 
    //Custom activity type that is reported to completionHandler
    override var activityType: UIActivity.ActivityType{
        return UIActivity.ActivityType.customActivity
    }
 
    //View controller for the activity
    override var activityViewController: UIViewController?{
        return nil
    }
    
    //Returns a Boolean indicating whether the activity can act on the specified data items.
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    class override var activityCategory: UIActivity.Category {
        return .action
    }
    
    //If no view controller, this method is called. call activityDidFinish when done.
    override func prepare(withActivityItems activityItems: [Any]) {
        //Perform action on tap of custom activity
        StructsForShare.shared.shareInstagram()
    }
 }

extension UIActivity.ActivityType {
    static let customActivity = UIActivity.ActivityType("lso.academy.ufpe.br.bloomie")
}
