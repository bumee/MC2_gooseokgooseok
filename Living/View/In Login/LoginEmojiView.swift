import SwiftUI
import Firebase

struct ClickedButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isSelected ? Color.accentColor : Color.init(uiColor: .secondarySystemBackground))
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

struct LoginEmojiView: View {
    @EnvironmentObject var emojiList : EmojiList
    @EnvironmentObject var dataBase : DataManager
    @State var SelectedEmojiList : [Bool] = [false, false, false, false, false, false, false, false]
    @State var SelectedEmojiIdx : Int = 0
    @State var userName : String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "1.circle")
                    .foregroundColor(Color(uiColor: .systemGray3))
                
                Image(systemName: "2.circle")
                    .foregroundColor(Color.accentColor)
                
                Spacer()
            }
            .padding(.bottom, 24)
            
            Text("나를 대표하는 이모지를 선택해주세요.").bold()
                .font(.largeTitle)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                HStack {
                    ForEach(0..<4) { emoji_idx in
                        Button(action: {
                            print("성공")
                            for i in 0..<SelectedEmojiList.count {
                                if SelectedEmojiList[i] {
                                    SelectedEmojiList[i] = false
                                }
                            }
                            SelectedEmojiList[emoji_idx] = true
                            SelectedEmojiIdx = emoji_idx
                        }, label: {
                            Text(emojiList.Emojis[emoji_idx])
                                .frame(width: 40, height: 40)
                        })
                        .font(.title)
                        .buttonStyle(ClickedButtonStyle(isSelected: SelectedEmojiList[emoji_idx]))
                        .disabled(false)
                        
                        if emoji_idx != 3 {
                            Spacer()
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                
                HStack {
                    ForEach(4..<8) { emoji_idx in
                        Button(action: {
                            print("성공")
                            for i in 0..<SelectedEmojiList.count {
                                if SelectedEmojiList[i] {
                                    SelectedEmojiList[i] = false
                                }
                            }
                            SelectedEmojiList[emoji_idx] = true
                            SelectedEmojiIdx = emoji_idx
                        }, label: {
                            Text(emojiList.Emojis[emoji_idx])
                                .frame(width: 40, height: 40)
                        })
                        .font(.title)
                        .buttonStyle(ClickedButtonStyle(isSelected: SelectedEmojiList[emoji_idx]))
                        .disabled(false)
                        
                        if emoji_idx != 7 {
                            Spacer()
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
            }
            
            Spacer()
            
            NavigationLink(destination: MainView(userName: userName, isLoggedIn: true, SelectedEmojiIdx: SelectedEmojiIdx))
            {
                Text("완료").bold()
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(SelectedEmojiList.contains(true) ? Color.accentColor : Color(uiColor: .secondarySystemBackground))
                    .foregroundColor(SelectedEmojiList.contains(true) ? .white : .gray)
                    .cornerRadius(16)
            }
            .disabled(userName == "")
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
    }
}
