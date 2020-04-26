//
//  TableViewController.swift
//  DailyQuotes
//
//  Created by Pavol Virdzek on 08/04/2020.
//  Copyright © 2020 Pavol Virdzek. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let notifications = ["Start Daily quotes Engine 🚀",
                         "Local Notification",
                         "Local Notification with Action",
                         "Local Notification with Content",
                         "Push Notification with  APNs",
                         "Push Notification with Firebase",
                         "Push Notification with Content",
                         "Cancel Notification"
    ]
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = notifications[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let notificationType = notifications[indexPath.row]
        
        if (notificationType == "Start Daily quotes Engine 🚀") {
            self.appDelegate?.scheduleInfiniteNotifications(timePeriod: 60)
            return
        }
        
        if (notificationType == "Cancel Notification") {
            self.appDelegate?.cancelAndHideNotifications(identifier: "")
            return
        }
        
        let alert = UIAlertController(title: "",
                                      message: "After 5 seconds " + notificationType + " will appear",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            self.appDelegate?.scheduleNotification()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
