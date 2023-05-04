//
//  MessageView.swift
//  TestSumone
//
//  Created by kibum on 2023/05/03.
//

import Foundation
import SwiftUI

struct MessageShowingView: View {
    
    var body: some View {
        MessageBubbleView(message: "됐나?", isFromCurrentUser: false)
        MessageBubbleView(message: "해치웠나?", isFromCurrentUser: true)
    }
}
