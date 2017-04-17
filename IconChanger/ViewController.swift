//
//  ViewController.swift
//  IconChanger
//
//  Created by Zeeshan Khan on 4/16/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let arrImages = ["Yo", "Yalla"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? arrImages.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)

        switch indexPath.section {
        case 0:
            if let alternateIconName = UIApplication.shared.alternateIconName {
                cell.imageView?.image = UIImage(named: alternateIconName)
                cell.textLabel?.text = "Current icon " + alternateIconName
            }
            else {
                cell.imageView?.image = UIImage(named: "AppIcon60x60")
                cell.textLabel?.text = "Current icon"
            }

        case 1:
            cell.imageView?.image = UIImage(named: arrImages[indexPath.row])
            cell.textLabel?.text = arrImages[indexPath.row]

        case 2:
            cell.imageView?.image = UIImage(named: "AppIcon60x60")
            cell.textLabel?.text = "Reset to default"
            
        default: break
        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 1:
            changeIcon(name: arrImages[indexPath.row])
        case 2:
            changeIcon(name: nil)
            
        default: break
        }
        
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    func changeIcon(name: String?) {
        
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        
        guard let name = name else {
            // Reset to default
            UIApplication.shared.setAlternateIconName(nil)
            return
        }
        
        UIApplication.shared.setAlternateIconName(name){ error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

}


