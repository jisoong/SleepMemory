//
//  ContentView.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//

import SwiftUI

struct LoadingView: View {
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            if isLoading {
                Image("moon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                Text("Sleep Memory")
                    .font(.system(size: 30))
            } else {
                ContentView()
            }
        }
        .onAppear {
            // Simulate loading delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var alarmManager = AlarmManager()
    @State private var isAlarmSet = false
    @State var userModels: [UserModel] = []
    
    var body: some View {
        NavigationView {
            VStack {
                AlarmSettingView(isAlarmSet: $isAlarmSet)
                    .environmentObject(alarmManager)

                NavigationLink(destination: GoodNightView(alarmTime: alarmManager.alarmTime), isActive: $isAlarmSet) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarTitle("Alarm")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
