//
//  Setting.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import Foundation
import SwiftUI

let domain = "http://www.poding.site/AGit"

let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

let dateFormatter = DateFormatter()

func secondToTime(second: Int) -> String{
    let h = String(format: "%02d", second/3600)
    let m = String(format: "%02d", (second%3600)/60)
    let s = String(format: "%02d", second%60)
    
    return h + ":" + m + ":" + s
}

let titleFontSize: CGFloat = 24.0
let bodyFontSize: CGFloat = 18.0
let captionFontSize: CGFloat = 12.0
let fontStyle = "LeeSeoyun"

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
