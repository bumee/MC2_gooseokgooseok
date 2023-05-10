//
//  QuestionRow.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI

struct QuestionRow: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("04/24")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
                    .padding(.bottom, 1)
                
                Spacer()
            }
            
            HStack {
                Text("지난 한 주 동안 당신의 삶에서 일어난 긍정적인 일들은 무엇입니까?")
                
                Spacer()
            }
        }
    }
}

struct QuestionRow_Previews: PreviewProvider {
    static var previews: some View {
        QuestionRow()
    }
}
