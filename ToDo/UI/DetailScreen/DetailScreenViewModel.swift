//
//  DetailScreenViewModel.swift
//  ToDo
//
//  Created by ali cihan on 24.04.2025.
//

import Foundation

class DetailScreenViewModel {
    var todoRepository = ToDoRepository()
    
    func save(title: String, description: String) {
        todoRepository.save(title: title, description: description)
    }
    
    func update(id: Int, title: String, description: String) {
        todoRepository.update(id: id, title: title, description: description)
    }
}
