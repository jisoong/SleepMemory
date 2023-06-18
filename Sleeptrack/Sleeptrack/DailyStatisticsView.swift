//
//  DailyStatisticsView.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//

import SwiftUI

struct InsightView: View {
    struct InsightContent: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
        let content: String
    }
    
    @State private var selectedInsight: InsightContent?
    
    let insights: [InsightContent] = [
        InsightContent(title: "Insight 1", imageName: "image1", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        InsightContent(title: "Insight 2", imageName: "image2", content: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        InsightContent(title: "Insight 3", imageName: "image3", content: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                ForEach(insights) { insight in
                    Button(action: {
                        selectedInsight = insight
                    }) {
                        VStack(alignment: .leading) {
                            Image(insight.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 120)
                                .cornerRadius(10)
                            
                            Text(insight.title)
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            Text(insight.content)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .sheet(item: $selectedInsight) { insight in
            ReadContentView(content: insight)
        }
    }
}

struct ReadContentView: View {
    let content: InsightView.InsightContent
    
    var body: some View {
        VStack {
            Text(content.title)
                .font(.title)
                .padding()
            
            Text(content.content)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle(Text("Insight"), displayMode: .inline)
    }
}
