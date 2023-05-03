//
//  TextStruct.swift
//  Test
//
//  Created by 조용현 on 2023/05/03.
//

import Foundation

class TextStruct: ObservableObject {
    @Published var note = ""

    var updating: Bool { note != "" }
    var incomplete: Bool {
        note.isEmpty
    }
}
