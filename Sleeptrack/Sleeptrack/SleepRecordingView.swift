//
//  SleepRecordingView.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//

import SwiftUI
import Foundation
struct SleepEntry {
    var roomTemperature: Double?
    var lighting: String?
    var exercise: Bool
    var foodIntake: String?
}

struct SleepRecordingView: View {

    let myDB = DB_Manager.shared
    @State var sleepQuality: String = ""
    @State var TimeInBed_h: String = ""
    @State var TimeInBed_m: String = ""
    @State var TimeAsleep_h: String = "00"
    @State var TimeAsleep_m: String = "00"
   
    @State private var sleepEntry = SleepEntry(exercise: false)

 
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        ScrollView{
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                        .frame(width: 350, height: 200)
                    HStack{
                        ZStack{
                            Circle()
                                .foregroundColor(Color.blue.opacity(0.4))
                                .frame(width: 170, height: 170)
                            Circle()
                                .foregroundColor(Color.blue.opacity(0.2))
                                .frame(width: 150, height: 150)
                            VStack{
                                HStack(alignment: .center) {
                                    TextField("00", text: $sleepQuality)
                                        .font(.title)
                                        .keyboardType(.numberPad)
                                        .frame(width: 50)
                                    Text("%")
                                        .font(.title)
                                }
                                Text("Quality")
                            }
                            .padding()
                        }
                        VStack{
                            HStack{
                                TextField("00", text: $TimeInBed_h)
                                    .font(.title)
                                    .keyboardType(.numberPad)
                                    .frame(width: 50)
                                    .padding(.horizontal, -30.0)
                                Text("h")
                                    .font(.title)
                                    
                                TextField("00", text: $TimeInBed_m)
                                    .font(.title)
                                    .keyboardType(.numberPad)
                                    .frame(width: 50)
                                    .padding(.trailing, -18.0)
                                Text("m")
                                    .font(.title)
                            }
                            .padding(.horizontal, 37.0)
                            
                            Text("Time in bed")
                            HStack{
                                TextField("00", text: $TimeAsleep_h)
                                    .font(.title)
                                    .keyboardType(.numberPad)
                                    .frame(width: 50)
                                    .padding(.horizontal, -30.0)
                                Text("h")
                                    .font(.title)
                                    
                                TextField("00", text: $TimeAsleep_m)
                                    .font(.title)
                                    .keyboardType(.numberPad)
                                    .frame(width: 50)
                                    .padding(.trailing, -18.0)
                                Text("m")
                                    .font(.title)
                            }
                            .padding(.horizontal, 37.0)
                            Text("Time asleep")
                        }
                    }
                }
                ZStack{
        //            RoundedRectangle(cornerRadius: 10)
        //                .stroke(Color.blue, lineWidth: 2)
        //                .frame(width: 350, height: 200)
        //                .padding()
                    VStack{
                        VStack {
                            Text("Sleep Environment")
                                .font(.headline)
                                .padding(.top)

                            TextField("Room Temperature", value: $sleepEntry.roomTemperature, formatter: NumberFormatter())
                                .keyboardType(.decimalPad)
                                .padding(.horizontal)
                            
                            TextField("Sleeping Place", value: $sleepEntry.roomTemperature, formatter: NumberFormatter())
                                .keyboardType(.decimalPad)
                                .padding(.horizontal)
                            
                            TextField("Light environment", value: $sleepEntry.roomTemperature, formatter: NumberFormatter())
                                .keyboardType(.decimalPad)
                                .padding(.horizontal)

                        }
                        .padding()
                        VStack{
                            VStack {
                                Text("Pre-Sleep Habits")
                                    .font(.headline)
                                    .padding(.top)
                                Toggle("Exercise", isOn: $sleepEntry.exercise)
                                    .padding(.horizontal)
                                TextField("Last food intake time", value: $sleepEntry.roomTemperature, formatter: NumberFormatter())
                                    .keyboardType(.decimalPad)
                                    .padding(.horizontal)
                            }
                            .padding()
                            // Save sleep data button
                            Button(action: {
                                //let dbManager: DB_Manager = DB_Manager()
//                                DB_Manager.shared.insertData("sleepData",["sleepQualityValue","TimeInBed_hValue","TimeInBed_mValue"],[self.sleepQuality, self.TimeInBed_h, self.TimeInBed_m])


                                    // Create a DateFormatter to format the date
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd" // Set your
                                let date = "2023-06-20" // 직접 지정한 날짜
                                let currentDate = Date()
                                let dateString = dateFormatter.string(from: currentDate)
                                print(type(of: dateString))
                                print(type(of: myDB))
                                DB_Manager.shared.insertData("sleepData", ["sleepQualityValue", "TimeInBed_hValue", "TimeInBed_mValue"], [self.sleepQuality, self.TimeInBed_h, self.TimeInBed_m])


                            }) {
                                Text("Save Sleep Data")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding()
                        }
                    }
                    // Pre-sleep habits input
                }
                HStack(spacing: 30){
                    Button(action: {}) {
                        Image(systemName: "alarm")
                            .font(.system(size: 30))
                    }
                    NavigationLink(destination: InsightView()){
                        Image(systemName: "book")
                                .font(.system(size: 30))
                    }
                    Button(action: {}) {
                        Image(systemName: "person.fill")
                                .font(.system(size: 30))
                    }
                    NavigationLink(destination: StatisticsView()) {
                        Image(systemName: "chart.bar.xaxis")
                                .font(.system(size: 30))
                    }
                }
                .padding(.top, 30)
                .padding()
            }
        }
    }
    
}

struct SleepRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        SleepRecordingView()
    }
}

