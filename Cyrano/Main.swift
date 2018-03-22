//
//  Main.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 28..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
import ESPullToRefresh

class Main : UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkCallback {
    
    let ud = UserDefaults.standard
    var id = Int.max
    
    //프로필로 넘어가기위한 유저아이디
    var user_id : Int?
    //일반, 멘토 프로필 구분하기위한 레벨
    var level : Int?
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var articleList : [ArticleItemVO] = []
    
    var refreshControl = UIRefreshControl()
    
    @IBAction func refresh_Btn(_ sender: Any) {
        guard let main_tab = self.storyboard?.instantiateViewController(withIdentifier: "Main_Tab") as? Main_Tab else{
            return
        }
        self.present(main_tab, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        mainTableView.addSubview(refreshControl)
        mainTableView.refreshControl = refreshControl
    }
    
    func refresh(){
        
        guard let main_tab = self.storyboard?.instantiateViewController(withIdentifier: "Main_Tab") as? Main_Tab else{
            return
        }
        self.present(main_tab, animated: true)
        refreshControl.endRefreshing()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        let model = LoginModel(self)
        
        model.getMainArticleList(id : id)
        
         //테이블 뷰 아래로 리로딩
        self.mainTableView.es_addInfiniteScrolling {
            [weak self] in
            let model = LoginModel(self!)
            model.getMainArticleList(id: (self?.gino(self?.id))!)
            
            if ((self?.articleList.last) == nil){
                self?.mainTableView.es_noticeNoMoreData()
            }
            else{
                self?.mainTableView.es_stopLoadingMore()
            }
        }
        
        self.setTabBar()
    
        //셀이 비어있을때 테이블뷰 줄가있는거 없애기
        mainTableView.tableFooterView = UIView.init(frame : CGRect.zero)
    }
    

    //글쓰기 추가 버튼
    @IBAction func write_plus_Btn(_ sender: Any) {
        guard let write = storyboard?.instantiateViewController(withIdentifier: "Write") as? Write else{
            return
        }
        self.present(write, animated: true)
    }
    
    //메인으로 돌아오기 위한 이정표
    @IBAction func unwindToMain(_ sender:UIStoryboardSegue){}
    
    //탭바 설정
    func setTabBar(){
        let bar:UITabBar! = self.tabBarController?.tabBar
        bar.isTranslucent = true
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    
    //셀안에 내용들 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var row = articleList[indexPath.row]
        var last = articleList.last
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "MainArticleCell") as! Main_article_Cell
        let gender = gino(row.gender)
        
        id = gino(last?.article_id)
        print(row.written_time)
        let currentTime = getCurrentMillis()
        let wr_time = Int64(gino(row.written_time))
        print(currentTime)
        print(wr_time)
        let write_time : Int64 = (currentTime - wr_time) / 1000 / 60
        var time = Int(write_time)
        
        print(gino(time))
        
        if time <= 1 {
            cell.wrttentime_Label.text = "방금 전"
        }
        else{
            cell.wrttentime_Label.text = "\(time) 분전"
            if time >= 60 {
                time /= 60
                cell.wrttentime_Label.text = "\(time) 시간전"
                if time >= 24{
                    time /= 24
                    cell.wrttentime_Label.text = "\(time) 일전"
                }
            }
        }
        
        
        // 내정보공개 하느냐 안하느냐
        if gino(row.open_name) == 1{
            cell.nickname_Label.text = gsno(row.nickname)
            if gender == 1{
                cell.profile_Img.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_woman.png")
            }
            else if gender == 2{
                cell.profile_Img.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_man.png")
            }
        }
        else {
            cell.nickname_Label.text = "비공개"
            if gender == 1{
                cell.profile_Img.imageFromUrl("", defaultImgPath: "profile_woman.png")
            }
            else if gender == 2{
                cell.profile_Img.imageFromUrl("", defaultImgPath: "profile_man.png")
            }
        }
        cell.title_Label.text = gsno(row.title)
        cell.content_Label.text = gsno(row.content)
        cell.ink_Label.text = "\(gino(row.reward_ink)) ink"
        
        //사진 이미지뷰 둥글게 만들기
        cell.profile_Img.clipsToBounds = true
        cell.profile_Img.layer.cornerRadius = cell.profile_Img.frame.size.width / 2
        
        
        //좋아요 개수 구현
        cell.like_Btn.setTitle("\(gino(row.like_count))", for: .normal)
        
        
        //댓글 개수 구현
        cell.comment_Btn.setTitle("\(gino(row.comment_count))", for: .normal)
        
        
        return cell
    }
    
    
    //셀의 갯수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return articleList.count
    }
    
    //셀 클릭시 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let detailVO = articleList[indexPath.row]


        guard let main_detail = storyboard?.instantiateViewController(withIdentifier: "Main_Detail") as? Main_Detail else {
            return
        }
        main_detail.article_id = detailVO.article_id
        
        navigationController?.pushViewController(main_detail, animated: true)
        
    }
    
    
    //통신 성공
    func networkResult(resultData: Any, code: String) {
        if code == "1"{
            articleList += resultData as! [ArticleItemVO]
            mainTableView.reloadData()
        }
    }
    
    //통신 실패
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워크 연결을 확인해주세요.")
    }
}
