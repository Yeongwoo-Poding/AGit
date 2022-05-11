//
//  SettingView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        NavigationView{
            VStack {
                ZStack {
                    Color("Background")
                    
                    VStack(spacing: 20){
                        NavigationLink(destination: ProfileView()) {
                            HStack{
                                Image("defaultImage")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(height: screenHeight/6)
                                
                                Spacer().frame(width: 30)
                                
                                Text(userModel.user?.nickname ?? "Guest")
                                    .font(.custom(fontStyle, size: titleFontSize))
                                
                                Spacer()
                                    
                            }
                            .padding()
                            .frame(width: screenWidth*9/10, height: screenWidth/3)
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("Secondary"))
                            }
                        }
                        
                        Button(action: {
                            userModel.signOut()
                        }) {
                            Text("로그아웃")
                                .padding()
                                .frame(width: screenWidth*9/10, height: screenWidth/8)
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Secondary"))
                                }
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
                
                Color.black
                    .frame(height: 5)
            }
            .navigationBarTitle("Setting")
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("White"))
    }
}

struct SettingView_Previews: PreviewProvider {
    @State static var hasBackButton = false
    
    static var previews: some View {
        SettingView()
            .environmentObject(UserModel())
    }
}
