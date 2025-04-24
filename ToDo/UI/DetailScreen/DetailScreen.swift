//
//  DetailScreen.swift
//  ToDo
//
//  Created by ali cihan on 17.04.2025.
//

import UIKit

class DetailScreen: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    var todo: ToDo?
    var detailScreenViewModel = DetailScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 8.0
        if let todo = todo {
            titleTextField.text = todo.title
            descriptionTextView.text = todo.description
        }
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
           let description = descriptionTextView.text,
            let todo = todo {
            detailScreenViewModel.update(id: todo.id!, title: title, description: description)
            navigationController?.popViewController(animated: true)
        }
    }
}
