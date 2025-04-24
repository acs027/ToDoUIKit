//
//  ToDo.swift
//  ToDo
//
//  Created by ali cihan on 17.04.2025.
//

import Foundation

class ToDo {
    var id: Int?
    var title: String?
    var description: String?
    
    init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}
