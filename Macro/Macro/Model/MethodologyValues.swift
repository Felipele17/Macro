//
//  MethodologyValues.swift
//  Macro
//
//  Created by Gabriele Namie on 01/11/22.
//

import SwiftUI

struct MethodologyValues: Identifiable, Hashable, Equatable {
    var id = UUID()
    var tag: Int
    var images: String
    var title: String
    var description: String
    var example: String
    
    init(id: UUID = UUID(), tag: Int, images: String, title: String, description: String, example: String) {
        self.id = id
        self.tag = tag
        self.images = images
        self.title = title
        self.description = description
        self.example = example
    }
}
