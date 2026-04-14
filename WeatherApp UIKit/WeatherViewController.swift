//
//  WeatherViewController.swift
//  WeatherApp UIKit
//
//  Created by Aryan Verma on 09/04/26.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    let forecastData: [String] = [
        "Monday — 28°C — Sunny",
        "Tuesday — 24°C — Cloudy",
        "Wednesday — 19°C — Rainy",
        "Thursday — 22°C — Partly Cloudy",
        "Friday — 26°C — Clear"
    ]
    
    lazy var cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold, width: .compressed)
        label.textColor = .white
        label.text = "City Name"
        return label
    }()
    
    let temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold, width: .compressed)
        label.textColor = .white
        label.text = "Temperature"
        return label
    }()
    
    lazy var weatherStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityName, temperature])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        //        stack.alignment = .leading
        return stack
    }()
    
    lazy var weatherCond: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold, width: .compressed)
        label.textColor = .white
        label.text = "Weather Condition?"
        return label
    }()
    
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        image.image = UIImage(systemName: "cloud.rain.fill")
        image.tintColor = .white
        return image
    }()
    
    lazy var cityField: UITextField = {
        let searchField = UITextField()
        searchField.textAlignment = .center
        searchField.placeholder = "City..."
        searchField.returnKeyType = .search
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        searchField.layer.cornerRadius = 10
        searchField.clipsToBounds = true
        searchField.textColor = .white
        searchField.attributedPlaceholder = NSAttributedString(
            string: "City...",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchField.leftView = paddingView
        searchField.leftViewMode = .always
        return searchField
    }()
    
    lazy var forecastTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ForecastCell")
        return table
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        return indicator
    }()
    
    var viewModel = WeatherViewModel()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        labelView()
        title = "No Data"
        navigationController?.navigationBar.prefersLargeTitles = true
        updateView()
        viewModel.fetchWeather(city: "...", unit: "metric")
        cityField.delegate = self
        navigationItem.titleView = cityField
        forecastTable.delegate = self
        forecastTable.dataSource = self
        loadingIndicator.startAnimating()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        cell.textLabel?.text = forecastData[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func updateView() {
        viewModel.update = { [weak self] in
            self?.cityName.text = self?.viewModel.cityName
            self?.temperature.text = self?.viewModel.temperature
            self?.weatherCond.text = self?.viewModel.weatherCondition
            self?.loadingIndicator.stopAnimating()
            if let id = self?.viewModel.conditionId {
                self?.view.backgroundColor = WeatherConditionHelper.backgroundColor(for: id)
                self?.weatherImage.image = UIImage(systemName: WeatherConditionHelper.iconName(for: id))
            }
            self?.title = self?.viewModel.weatherCondition
        }
            
        viewModel.error = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Error",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let city = textField.text, !city.isEmpty else { return false }
        viewModel.fetchWeather(city: city, unit: "metric")
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    func labelView() {
        view.addSubview(weatherCond)
        view.addSubview(weatherStack)
        view.addSubview(weatherImage)
        view.addSubview(forecastTable)
        view.addSubview(loadingIndicator)
        
        
        
        
        NSLayoutConstraint.activate([
            weatherCond.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -15
                ),
            weatherStack.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 15
                ),
            weatherCond.topAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 40
                ),
            weatherStack.topAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 50
                ),
            weatherImage.centerYAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.centerYAnchor,
                    constant: 0
                ),
            weatherImage.centerXAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                    constant: 0
                ),
            weatherImage.heightAnchor
                .constraint(
                    equalToConstant: 200
                ),
            weatherImage.widthAnchor
                .constraint(
                    equalToConstant: 200
                ),
            forecastTable.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 20),
            forecastTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            forecastTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            forecastTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
