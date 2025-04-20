//
//  CreateScreen.swift
//  ToDo
//
//  Created by ali cihan on 17.04.2025.
//

import UIKit

class CreateScreen: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    var onSave: ((ToDo) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 8.0
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
    @IBAction func saveButton(_ sender: Any) {
        save()
    }
    
    private func save() {
        if let title = titleTextField.text,
           let description = descriptionTextView.text {
            let todo = ToDo(title: title, description: description)
            onSave?(todo) // Call the closure to pass data back
            navigationController?.popViewController(animated: true)
        }
    }
    
}
