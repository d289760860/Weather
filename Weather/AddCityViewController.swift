//
//  TableviewController.swift
//  SearchBar
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 TQY. All rights reserved.
//

import UIKit
import os.log

class TableviewController: UITableViewController{
    @IBOutlet weak var savecity: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //var selectedcellindex:Int?
    
    
    var ctname:String?
    
    var city:City?
    var alphabet:Dictionary<Int,[String]>? = [:]
    var adHeaders:[String]? = []
    var dic = GetSomeDic()
    
    override func loadView()
    {
        super.loadView()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === savecity
            else
        {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
            
        }
        
        //let weatherph = UIImage(named:"Stormy")]
        if ctname != nil
        {

            city  = City(name:ctname!)


        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savecity.isEnabled = false
        for i:Int in 65...90
        {
            let ch:Character = Character(UnicodeScalar(i)!)
            let str:String = "\(ch)" + ("\(ch)").lowercased()
            adHeaders?.append(str)
            alphabet?.updateValue(dic.GetExpectedDic(ch: ch), forKey: i-65)
            //alphabet![i-65] =
            
        }

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //self.tableView!.register(UITableViewCell.self,forCellReuseIdentifier: "SwiftCell")
        //self.view.addSubview(self.tableView!)
        
        let headerLabel = UILabel(frame: CGRect(x:0, y:0,width:self.view.bounds.size.width, height:30))
        headerLabel.backgroundColor = UIColor.black
        headerLabel.textColor = UIColor.white
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.text = "City List"
        headerLabel.font = UIFont.italicSystemFont(ofSize: 20)
        self.tableView!.tableHeaderView = headerLabel
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 26;
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return adHeaders
    }
    
    //点击索引，移动TableView的组位置
    override func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        var tpIndex:Int = 0
        //遍历索引值
        for character in adHeaders!{
            //判断索引值和组名称相等，返回组坐标
            if character == title{
                return tpIndex
            }
            tpIndex += 1
        }
        return 0
    }
    
    // headers
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return self.adHeaders?[section]
    }
    
    // tail
    override func tableView(_ tableView:UITableView, titleForFooterInSection section:Int)->String? {
        let data = self.alphabet?[section]
        if (data != nil)
        {
            return "total:\(data!.count)"
        }
        else
        {
            return "total:0"
        }
        
    }
    
    //num
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.alphabet?[section]
        if (data != nil)
        {
            return data!.count
        }
        else
        {
            return 0
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let identify:String = "SwiftCell"
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identify, for: indexPath)
            cell.accessoryType = .none
            
            let secno = indexPath.section
            var data = self.alphabet?[secno]
            cell.textLabel?.text = data![indexPath.row]
            
            
            if tableView.indexPathsForSelectedRows?.index(of: indexPath) != nil{
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }

            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.tableView!.deselectRow(at: indexPath, animated: true)
        //let cell = self.tableView?.cellForRow(at: indexPath)
        //cell?.accessoryType = .checkmark
        
        let itemString = self.alphabet![indexPath.section]![indexPath.row]
        /*
        let alertController = UIAlertController(title: "提示!",message: "你选中了【\(itemString)】",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
 */
        let getname:String = itemString.components(separatedBy: " ")[0]
        if(CityTableViewController.IfExistsCity(cityname: getname))
        {
            let alertController = UIAlertController(title: "Alert",message: "City already exists.",preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            self.tableView!.deselectRow(at: indexPath, animated: true)
            savecity.isEnabled = false
        }
        else
        {
            ctname = getname
            savecity.isEnabled = true
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
