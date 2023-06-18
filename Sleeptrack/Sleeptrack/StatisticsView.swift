//
//  StatisticsView.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//
import SwiftUI
import Foundation
struct AnyHashableWrapper: Hashable {
    let value: Any

    init(_ value: Any) {
        self.value = value
    }

    static func == (lhs: AnyHashableWrapper, rhs: AnyHashableWrapper) -> Bool {
        if let lhsValue = lhs.value as? AnyHashable, let rhsValue = rhs.value as? AnyHashable {
            return lhsValue == rhsValue
        }
        return false
    }

    func hash(into hasher: inout Hasher) {
        if let hashableValue = value as? AnyHashable {
            hasher.combine(hashableValue)
        } else {
            // Implement a custom hash function based on your requirements
            hasher.combine("\(value)")
        }
    }
}
struct BarChartView: View {
    let dataPoints: [String]
    let values: [Int]
    let title: String
    @Binding var selectedIndex: Int?

    var body: some View {
        VStack {
            Text(title)
               // .font(.headline)
                .font(.system(size: 20))
                .padding(.bottom, 50)
            //Spacer()
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(0..<dataPoints.count, id: \.self) { index in
                    VStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 30, height: CGFloat(values[index]) * 10)
                            .border(selectedIndex == index ? Color.black : Color.clear, width: 2)
                            .onTapGesture {
                                selectedIndex = index
                            }
                        Text(dataPoints[index])
                            .font(.caption)
                    }
                    
                }
            }
        }
    }
}

struct StatisticsView: View {
    
    //@State private var sleepData: [[String: String]] = []
    
    
    @State private var selectedDate = Date()
    @State var userModels: [UserModel] = []
    @State private var startDate = Date()
    
    @State private var selectedIndex: Int? = nil
    //@State private var sleepDataArray: [AnyHashableWrapper] = []
    // Example sleep duration data for each day of the week
    let dataPoints = ["Sun","Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let sleepDurationData = [6, 7, 8, 5, 6, 7, 6]
  // let sleepDurationData: [Double] = [6.5, 7.2, 8.0, 6.8, 7.5, 6.3, 7.8]
    let dates = ["2022-06-18", "2022-06-19", "2022-06-20", "2022-06-21", "2022-06-22", "2022-06-23", "2022-06-24"]
    let dbManager = DB_Manager.shared
    let tableName = "sleepData"
    let columns = ["sleepQualityValue", "TimeInBed_hValue", "TimeInBed_mValue"]

    @State private var sleepData: Dictionary<Int, Any> = [:]
    private var sleepDataArray: [AnyHashableWrapper] {
        let sleepData = DB_Manager.shared.readData("sleepData", ["sleepQualityValue", "TimeInBed_hValue", "TimeInBed_mValue"])
        print(sleepData)
       // print(Array(sleepData.values).map(AnyHashableWrapper.init))
        return Array(sleepData.values).map(AnyHashableWrapper.init)
    }
    var body: some View {
        VStack {
            ForEach(sleepDataArray, id: \.self) { item in
                if let item = item.value as? [String: String],
                   let sleepQuality = item["sleepQualityValue"],
                   let timeInBed_h = item["TimeInBed_hValue"],
                   let timeInBed_m = item["TimeInBed_mValue"] {
                    Text("Sleep Quality: \(sleepQuality), Time in Bed (hours): \(timeInBed_h), Time in Bed (minutes): \(timeInBed_m)")
                }
            }

            ZStack{
                Text(weekOfMonthText(for: startDate))
                        .font(.headline)
                        .padding(.top, 16)
                HStack {
                    Button(action: {
                        startDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: startDate) ?? startDate
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        startDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startDate) ?? startDate
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                }
            }
            
            BarChartView(dataPoints: dataPoints, values: sleepDurationData, title: "Sleep Duration (Hours)", selectedIndex: $selectedIndex)
                    .frame(height: 300)
                    .padding()
                
                if let selectedIndex = selectedIndex {
                    Text("Sleep Duration: \(sleepDurationData[selectedIndex]) Hours")

                    Text("Selected Date: \(dates[selectedIndex])")
                        .padding(0.2)
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
                Button(action: {}) {
                    Image(systemName: "chart.bar.xaxis")
                            .font(.system(size: 30))
                }
            }
            .padding(.top, 100)
            //.padding()
        }
        //.padding()
        .onAppear {
                    // Load the sleep data from the database when the view appears
            sleepData = DB_Manager.shared.readData("sleepData",["sleepQualityValue", "TimeInBed_hValue", "TimeInBed_mValue"])
           // dbManager.saveAsCSV(dbPath: "mySqlite.sqlite3", tableName: "sleepData", outputPath: "sleepData")
            
            //DB_Manager.shared.insertData("sleepData", ["sleepQualityValue", "TimeInBed_hValue", "TimeInBed_mValue"], [self.sleepQuality, self.TimeInBed_h, self.TimeInBed_m])
        }

    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    
    func weekOfMonthText(for date: Date) -> String {
            let calendar = Calendar.current
            let weekOfMonth = calendar.component(.weekOfMonth, from: date)
            let month = calendar.component(.month, from: date)
            let monthSymbols = calendar.shortMonthSymbols
           // print(dbManager.readData(tableName, columns))
            return "\(ordinalNumber(weekOfMonth)) week of \(monthSymbols[month - 1])"
        }
        
        func ordinalNumber(_ number: Int) -> String {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .ordinal
            return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
        }
    


}



struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
    
}
