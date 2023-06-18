//
//  InsightView.swift
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
        InsightContent(title: "Increase bright light exposure during the day", imageName: "lightExposure", content: "Your body has a natural time-keeping clock known as your circadian rhythm. It affects your brain, body, and hormones, helping you stay awake and telling your body when it's time to sleep. Natural sunlight or bright light during the day helps keep your circadian rhythm healthy. This improves daytime energy, as well as nighttime sleep quality and duration. In people with insomnia, daytime bright light exposure improved sleep quality and duration. It also reduced the time it took to fall asleep by 83%. A similar study in older adults found that 2 hours of bright light exposure during the day increased the amount of sleep by 2 hours and sleep efficiency by 80%. While most research involves people with severe sleep issues, daily light exposure will most likely help you even if you experience average sleep. Try getting daily sunlight exposure or - if this is not practical - invest in an artificial bright light device or bulbs."),
        InsightContent(title: "Reduce blue light exposure in the evening", imageName: "bluelight", content: "Exposure to light during the day is beneficial, but nighttime light exposure has the opposite effect. Again, this is due to its effect on your circadian rhythm, tricking your brain into thinking it's still daytime. This reduces hormones like melatonin, which help you relax and get deep sleep. Blue light - which electronic devices like smartphones and computers emit in large amounts - is the worst in this regard. There are several popular mthods you can use to reduce nighttime blue light exposure."),
        InsightContent(title: "Take a melatonin supplement", imageName: "melatonin", content: "Melatonin is a key sleep hormone that tells your brain when it's time to relax and head to bed. Melatonin supplements are an extremely popular sleep aid. Often used to treat insomnia, melatonin may be one of the easiest ways to fall asleep faster. In one study, taking 2 mg of melatonin before bed improved sleep quality and energy the next day and helped people fall asleep faster. In another study, half of the group fell asleep and had a 15% improvement in sleep quality. Additionally, no withdrawl effects were reported in either of the above studies. Melatonin is also useful when traveling and adjusting to a new time zone, as it helps your body's circadin rhythm return to normal. In some countries, you need a prescription for melatonin. In others, melatonin is widely available in stories or online. Take around 1-5mg 30-60minutes before bed. Start with a low dose to assess your tolerance and then increase it slowly as needed. Since melatonin may alter brain chemistry, it's advised that you check with a healthcare provider before use. You should also speak with them if you're thinking about using melatonin as a sleep aid for your child, as long-term use of this supplement in children has not been well studied."),
        InsightContent(title: "Don't drink alcohol", imageName: "alcohol", content: "Having a couple of drinks at a night can negatively affect your sleeps and hormones. Alcohol is known to cause or increase the symptoms of sleep apnea, snoring, and disrupted sleep patterns. It also alters nighttime melatonin production, which plays a key role in your body's circadian rhythm. Another study found that alcohol consumption at night decreased the natural nighttime elevations in human growth hormone, which plays a role in your circadian rhythm and has many other key functions."),
        InsightContent(title: "Optimize your bedroom environment", imageName: "bedroom", content: "Many people believe the bedroom environment and its setup are key factors in getting a good night's sleep. These factors include temperature, noise, external lights, and furniture arrangement. Numerous studies point out that external noise, often from traffic, can cause poor sleep and long-term health issues. In one study on the bedroom environment of women, around 50% of participants noticed imporved sleep quality when noise and light diminished. To optimize your bedroom environment, try to minimize external noise, light, and artificial lights from devices like alarm clocks. Make sure your bedroom is a quiet, relaxing, clean, and enjoyable place")
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
                                .frame(width:150, height: 120)
                                .cornerRadius(10)
                            
                            Text(insight.title)
                                .font(.headline)
                                .foregroundColor(.black)
                                .lineLimit(2)
                            
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
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            
            
            HStack(spacing: 30){
                Button(action: {}) {
                    Image(systemName: "alarm")
                        .font(.system(size: 30))
                }
                Button(action: {}) {
                    Image(systemName: "book")
                            .font(.system(size: 30))
                }
                NavigationLink(destination: SleepRecordingView()) {
                    Image(systemName: "person.fill")
                            .font(.system(size: 30))
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
            .padding(.top, 30)
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
            Image(content.imageName)
                .resizable()
                .scaledToFill()
                .frame(width:300, height: 120)
                .cornerRadius(10)
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

