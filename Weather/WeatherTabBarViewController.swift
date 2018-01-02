//
//  WeatherTabBarViewController.swift
//  Weather
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 nju. All rights reserved.
//
import os.log
import UIKit

class WeatherTabBarViewController: UITabBarController {

    var city:City?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.city?.LoadForecastInfo()
        (self.childViewControllers[0] as! WeatherInfoViewController).city = self.city
        (self.childViewControllers[1] as! DetailViewController).city = self.city
        (self.childViewControllers[2] as! MoreInfoViewController).city = self.city
        /*
        self.viewControllers![0].tabBarItem.image = UIImage(named:"info")
        self.viewControllers![0].tabBarItem.selectedImage = UIImage(named:"Info")
        self.viewControllers![0].tabBarItem.title = ""
        
        self.viewControllers![1].tabBarItem.image = UIImage(named:"line")
        self.viewControllers![1].tabBarItem.selectedImage = UIImage(named:"line")
        self.viewControllers![1].tabBarItem.title = ""
         */
        //createControllers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func createNavigationController(vc:UIViewController ,  
                                    title: String,  
                                    imageName: String,  
                                    selectedImageName: String)  
    {
        let selectImg = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        
        vc.tabBarItem = UITabBarItem(title: title,
                                     image: UIImage(named: imageName),  
                                     selectedImage:selectImg)  
        
        let nav = UINavigationController(rootViewController: vc)
        
        self.addChildViewController(nav)
        
    }
    
    func createControllers()
    {
        let vc1 = WeatherInfoViewController()
        vc1.city = self.city
        let vc2 = DetailViewController()
        vc2.city = self.city
        createNavigationController(vc:vc1,
                                   title: "Info",
                                   imageName: "Info",
                                   selectedImageName: "Info")
        
        createNavigationController(vc:vc2,
                                   title: "Detail",
                                   imageName: "Info",
                                   selectedImageName: "Info")
        //UITabBarItem.appearance().setTitleTextAttributes(attributes, forState: .Selected)
        
    }
    */
    
    //override func
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard let weatherdetail = segue.destination as? WeatherInfoViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
            
        //weatherdetail.city = self.city
        weatherdetail.city = self.city

    }
     */

}
