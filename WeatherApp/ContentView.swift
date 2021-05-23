//
//  ContentView.swift
//  WeatherApp
//
//  Created by Kaffoux on 23/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        // dodaję otoczenie ScrollView, aby mieć możliwość przewijania
        ScrollView(.vertical) {
            // dodaję otoczenie VStack, aby wiersze z miastami były ułożone w jednej kolumnie
            VStack {
                ForEach(viewModel.records) {record in
                    WeatherRecordView(record: record, viewModel: viewModel)
                }
            }.padding()
        }
    }
}

enum WeatherViewParam: String, CaseIterable {
    case Temperature = "Temperature: %.1f℃"
    case Humidity = "Humidity: %.1f"
    case WindSpeed = "Wind speed: %.2f m/s"
    case WindDirection = "Wind direction: %.2f degrees"
}

struct WeatherRecordView: View {
    @State var currentParamId = 0
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel

    var body: some View {
        // dodaję otoczenie ZStack aby, ułożyć elementy na sobie a nie obok siebie
        ZStack {
            RoundedRectangle(cornerRadius: Constants.UI.cardBorderRadius)
                // potrzebuję tylko ramki, więc wykonuję metodę stroke
                .stroke()
                // ustawiam wysokość tego elementu na wartość stałą
                .frame(height: Constants.UI.cardHeight)
            // poszczególne informacje o danym mieście będą ułożone obok siebie
            HStack{
                // aby uzyskać taki efekt, że rozmiar ikonki pogody jest uzależniony od ilości miejsca jakie zostanie przydzielone na jego obszar wykorzystam otoczenie GeometryReader
                GeometryReader{ geometry in
                    Text(verbatim: viewModel.getWeatherIcon(record: record))
                        .font(.system(size: geometry.size.width))
                // ustawiam rozmiar ikonki na maksymalny aby uzyskać responsywność przy jednoczesnym założeniu że w pewnym momencie ikonka przestanie rosnąć
                }.frame(maxWidth: Constants.UI.weatherIconMaxWidth)
                
                // Spacer umożliwi zachowanie odstępu między poszczególnymi elementami
                Spacer()
                
                // wykorzystuję otoczenie VStack, aby nazwa miasta była nad wybranym parametrem opisującym pogodę
                // alignment: .leading -> nazwa miasta i parametr będą wyrównane względem siebie do lewej strony
                VStack(alignment: .leading) {
                    Text(record.cityName)
                    Text(String(format: WeatherViewParam.allCases[currentParamId].rawValue, getCurrentParamValue()))
                        .font(.caption)
                // dodanie reakcji na kliknięcie na parametr pogody
                }.onTapGesture {
                    iterateWeatherParam()
                }
                
                // Spacer umożliwi zachowanie odstępu między poszczególnymi elmentami
                Spacer()
                
                // dodaję przycisku do odświeżania danych aktualnego parametru
                Text("🔄")
                    .font(.largeTitle)
                    .onTapGesture {
                        viewModel.refresh(record: record)
                    }
            // dodaję padding
            }.padding()
        }
    }

    func iterateWeatherParam() {
        var nextId = currentParamId + 1
        if (WeatherViewParam.allCases.count <= nextId) {
            nextId = 0
        }
        currentParamId = nextId
    }
    
    func getCurrentParamValue() -> Float {
        let currentParam = WeatherViewParam.allCases[currentParamId]
        
        switch currentParam {
        case .Temperature:
            return record.temperature
        case .Humidity:
            return record.humidity
        case .WindSpeed:
            return record.windSpeed
        case .WindDirection:
            return record.windDirection
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
