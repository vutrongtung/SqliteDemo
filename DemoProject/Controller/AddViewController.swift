//
//  AddViewController.swift
//  DemoProject
//
//  Created by ANHTT-D1 on 7/20/18.
//  Copyright © 2018 anhtt. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imagePickView: UIImageView!
    @IBOutlet weak var phoneTextField: UITextField!
    
   
    var viewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveTapped(_ sender: Any) {
        //Save Image
        var imageData: Data = imagePickView.image!.pngData()!
        
        //Save
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("friend.sqlite")
        let database = FMDatabase(path: fileURL.path)
        
        if !database.open() {
            print("Unable to open database")
            return
        }
        
        do {
            try database.executeUpdate("insert into friend (name, image_path, phone_number) values (?, ?, ?)",
                                       values: ["\(nameTextField.text ?? "")",
                                                "\(imageData)",
                                                "\(phoneTextField.text ?? "")"])
        }
        catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
    }
    
    
    @IBAction func pickImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.imagePickView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
