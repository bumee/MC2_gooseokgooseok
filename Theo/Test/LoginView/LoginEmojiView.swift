//
//  LoginEmojiView.swift
//  Test
//
//  Created by 박상준 on 2023/05/04.
//

import SwiftUI

struct LoginEmojiView: View {
    @State var userName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "1.circle")
                    .foregroundColor(Color(uiColor: .systemGray3))
                
                Image(systemName: "2.circle")
                    .foregroundColor(Color.blue)
                
                Spacer()
            }
            .padding(.bottom, 24)
            
            Text("나를 대표하는 이모지를 선택해주세요.").bold()
                .font(.largeTitle)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("👵🏻")
                            .frame(width: 40, height: 40)
                    })
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("👴🏻")
                            .frame(width: 40, height: 40)
                    })
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("👨🏻")
                            .frame(width: 40, height: 40)
                    })
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("🧑🏻")
                            .frame(width: 40, height: 40)
                    })
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("🧑🏻‍🦱")
                            .frame(width: 40, height: 40)
                    })
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("👩🏻")
                            .frame(width: 40, height: 40)
                    })
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("👧🏻")
                            .frame(width: 40, height: 40)
                    })
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("👦🏻")
                            .frame(width: 40, height: 40)
                    })
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
            }
            
            
            Spacer()
            
            Button(action: {
            }, label: {
                Text("완료").bold()
                    .frame(maxWidth: .infinity, maxHeight: 40)
            })
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct loginEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmojiView()
    }
}
