//
//  WaitingQuestionNameView.swift
//  TestSumone
//
//  Created by kibum on 2023/05/03.
//

import Foundation
import SwiftUI

struct WaitingQuestionNameView: View {
    var text : String
    
    var body: some View {
        VStack {
            HStack {
                Text(text)
                    .font(.headline)
                Spacer()
            }
        }
    }
}
