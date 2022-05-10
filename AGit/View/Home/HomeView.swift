//
//  HomeView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userModel: UserModel
    
    @State var incTime = 0
    
    var body: some View {
        VStack{
            NavigationBarView(title: "Home", hasBackButton: false)
            Spacer()
            
            VStack{
                Button(action: {
                    incTime = 0
                    
                    if userModel.user != nil{
                        userModel.updateUser()
                    }
                }) {
                        Image(systemName: "lightbulb.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("white"))
                            .background{
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: 200, height: 200)
                                    .foregroundColor(userModel.user != nil ? (userModel.user!.isStudying ? Color("primary") : Color("gray")) : Color("gray"))
                    }
                }
            }
            
            Spacer().frame(height: 100)
            
            HStack{
                VStack{
                    Text("현재 공부 시간")
                    Text(secondToTime(second: userModel.user != nil ? (userModel.user!.curStudyTime + incTime) : 0))
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 120, height: 50)
                        .foregroundColor(Color("gray"))
                }
                
                VStack{
                    Text("오늘 공부 시간")
                    Text(secondToTime(second: userModel.user != nil ? (userModel.user!.todayStudyTime + incTime) : 0))
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 120, height: 50)
                        .foregroundColor(Color("gray"))
                }
            }
            .onReceive(timer) { _ in
                if userModel.user != nil && userModel.user!.isStudying{
                    incTime+=1
                }
            }
            
            Spacer()
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("black"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserModel())
    }
}
