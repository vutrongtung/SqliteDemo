//
//  ViewController.swift
//  DemoProject
//
//  Created by ANHTT-D1 on 7/20/18.
//  Copyright © 2018 anhtt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var rikkeiIOS = [RikkeiIOS]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readData()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func readData() {
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("friend.sqlite")
        let database = FMDatabase(path: fileURL.path)
        print(fileURL.path)
        
        if !database.open() {
            print("Unable to open database")
            return
        }
        print(database)
        do {
//            let result = try database.executeQuery("drop table friend", values: nil)
            let result = try database.executeQuery("SELECT * from friend", values: nil)
            while result.next() {

                rikkeiIOS.append(RikkeiIOS(name: result.string(forColumn: "name")!,
                                           image: result.string(forColumn: "image_path")!,
                                           phone: result.string(forColumn: "phone_number")!))
            }
        }
        catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
        self.tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rikkeiIOS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SQLCell", for: indexPath) as! SQLTableViewCell
        cell.label.text = rikkeiIOS[indexPath.row].name
        cell.phoneLabel.text = rikkeiIOS[indexPath.row].phone
        cell.imageRikkeiView.image = UIImage(data: (rikkeiIOS[indexPath.row].image?.data(using: .utf8)!)!)
        return cell
    }
}
