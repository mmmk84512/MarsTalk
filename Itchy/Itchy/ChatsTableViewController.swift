//
//  InitalTableViewController.swift
//  SwiftExample
//
//  Created by P D Leonard on 7/22/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import FoldingTabBar

let cellIdentifier = "cellIdentifier"

class ChatsTableViewController: UITableViewController, YALTabBarDelegate {
    
    //MARK: - View lifecycle
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chats"
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.appDelegate.tabBarController.tabBarView.setExtraRightTabBarButtonImage(UIImage(named: "NewChatIcon"), index: 1)
        self.appDelegate.tabBarController.tabBarView.setExtraLeftTabBarButtonImage(UIImage(named: "SearchIcon"), index: 1)
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section) {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Conversation between two people"
                break
            case 1:
                cell.textLabel?.text = "Group Conversation"
                break
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Settings"
                break
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Examples"
        case 1:
            return "Options"
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 2:
            return "Copyright © 2015\nJesse Squires\nMIT License"
        case 3:
            return "Thanks to all the contributers and MacMeDan for this swift example."
        default:
            return nil
        }
    }
    
    //Mark: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let chatView = ChatRoomViewController()
                chatView.messages = makeNormalConversation()
                let chatNavigationController = UINavigationController(rootViewController: chatView)
                presentViewController(chatNavigationController, animated: true, completion: nil)
            case 1:
                let chatView = ChatRoomViewController()
                chatView.messages = makeGroupConversation()
                let chatNavigationController = UINavigationController(rootViewController: chatView)
                presentViewController(chatNavigationController, animated: true, completion: nil)
            default:
                return
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.presentViewController(UINavigationController(rootViewController: SettingsTableViewController()), animated: true, completion: nil)
            default:
                return
            }
        default:
            return
        }
    }
    
    func tabBarDidSelectExtraRightItem(tabBar: YALFoldingTabBar!) {
        let selectChatFriendsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SelectChatFriendsViewController") as! SelectChatFriendsViewController
        tabBar.swapExtraRightTabBarItem()
        tabBar.swapExtraLeftTabBarItem()
        self.navigationController?.pushViewController(selectChatFriendsViewController, animated: true)

    }
    

    
}
