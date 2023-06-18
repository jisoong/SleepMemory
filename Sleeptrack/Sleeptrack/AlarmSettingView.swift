//
//  AlarmSettingView.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//
import SwiftUI

struct AlarmSettingView: View {
    @EnvironmentObject private var alarmManager: AlarmManager
    @Binding var isAlarmSet: Bool
    @State private var isTableCreated = false
    var body: some View {
        VStack {
            DatePicker("Set Alarm", selection: $alarmManager.alarmTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding()
            if let text = alarmManager.wakeUpText {
                Text(text)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            }
            Button(action: {
                alarmManager.setAlarm()
            }) {
                Text("Set Alarm")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }
            .padding()
            
            NavigationLink(destination: GoodNightView(alarmTime: alarmManager.alarmTime), isActive: $isAlarmSet) {
                Text("Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            HStack(spacing: 30){
                Button(action: {}) {
                    Image(systemName: "alarm")
                        .font(.system(size: 30))
                }
                NavigationLink(destination: InsightView()) {

                    Image(systemName: "book")
                            .font(.system(size: 30))
                }
                NavigationLink(destination: SleepRecordingView()) {
                    Image(systemName: "person.fill")
                            .font(.system(size: 30))
                }
                .onAppear {
                    // Check if the table is already created
                        // Create the "sleepData" table
                    //DB_Manager.shared.createTable("sleepData", ["id", "sleepQualityValue", "TimeInBed_hValue", "TimeInBed_mValue"])
                    //DB_Manager.shared.deleteTable("sleepData")

                    DB_Manager.shared.createTable("sleepData", ["id", "sleepQualityValue", "TimeInBed_hValue", "TimeInBed_mValue"])

                    // Set the flag to indicate that the table is created
                    isTableCreated = true
                    
                }
                NavigationLink(destination: StatisticsView()) {
//                    Text("Statistics")
//                        .font(.system(size: 16))
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                        .frame(width: 70, height: 40)
                    Image(systemName: "chart.bar.xaxis")
                            .font(.system(size: 30))
                }
            }
            .padding(.top, 100)
            .padding()
            
            
        }
    }
}

