//
//  ProfileVC.swift
//  DOGGO
//
//  Created by Lobster on 13.01.23.
//

import Foundation
import UIKit

final class ProfileVC: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet private weak var birthdayTextField: UITextField! {
        didSet {
            
        }
    }
    @IBOutlet private weak var weightTextField: UITextField!  {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet private weak var appIconImageView: UIImageView! {
        didSet {
            appIconImageView.layer.cornerRadius = 15.0
        }
    }
    @IBOutlet private weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.isUserInteractionEnabled = false
            avatarImageView.layer.borderWidth = 3.0
            avatarImageView.layer.cornerRadius = 15.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserInfo()
        
        nameTextField.setupTextField(isEnabled: false)
        birthdayTextField.setupTextField(isEnabled: false)
        weightTextField.setupTextField(isEnabled: false)
        
        
        setupDatePicker()
        setupBarItem()
        addDoneButtonOnKeyboard()
        
    }
    
}

extension ProfileVC {
    
    private func setupDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDidTap))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        let datePicker = UIDatePicker()
        let nowDate = Date()
        birthdayTextField.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = nowDate
        datePicker.minimumDate = nowDate - 631152000
        birthdayTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateDidChanged(_:)), for: .valueChanged)
        
    }
    
    @objc private func doneDidTap() {
        birthdayTextField.resignFirstResponder()
    }
    
    @objc private func dateDidChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        birthdayTextField.text = dateFormatter.string(from: selectedDate)
    }
    
    private func setupBarItem() {
        navigationItem.title = "Profile"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil.circle"), style: .plain, target: self, action: #selector(editProfileDidTap(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func editProfileDidTap(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(systemName: "square.and.pencil.circle") {
//            sender.title = "Done"
            sender.image = UIImage(systemName: "square.and.pencil.circle.fill")
            nameTextField.setupTextField(isEnabled: true)
            birthdayTextField.setupTextField(isEnabled: true)
            weightTextField.setupTextField(isEnabled: true)
            avatarImageView.isUserInteractionEnabled = true
            selectAvatarGesture()
        } else if nameTextField.hasText, birthdayTextField.hasText, weightTextField.hasText, (avatarImageView.image?.imageAsset != nil) {
//            sender.title = "Edit"
            sender.image = UIImage(systemName: "square.and.pencil.circle")
            saveUserInfo()
            nameTextField.setupTextField(isEnabled: false)
            birthdayTextField.setupTextField(isEnabled: false)
            weightTextField.setupTextField(isEnabled: false)
            avatarImageView.isUserInteractionEnabled = false
        }
    }
    
    private func saveUserInfo() {
        guard let name = nameTextField.text, !name.isEmpty,
              let birthday = birthdayTextField.text, !birthday.isEmpty,
              let weight = weightTextField.text, !weight.isEmpty,
              let image = avatarImageView.image?.jpegData(compressionQuality: 1)
        else { return }
        let modelProfile = Profile(dogAvatar: image, dogName: name, dogAge: birthday, dogWeight: weight)
        if let jsonData = try? JSONEncoder().encode(modelProfile) {
            let jsonDescription = String(data: jsonData, encoding: .utf8)
            let ud = UserDefaults.standard
            ud.set(jsonDescription, forKey: "ModelProfile")
        }
    }
    
    private func loadUserInfo() {
        let ud = UserDefaults.standard
        if let jsonDescription = ud.string(forKey: "ModelProfile") {
            if let jsonData = jsonDescription.data(using: .utf8) {
                let profile = try? JSONDecoder().decode(Profile.self, from: jsonData)
                guard let dataAvatar = profile?.dogAvatar,
                      let image = UIImage(data: dataAvatar),
                      let name = profile?.dogName,
                      let birthday = profile?.dogAge,
                      let weight = profile?.dogWeight
                else { return }
                avatarImageView.image = image
                nameTextField.text = name
                birthdayTextField.text = birthday
                weightTextField.text = weight
            }
        }
    }
    
    private func selectAvatarGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDidTap(_:)))
        self.avatarImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageDidTap(_ gesture: UITapGestureRecognizer) {
        presentGalery()
    }
    
    
}

extension ProfileVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func presentGalery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    // func to take photo from galery and use them for avatar
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImageView.image = pickedImage
        }
        dismiss(animated: true)
    }
    
}

extension ProfileVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
        } else if textField == weightTextField {
            weightTextField.resignFirstResponder()
        }
        return true
    }
    
    func addDoneButtonOnKeyboard(){
        
        let doneToolbar = UIToolbar()
//            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            weightTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            weightTextField.resignFirstResponder()
        }
    
}
