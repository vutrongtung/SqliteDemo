//
//  EditViewController.swift
//  CoreDataDemo
//
//  Created by ANHTT-D1 on 7/24/18.
//  Copyright © 2018 RikkeiIOS. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imagePickView: UIImageView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var friends: [Friend] = []
    var friend: Friend?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetail()
        getData()
        addGesture(image: imagePickView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        do {
            friends = try context.fetch(Friend.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    func setupDetail() {
        
        nameTextField.text = friend?.name
        phoneTextField.text = friend?.phone_number
        if let imageData = friend?.value(forKey: "image") as? Data {
            if let image = UIImage(data: imageData) {
                imagePickView.image = image
            }
        }
        else {
            imagePickView.image = UIImage(named: "default")
        }
    }
    
    func addGesture(image: UIImageView) {
        image.isUserInteractionEnabled = true
        image.isMultipleTouchEnabled = true
        image.addGestureRecognizer(setTapRecognizer())
    }
    
    func setTapRecognizer() -> UITapGestureRecognizer {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        gestureRecognizer.delegate = self
        return gestureRecognizer
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        friends[index!].name = nameTextField.text
        friends[index!].phone_number = phoneTextField.text
        let saveImageData = UIImageJPEGRepresentation(imagePickView.image!, 1)
        friends[index!].setValue(saveImageData, forKey: "image")
        
        appDelegate.saveContext()

        let _ = navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imagePickView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}
