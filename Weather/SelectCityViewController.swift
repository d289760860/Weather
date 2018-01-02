//
//  CityTableViewController.swift
//  Weather
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 nju. All rights reserved.
//
import os.log
import UIKit
import CoreLocation
import Alamofire

class CityTableViewController: UITableViewController,CLLocationManagerDelegate {

    static var Cities = [City]()
    let locationManager = CLLocationManager()
    var currentLocation  : CLLocation!
    
    private func Downloaddata()
    {
        for i in CityTableViewController.Cities
        {
            i.LoadDetailInfo()
        }
    }
    
    private func LoadDefaultCities()
    {

        if CityTableViewController.Cities.isEmpty==true{
            //guard let city1 = City(name: "Shanghai") else{fatalError("Unable to load image")}
            guard let city1 = City(name: "Nanjing") else{fatalError("Unable to load image")}
            guard let city2 = City(name: "London") else{fatalError("Unable to load image")}
            CityTableViewController.Cities += [city1,city2]
            Downloaddata()
        }
        //information should get loaded after visiting the website.
        //now just test.
    }
    
    @IBAction func Locate(_ sender: Any) {
        //let (lati,Longti) =
        locationAuthStatus()
        /*
        let loginFailWarnAlertController = UIAlertController(title: "提示", message: "您所在的城市为：", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        loginFailWarnAlertController.addAction(okAlertAction)
        
        self.present(loginFailWarnAlertController, animated: true, completion: nil)
 */
    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? TableviewController, let city = sourceViewController.city {
                let newIndexPath = IndexPath(row: CityTableViewController.Cities.count, section: 0)
                city.LoadDetailInfo()
                CityTableViewController.Cities.append(city)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                saveCities()
        }
    }
    
    static func IfExistsCity(cityname:String)->Bool
    {
        for cityitem in CityTableViewController.Cities
        {
            if(cityname == cityitem.name)
            {
                return true
            }
        }
        return false
    }
    
    func AddNewCity(cityname:String)->City
    {
        let city = City(name: cityname)!
        let newIndexPath = IndexPath(row: CityTableViewController.Cities.count, section: 0)
        city.LoadDetailInfo()
        CityTableViewController.Cities.append(city)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        return city
    }
    
    func locationAuthStatus()//->(Double,Double)
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.Longtitude = currentLocation.coordinate.longitude
            reverseGeocode(lat: Location.sharedInstance.latitude,longt: Location.sharedInstance.Longtitude)
            //return (Location.sharedInstance.latitude,Location.sharedInstance.Longtitude)
        }else{
            locationManager.requestWhenInUseAuthorization()
            //return
            self.locationAuthStatus()
        }
    }

    
    func reverseGeocode(lat:Double,longt:Double){
        let geocoder = CLGeocoder()
        var address:String? = nil
        let currentLocation = CLLocation(latitude: lat, longitude: longt)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            if error != nil {
                print("error:\(error!.localizedDescription))")
                return
            }
            
            if let p = placemarks?[0]{
                print(p)

                if let locality = p.locality {
                    
                    if(locality.isIncludeChineseIn())
                    {
                        address = locality.replacingOccurrences(of: "市", with: "")
                        address = address?.pinyin
                    }
                    else
                    {
                        address = locality
                    }
                    if(!CityTableViewController.IfExistsCity(cityname: address!))
                    {
                        let addedcity  = self.AddNewCity(cityname: address!)
                        addedcity.LoadDetailInfo()
                        self.tableView?.reloadData()
                        let alertController = UIAlertController(title: "Location",
                                                                message: "Latitude:\(lat)\nLongtitude:\(longt)\nCityname:\(String(address!))",
                                                                preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                        self.saveCities()
                    }
                    else
                    {
                        let alertController = UIAlertController(title: "Location",
                                                                message: "Latitude:\(lat)\nLongtitude:\(longt)\nCityname:\(String(address!))\nCity Already Exists.",
                            preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                

            } else {
                print("No placemarks!")
            }
        })
    }
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        if let savedcities = loadCities()
        {
            CityTableViewController.Cities += savedcities
            Downloaddata()
        }
        else
        {
            LoadDefaultCities()
        }
        
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CityTableViewController.Cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellidentifier  = "CityCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as? CityCell
            else {fatalError("not an instance of CityCell")}
        
        // Configure the cell...
        let city = CityTableViewController.Cities[indexPath.row]
        cell.CityInfo.text = city.name //+ "\t\t" + String(city.temperature) + "℃"
        cell.CityWeather.image  = city.countryimg
        return cell
    }
 

    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            CityTableViewController.Cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveCities()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "")
        {
        case "AddCity":
            os_log("Adding new city.", log: OSLog.default, type: .debug)
            break
        case "ShowDetail":
            guard let weatherdetail = segue.destination as? WeatherTabBarViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? CityCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedCity = CityTableViewController.Cities[indexPath.row]
            weatherdetail.city = selectedCity
            break
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    private func saveCities() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(CityTableViewController.Cities, toFile: City.ArchiveURL.path)
        if isSuccessfulSave
        {
            os_log("Cities successfully saved.", log: OSLog.default, type: .debug)
        }
        else
        {
            os_log("Failed to save cities", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCities() -> [City]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: City.ArchiveURL.path) as? [City]
    }

}

extension String {
    var pinyin: String {
        let str = NSMutableString(string: self)
        CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
        str.replaceOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range:  NSMakeRange(0, str.length))
        return str.capitalized
    }
    func isIncludeChineseIn() -> Bool {
        for (_, value) in self.enumerated() {
            
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
}
