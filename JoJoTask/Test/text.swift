//
//  text.swift
//  Test
//
//  Created by 조용현 on 2023/05/04.
//

import SwiftUI

struct text: View {
    var body: some View {
        
        VStack {
            Rectangle()
            Rectangle()
            Spacer()
        }
    }
    
    func drawRectangle() -> some View {
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(.black, lineWidth: 2)
            .padding(10)
    }

}

struct text_Previews: PreviewProvider {
    static var previews: some View {
        text()
    }
}
