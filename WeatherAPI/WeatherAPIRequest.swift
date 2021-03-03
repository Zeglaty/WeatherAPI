//
//  WeatherAPIRequest.swift
//  WeatherAPI
//
//  Created by Abdalmagied on 3/3/2021.
//

import Foundation
import SwiftyJSON
import Alamofire


protocol GetWeatherProtocol {
    func getWeatherResponse(weatherData: WeatherData?, errorMessage: String?)
}


class WeatherAPIRequest {
    
    //MARK: - 1 Get Weather
    let APIKey = "93569da3146c96f140175dcfa0c90849"//"1c576e9dd1bb81759cf34666be740acf"
    
    var getWeatherDelegate: GetWeatherProtocol?

    
    func getWeatherData(){
        let baseWeatherAPIURL = "http://api.openweathermap.org/data/2.5/weather?q=HONG%20KONG&APPID=\(APIKey)&units=metric"
//        let baseWeatherAPIURL = "http://api.openweathermap.org/data/2.5/weather?APPID=\(APIKey)"//"&q=Tripoli"
        let params = ["q": "Tripoli"]//parameters: params,
        
        Alamofire.request(baseWeatherAPIURL , method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            if response.result.isSuccess {
                    
                self.parseGetWeatherData(statusCode: response.response!.statusCode, json: JSON(response.result.value!))
                
            }else{
                
                
                let errorMessage = "error while connecting to server"
                self.getWeatherDelegate?.getWeatherResponse(weatherData: nil, errorMessage: errorMessage)
                
            }
            
        }
        
    }
    
    private func parseGetWeatherData(statusCode: Int, json: JSON){
        
        let data = json["data"]
        print(json)
        
        if statusCode < 300 {
            
            var tempWeatherData = WeatherData()
            
            
            
            self.getWeatherDelegate?.getWeatherResponse(weatherData: tempWeatherData, errorMessage: nil)
        }else{
            
            let error = json["error"]
            let errorMesage = error["message"].stringValue
            
            self.getWeatherDelegate?.getWeatherResponse(weatherData: nil, errorMessage: errorMesage)
        }
        

        
    }
    
    
    
}
