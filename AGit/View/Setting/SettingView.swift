//
//  SettingView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var userModel: UserModel
    @Binding var hasBackButton: Bool
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                NavigationBarView(title: "Setting", hasBackButton: false)
                
                NavigationLink(destination: ProfileView()) {
                    HStack{
                        Image("defaultImage")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: screenWidth/4, height: screenWidth/4)
                        
                        Spacer().frame(width: 30)
                        
                        Text(userModel.user?.nickname ?? "Guest")
                            .font(.custom(fontStyle, size: titleFontSize))
                        
                        Spacer()
                            
                    }
                    .padding()
                    .frame(width: screenWidth*9/10, height: screenWidth/3+20)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("gray"))
                    }
                }
                
                Button(action: {
                    userModel.signOut()
                }) {
                    HStack{
                        Spacer().frame(width: 10)
                        Text("로그아웃")
                            .font(.custom(fontStyle, size: titleFontSize))
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: screenWidth*9/10, height: 70)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("gray"))
                    }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("black"))
    }
}

struct SettingView_Previews: PreviewProvider {
    @State static var hasBackButton = false
    
    static var previews: some View {
        SettingView(hasBackButton: $hasBackButton)
            .environmentObject(UserModel())
    }
}
