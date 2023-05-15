//
//  AnswerTextData.swift
//  TestSumone
//
//  Created by g eun on 2023/05/08.
//

import SwiftUI

class AnswerTextData: ObservableObject {
    
    @Published var note = ""
    
    var updating: Bool { note != ""}
    var incomplete: Bool {
        note == ""
    }
}
