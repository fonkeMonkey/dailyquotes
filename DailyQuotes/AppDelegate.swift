//
//  AppDelegate.swift
//  DailyQuotes
//
//  Created by Pavol Virdzek on 08/04/2020.
//  Copyright © 2020 Pavol Virdzek. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()
    
    //TODO put in file probably
    let quotes = ["Character is action. Deep character is how a person behaves under stress.",
                  "Keep away from people who try to belittle your ambitions. Small people always do that, but the really great make you feel that you, too, can become great.  - Mark Twain",
                  "We know that 80 percent of life's most defining moments take place by age 35.",
                  " When you have some cards, play them, but until then, you have to do what you have to do, and getting angry about how stupid the process is is only going to undercut your efforts (and I've been there; it isn't productive.)",
                  "The opposite of courage in our society is not cowardice, it's conformity.",
        "I’m very happily married and have been for many years. But I don’t think it’s for everyone, and it probably never was. People are just now coming to this realization, and because of this the social pressure to marry is on the decline. "
    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationCenter.delegate = self
        
        // Override point for customization after application launch.
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        
        return true
    }

        func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
    
    extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        completionHandler()
    }
    
    func scheduleNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        let categoryIdentifire = "Delete Notification Type"
        
        content.title = "Daily Quotes 👩‍🎤"
        
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = categoryIdentifire
        
        let number = Int.random(in: 0 ... quotes.count)
        content.body = quotes[number]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: categoryIdentifire,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
        
    func cancelNotification(identifier : String ) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["Local Notification"])
    }

}

