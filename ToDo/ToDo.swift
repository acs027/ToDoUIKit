//
//  ToDo.swift
//  ToDo
//
//  Created by ali cihan on 17.04.2025.
//

import Foundation

class ToDo {
    let id: UUID = UUID()
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
