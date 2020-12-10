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
    
          // create the notification content
            let content = UNMutableNotificationContent()
            content.title = "Aceitar novo desafio"
            content.body = "Você tem novos desafios a serem aceitos. Vamos crescer juntos?"
            content.sound = .default

            let date = acceptHour.date
            
            // create a Calender instance
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)

            //Notification trigger
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
             
            //Create the request
            let request = UNNotificationRequest(identifier: "Alert", content: content, trigger: trigger)

            //Register the request
            center.add(request) { (error) in
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
    
          // create the notification content
            let content = UNMutableNotificationContent()
            content.title = "Finalize seu desafio"
            content.body = "Lembre-se de finalizar seu desafio no Bloomy. Sua ilha vai ficar mais florida!"
            content.sound = .default

            let date = finishHour.date
            
            // create a Calender instance
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)

            //Notification trigger
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
             
            //Create the request
            let request = UNNotificationRequest(identifier: "Alert", content: content, trigger: trigger)

            //Register the request
            center.add(request) { (error) in
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
    
          // create the notification content
            let content = UNMutableNotificationContent()
            content.title = "Lembre-se de realizar seu desafio"
            content.body = "Essa é uma boa hora pra fazer o desafio, não acha?"
            content.sound = .default

            let date = rememberHour.date
            
            // create a Calender instance
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)

            //Notification trigger
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
             
            //Create the request
            let request = UNNotificationRequest(identifier: "Alert", content: content, trigger: trigger)

            //Register the request
            center.add(request) { (error) in
            }
}
    
    @IBAction func rememberSwitch(_ sender: UISwitch) {
        if rememberChallenge.isOn {
            rememberFunc()
        }
    }
    
    @IBAction func rememberSchedule(_ sender: UIDatePicker) {
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
