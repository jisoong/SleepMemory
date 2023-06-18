//
//  GoodNightView.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//

import SwiftUI

struct GoodNightView: View {
    var alarmTime: Date
    
    @State private var isMicOn = false
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Goodnight")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(70)
                    //.background(Color.blue)
                    //.clipShape(Circle())
                    .background(
                            Image("moon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 400, height: 400)
                )
                    .padding(.bottom, 100)
                
                HStack {
                    Image(systemName: "alarm")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Text("Alarm Time: \(formattedTime)")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .padding(.top, 20)

                
                Image(systemName: isMicOn ? "mic.fill" : "mic.slash.fill")
                    .font(.title)
                    .foregroundColor(isMicOn ? .red : .black)
                    .onTapGesture {
                        isMicOn.toggle()
                }
                
                Spacer()
            }
            
            
        }
    }
    
    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: alarmTime)
    }
}

struct GoodNightView_Previews: PreviewProvider {
    static var previews: some View {
        GoodNightView(alarmTime: Date())
    }
}
