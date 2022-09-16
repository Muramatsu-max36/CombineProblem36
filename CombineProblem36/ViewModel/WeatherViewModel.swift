//
//  WeatherViewModel.swift
//  CombineProblem36
//
//  Created by cmStudent on 2022/09/16.
//

import Foundation

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    var results: Result?
    
    @Published var isShowView = false
    
    @Published var isLode = false
    
    var disponsables = Set<AnyCancellable>()
    
    // Combine
    func lode() {
        let decoder = JSONDecoder()

        guard let url = URL(string: "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json") else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    fatalError("Error: invalid HTTP response code")
                }
                return data
            }
            .decode(type: Result.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("エラー: \(error)")
                case .finished:
                    print("終了")
                }
            }, receiveValue: { [weak self] result in
                print(result)
                self?.results = result
                self?.isShowView = true
            })
            .store(in: &disponsables)
    }
    
    
    // async/await
    //    func lode() {
    //        guard let url = URL(string: "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json") else {
    //            return
    //        }
    //
    //        Task.detached { [self] in
    //            do {
    //                results = try await self.fetch(url: url)
    //                DispatchQueue.main.async {
    //                    self.isShowView = true
    //                }
    //            } catch {
    //                print("error")
    //            }
    //        }
    //
    //    }
    //
    //    func fetch(url: URL) async throws -> Result {
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //
    //        guard let httpResponse = response as? HTTPURLResponse,
    //              httpResponse.statusCode == 200 else {
    //            throw fetchError.httpResponseError
    //        }
    //
    //        let decoder = JSONDecoder()
    //        guard let decodedResponse = try? decoder.decode(Result.self, from: data) else {
    //            throw fetchError.jsonDecodeError
    //        }
    //        return decodedResponse
    //    }
    
    
    /// 今までのやつ
    //    func loadData() {
    //        guard let url = URL(string: "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json") else {
    //            return
    //        }
    //
    //        let request = URLRequest(url: url)
    //
    //        URLSession.shared.dataTask(with: request) { [self] data, response, error in
    //
    //            if let data = data {
    //
    //                let decoder = JSONDecoder()
    //                guard let decodedResponse = try? decoder.decode(Result.self, from: data) else {
    //                    print("Json decode エラー")
    //                    return
    //                }
    //
    //                DispatchQueue.main.async {
    //                    self.results = decodedResponse
    //                    self.isShowView = true
    //                }
    //
    //            } else {
    //                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    //            }
    //
    //        }.resume()
    //    }
}

enum fetchError: Error {
    case httpResponseError
    case jsonDecodeError
    
    //    switch self {
    //    case .httpResponseError:
    //        print("http response error")
    //        break
    //    case .jsonDecodeError:
    //        print("json decode error")
    //        break
    //    }
}
