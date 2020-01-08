//
//  ViewController.swift
//  Review0827
//
//  Created by 中塚富士雄 on 2020/01/07.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var parser = XMLParser()
    
    var currentElementName:String!
    var mobile_access_labell = UILabel()
    var address_Label = UILabel()
    
    var dataModel = [DataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let urlString = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=cf98b31a5f543fd1&lat=34.67&lng=135.52&range=5&order=4"
        let url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height/5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let dataItem = self.dataModel[indexPath.row]
        
        mobile_access_labell = cell.contentView.viewWithTag(1) as! UILabel
        mobile_access_labell.text = dataItem.mobile_access
        
        address_Label = cell.contentView.viewWithTag(2) as! UILabel
        address_Label.text = dataItem.address
        
        return cell
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        if elementName == "shop"{
            
            self.dataModel.append(DataModel())
            
        }else{
            
            currentElementName = elementName
            
        }
    }
        func parser(_ parser: XMLParser, foundCharacters string: String){
            
            if self.dataModel.count > 0{
                
                let lastItem = self.dataModel[self.dataModel.count-1]
                
                switch self.currentElementName{
                    
                case "mobile_access":
                    
                    lastItem.mobile_access = string
                    
    
                
                case "address":
                
                lastItem.address = string
                default:break
            }
            
        }
        
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    self.currentElementName = nil
    
}
        func parserDidEndDocument(_ parser: XMLParser){
            
            self.tableView.reloadData()
            
        }

    
    
}

