//
//  CreateScreenViewModel.swift
//  ToDo
//
//  Created by ali cihan on 24.04.2025.
//

import Foundation

class CreateScreenViewModel {
    var todoRepository = ToDoRepository()
    
    func save(title: String, description: String) {
        todoRepository.save(title: title, description: description)
    }
}
