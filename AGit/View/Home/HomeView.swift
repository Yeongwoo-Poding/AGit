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
        NavigationView{
            VStack {
                ZStack {
                    Color("Background")
                    
                    VStack{
                        if userModel.user != nil && userModel.user!.isStudying{
                            Image("custom.bulb.on")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350)
                                .onTapGesture {
                                    incTime = 0
                                    userModel.updateUser()
                                }
                        }else{
                            Image("custom.bulb.off")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350)
                                .onTapGesture {
                                    userModel.updateUser()
                                }
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("Secondary"))
                                .frame(width: screenWidth*5/6, height: 50)
                            
                            VStack {
                                Text("현재 공부 시간")
                                
                                if let user = userModel.user{
                                    Text(secondToTime(second: user.curStudyTime + incTime))
                                }
                            }
                        }
                        
                        Spacer().frame(height: 15)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("Secondary"))
                                .frame(width: screenWidth*5/6, height: 50)
                            
                            VStack {
                                Text("오늘 공부 시간")
                                
                                if let user = userModel.user{
                                    Text(secondToTime(second: user.todayStudyTime + incTime))
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
                
                Color.black
                    .frame(height: 5)
            }
            .onReceive(timer, perform: { _ in
                if userModel.user != nil && userModel.user!.isStudying{
                    incTime += 1
                }
            })
            .navigationTitle("Home")
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("White"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserModel())
    }
}
