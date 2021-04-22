//
//  NotificationsViewController.swift
//  Bloomy
//
//  Created by Marina Lima on 09/12/20.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {
    
    @IBOutlet var acceptChallenge: UISwitch!
    @IBOutlet var finishChallenge: UISwitch!
    @IBOutlet var rememberChallenge: UISwitch!
    
    @IBOutlet var acceptHour: UIDatePicker!
    @IBOutlet var finishHour: UIDatePicker!
    @IBOutlet var rememberHour: UIDatePicker!
    
    // MARK: - Accept Notifications
    
    func acceptFunc() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "aceitar nova missão"
        content.body = "você tem novas missões a serem aceitas. vamos crescer juntos?"
        content.sound = .default
        
        let date = acceptHour.date
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Alert", content: content, trigger: trigger)
        
        center.add(request) { _ in
        }
    }
    
    @IBAction func acceptSwitch(_ sender: UISwitch) {
        
        if acceptChallenge.isOn {
            
            acceptFunc()
        }
    }
    
    @IBAction func acceptSchedule(_ sender: UIDatePicker) {
    }
    
    // MARK: - Finish Notifications
    
    func finishFunc() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "finalize sua missão"
        content.body = "lembre-se de finalizar sua missão no Bloomy. sua ilha vai ficar mais florida!"
        content.sound = .default
        
        let date = finishHour.date
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Alert", content: content, trigger: trigger)
        
        center.add(request) { _ in
        }
    }
    
    @IBAction func finishSwitch(_ sender: UISwitch) {
        if finishChallenge.isOn {
            finishFunc()
        }
    }
    
    @IBAction func finishSchedule(_ sender: UIDatePicker) {
    }
    
    // MARK: - Remember Notifications
    
    func rememberFunc() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "lembre-se de realizar sua missão"
        content.body = "essa é uma boa hora pra fazer a missão, não acha?"
        content.sound = .default
        
        let date = rememberHour.date
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Alert", content: content, trigger: trigger)
        
        center.add(request) { _ in
        }
    }
    
    @IBAction func rememberSwitch(_ sender: UISwitch) {
        if rememberChallenge.isOn {
            userDefaults.set(true, forKey: UserDefaultsKeys.rememberNotificationIsOn)
        }
    }
    
    @IBAction func rememberSchedule(_ sender: UIDatePicker) {
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in
            
        }
        
        self.title = "Notificações"
    }
}
