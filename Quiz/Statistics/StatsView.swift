//
//  StatsView.swift
//  Quiz
//
//  Created by Sandro Boka on 07.07.2024..
//

import Foundation
import SwiftUI
import RealmSwift

struct StatsView: View {
   
    @State private var stats: StatsModelEntity?
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack() {
            HStack {
                Button {
                    router.navigateTo(.home)
                } label: {
                    Image(systemName: "chevron.backward")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.white)
                }
                
                Spacer()
                
                Text("Statistics")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(Color.headerColor)
            
            ScrollView {
                if let stats = stats {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Total Questions Answered:")
                                .font(.headline)
                            Spacer()
                            Text("\(stats.numAnswered)")
                                .font(.body)
                        }
                        
                        HStack {
                            Text("Correct Answers:")
                                .font(.headline)
                            Spacer()
                            Text("\(stats.numCorrect)")
                                .font(.body)
                        }
                        
                        HStack {
                            Text("Best Score:")
                                .font(.headline)
                            Spacer()
                            Text("\(stats.bestScore)")
                                .font(.body)
                        }
                        
                        HStack {
                            Text("Number of Dash Games:")
                                .font(.headline)
                            Spacer()
                            Text("\(stats.dashNum)")
                                .font(.body)
                        }
                        
                        HStack {
                            Text("Number of Normal Games:")
                                .font(.headline)
                            Spacer()
                            Text("\(stats.normalNum)")
                                .font(.body)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
                    
                    VStack {
                        HStack {
                            Spacer()
                            CircleGraph(numAnswered: stats.numAnswered, numCorrect: stats.numCorrect)
                                .frame(width: 280, height: 280)
                                .padding(.top, 50)
                            Spacer()
                        }
                        
                        Text("Correct percentage")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top, 15)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            GameRatioGraph(dashNum: stats.dashNum, normalNum: stats.normalNum)
                                .frame(width: 280, height: 280)
                                .padding(.top, 50)
                            Spacer()
                        }
                        
                        Text("Game Type Ratio")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top, 15)
                    }
                } else {
                    Text("No stats available")
                }
            }
            Spacer()
        }
        .onAppear {
            //clearDatabase() //--> ovo je da se ocisti ovo sta sam ja probno pisala
            fetchStats()
        }
        
    }
    
    private func fetchStats() {
        do {
            let realm = try Realm()
            if let statsEntity = realm.objects(StatsModelEntity.self).first {
                stats = statsEntity
                print("Stats fetched from Realm: \(statsEntity)")
            } else {
                print("database empty")
//                try realm.write {
//                    let newStats = StatsModelEntity()
//                    newStats.numAnswered = 1
//                    newStats.numCorrect = 1
//                    newStats.bestScore = 11
//                    newStats.dashNum = 1
//                    newStats.normalNum = 1
//                    realm.add(newStats)
//                    stats = newStats
//                    print("New stats created and added to Realm: \(newStats)")
//                }
//           ovaj komad je kd je baza prazna ond upise nove podatke al msm da bi to bit ok jer kad se upisuju drugdje podaci ce baza bit popunjena,msm da ce ovo sdbit ok
            }
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
}

struct CircleGraph: View {
    let numAnswered: Int
    let numCorrect: Int
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let lineWidth = size * 0.2
            let correctPercentage = Double(numCorrect) / Double(numAnswered)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(correctPercentage))
                    .stroke(Color.orange, lineWidth: lineWidth)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: numCorrect)
                
                VStack {
                    Text(String(format: "%.0f%%", correctPercentage * 100))
                        .font(.largeTitle)
                        .bold()
                    Text("\(numCorrect) / \(numAnswered)")
                        .font(.body)
                }
            }
            .padding()
        }
    }
}

struct GameRatioGraph: View {
    let dashNum: Int
    let normalNum: Int
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let lineWidth = size * 0.2
            let totalGames = dashNum + normalNum
            let dashPercentage = Double(dashNum) / Double(totalGames)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(dashPercentage))
                    .stroke(Color.pink, lineWidth: lineWidth)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: dashNum)
                
                VStack {
                    Text(String(format: "%.0f%%", dashPercentage * 100))
                        .font(.largeTitle)
                        .bold()
                    Text("\(dashNum) Dash / \(normalNum) Normal")
                        .font(.body)
                }
            }
            .padding()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView() 
    }
}
