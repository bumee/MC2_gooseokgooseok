//
//  CalendarRow.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI

struct CalendarRow: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 8)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
                Text("05/24")
                    .font(.footnote)
                    .opacity(0.6)
                
                Spacer()
            }
            
            HStack {
                Text("엄마 생일")
                
                Spacer()
            }
        }
    }
}

struct CalendarRow_Previews: PreviewProvider {
    static var previews: some View {
        CalendarRow()
    }
}
