//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by ANHTT-D1 on 7/24/18.
//  Copyright © 2018 RikkeiIOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var friends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    func getData() {
        do {
            friends = try context.fetch(Friend.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = friend.name
        cell.phoneLabel.text = friend.phone_number
        
        if let imageData = friend.value(forKey: "image") as? Data {
            if let image = UIImage(data: imageData) {
                cell.imageFriendView.image = image
            }
        }
        else {
            cell.imageFriendView.image = UIImage(named: "default")
        }
        
        return cell
    }
}


