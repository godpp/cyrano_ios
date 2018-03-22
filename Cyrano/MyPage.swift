//
//  MyPage.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 1..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
class MyPage : UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkCallback{
   
    
    @IBOutlet weak var ingCounselTableView: UITableView!
    //@IBOutlet weak var ComCounselTableView: UITableView!
    
    var IngCounselList : [MypageItemVO] = []
    var ComCounselList : [MypageItemVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.setNavigationBar()
        self.setTabBar()
        
        ingCounselTableView.delegate = self
        ingCounselTableView.dataSource = self
        
        let model = MyPageModel(self)
        model.getMyCounseling()
        
    }
    
    //탭바 설정
    func setTabBar(){
        let bar:UITabBar! = self.tabBarController?.tabBar
        bar.isTranslucent = true
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    //셀의 갯수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(0 == section){
            return IngCounselList.count
        }
        else{
            return ComCounselList.count
        }
    }
    
    //셀 클릭시 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //미완성
    }
    
    //통신 성공
    func networkResult(resultData: Any, code: String) {
        if code == "3-1"{
            IngCounselList = resultData as! [MypageItemVO]
            ingCounselTableView.reloadData()
        }
        if code == "3-2"{
            ComCounselList = resultData as! [MypageItemVO]
            ingCounselTableView.reloadData()
        }
    }
    
    //통신 실패
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워크 연결을 확인해주세요.")
    }
    
    //셀안에 내용들 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            var row = IngCounselList[indexPath.row]
            let cell = ingCounselTableView.dequeueReusableCell(withIdentifier: "IngCounselCell") as! Mypage_Cell
            
            let article_type = gino(row.article_type)
            
            let currentTime = getCurrentMillis()
            let wr_time = Int64(row.written_time!)
            let write_time : Int64 = (currentTime - wr_time) / 1000 / 60
            var time = Int(write_time)
            
            if time <= 1 {
                cell.time_Label.text = "방금 전"
            }
            else{
                cell.time_Label.text = "\(time) 분전"
                if time >= 60 {
                    time /= 60
                    cell.time_Label.text = "\(time) 시간전"
                    if time >= 24{
                        time /= 24
                        cell.time_Label.text = "\(time) 일전"
                        if time >= 30{
                            time /= 30
                            cell.time_Label.text = "\(time) 개월전"
                        }
                    }
                }
            }
            
            cell.advise_Label.text = gsno(row.title)
            
            if article_type == 1{
                cell.typeLogo_Img.image = #imageLiteral(resourceName: "mypage_public_pink")
            }
            else if article_type == 2{
                cell.typeLogo_Img.image = #imageLiteral(resourceName: "mypage_secret_pink")
                
            }
            
            //사진 이미지뷰 둥글게 만들기
            cell.typeLogo_Img.clipsToBounds = true
            cell.typeLogo_Img.layer.cornerRadius = cell.typeLogo_Img.frame.size.width / 2
            
            return cell

        }
        else{
            var row = ComCounselList[indexPath.row]
            let cell = ingCounselTableView.dequeueReusableCell(withIdentifier: "ComCounselCell") as! Mypage_Cell2
            
            let article_type = gino(row.article_type)
            
            let currentTime = getCurrentMillis()
            let wr_time = Int64(gino(row.written_time))
            let write_time : Int64 = (currentTime - wr_time) / 1000 / 60
            var time = Int(write_time)
            
            if time <= 1 {
                cell.time_Label2.text = "방금 전"
            }
            else{
                cell.time_Label2.text = "\(time) 분전"
                if time >= 60 {
                    time /= 60
                    cell.time_Label2.text = "\(time) 시간전"
                    if time >= 24{
                        time /= 24
                        cell.time_Label2.text = "\(time) 일전"
                        if time >= 30{
                            time /= 30
                            cell.time_Label2.text = "\(time) 개월전"
                        }
                    }
                }
            }
            
            cell.advise_Label2.text = gsno(row.title)
            
            if article_type == 1{
                cell.typeLogo_Img2.image = #imageLiteral(resourceName: "mypage_public_gray")
            }
            else if article_type == 2{
                cell.typeLogo_Img2.image = #imageLiteral(resourceName: "mypage_secret_gray")
                
            }
            
            //사진 이미지뷰 둥글게 만들기
            cell.typeLogo_Img2.clipsToBounds = true
            cell.typeLogo_Img2.layer.cornerRadius = cell.typeLogo_Img2.frame.size.width / 2
            
            return cell
            
            

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (0 == section){
            return "진행중 상담"
        }
        else{
            return "완료된 상담"
        }
    }
}

