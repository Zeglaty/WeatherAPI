//
//  ViewController.swift
//  WeatherAPI
//
//  Created by Abdalmagied on 3/3/2021.
//

import UIKit

class ViewController: UIViewController {

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - decleration
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescreptionLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var reloadButton: UIButton!
    
    var networking = WeatherAPIRequest()
    
        
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - loding View Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadActions()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewStyle()
        loadActions(.didLoad)
        // Do any additional setup after loading the view.
    }
        
        // override func viewDidAppear
        
        // override func willDisapear
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - IBActions
        
    @IBAction func reload(_ sender: Any) {
        networking.getWeatherData()
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Methods
        
        
        
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Setup View
    func setupData(){
        
    }
    func setupViewStyle(){
        reloadButton.layer.cornerRadius = 12
    }


    func loadActions(_ atMethod : LoadingViewTypes = .willAppear){
        switch atMethod {
        case .willAppear:
            networking.getWeatherDelegate = self
            
        case .didLoad:
            networking.getWeatherData()
            
           
        case .didAppear:
            break
        case .willDisapear:
            break
        }
    }

        
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Navegation
        /*

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Extensions




    //////////////////////////////////////////////////////////////////////////////////
    // MARK: - NetWorkig
extension ViewController : GetWeatherProtocol{
    func getWeatherResponse(weatherData: WeatherData?, errorMessage: String?) {
        
        if errorMessage == nil{
            tempLabel.text = "\(weatherData!.temp)"
            maxMinTempLabel.text = "\(weatherData!.maxTemp) - \(weatherData!.minTemp)"
            windSpeedLabel.text = "\(weatherData!.windSpeed)"
            
            weatherDescreptionLabel.text = weatherData?.description
            switch weatherData?.mainDiscreption {
            case "Clouds":
                backgroundImage.image = UIImage(named: "cloud")
                
            case "Clear":
                backgroundImage.image = UIImage(named: "Clear")
                
            case "Rain":
                backgroundImage.image = UIImage(named: "ligthRain")
                
            case "Heavy Rain":
                backgroundImage.image = UIImage(named: "rain")
            default:
                break
            }
            
        }else{
            print(errorMessage)
        }
    }
    
    
}








enum LoadingViewTypes{
    case willAppear
    case didLoad
    case didAppear
    case willDisapear
}
