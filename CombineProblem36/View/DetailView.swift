//
//  DetailView.swift
//  CombineProblem36
//
//  Created by cmStudent on 2022/09/16.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(viewModel.results?.publishingOffice ?? "表示できません")
                        .font(.system(size: 35, weight: .black, design: .default))
                    Text("(" + (viewModel.results?.targetArea ?? "表示できません") + ")")
                        .font(.system(size: 35, weight: .black, design: .default))
                    Spacer()
                }
                HStack {
                    Text(viewModel.results?.reportDatetime ?? "表示できません")
                        .font(.system(size: 10, weight: .black, design: .default))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                Text(viewModel.results?.headlineText ?? "表示できません")
                
                Text(viewModel.results?.text ?? "表示できません")
                    .font(.body)
                    .fontWeight(.light)
            }
            .padding()
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: WeatherViewModel())
    }
}
