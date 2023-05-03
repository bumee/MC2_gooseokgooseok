//
//  TalkRow2.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TalkRow2: View {
    var date: String
    var qustion: String
    
    var body: some View {
        VStack {
            HStack {
                Text(date)
                    .font(.footnote)
                    .opacity(0.6)
                    .foregroundColor(.gray)
                    .padding(.bottom, 1)
                Spacer()
            }
            
            HStack {
                Text(qustion)
                    .foregroundColor(.gray)
                    .truncationMode(.tail)
                Spacer()
            }
        }
    }
}

struct TalkRow2_Previews: PreviewProvider {
    static var previews: some View {
        TalkRow2(date: "04/20", qustion: "가족이 가장 자랑스러운 순간은 언제인가요?")
    }
}
