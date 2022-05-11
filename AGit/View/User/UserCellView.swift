//
//  UserCellView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct UserCellView: View {
    var user: User
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(user.isStudying ? Color("Primary") : Color("Secondary"))
            
            VStack{
                ZStack {
                    Image("defaultImage")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: screenWidth/5)
                }
                
                Text(user.nickname)
                Text(secondToTime(second: user.todayStudyTime))
                
                Spacer()
                    .frame(height: 5)
            }
        }
        .frame(width: screenWidth/4, height: screenHeight/6)
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(user.isStudying ? Color("Black") : Color("White"))
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var user = User(id: 1, nickname: "poding", email: "poding" )
    
    static var previews: some View {
        UserCellView(user: user)
            .previewLayout(.fixed(width: screenWidth/4, height: screenHeight/6))
    }
}
