//
//  Comment.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 8..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class Comment : UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkCallback{
    
    var commentList : [CommentVO] = []
    
    var article_id : Int?
    
    @IBOutlet weak var comment_tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "댓글 보기"
        
        let model = CommentLookModel(self)
        model.getComment(article_id: gino(article_id))
        
        comment_tableView.delegate = self
        comment_tableView.dataSource = self
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        comment_tableView.reloadData()
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "3"{
            commentList = resultData as! [CommentVO]
            comment_tableView.reloadData()
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "에러", msg: "네트워크 통신 오류")
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = commentList[indexPath.row]
        let cell = comment_tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        
        cell.comment_content_Label.text = gsno(row.comment_content)
        cell.comment_nickname.text = gsno(row.nickname)
        
        let gender = gino(row.gender)
        
        let currentTime = getCurrentMillis()
        let wr_time = Int64(row.comment_written_time!)

        let write_time : Int64 = (currentTime - wr_time) / 1000 / 60
        var time = Int(write_time)
        
        if time <= 1 {
            cell.comment_written_time_Label.text = "방금 전"
        }
        else{
            cell.comment_written_time_Label.text = "\(time) 분전"
            if time >= 60 {
                time /= 60
                cell.comment_written_time_Label.text = "\(time) 시간전"
                if time >= 24{
                    time /= 24
                    cell.comment_written_time_Label.text = "\(time) 일전"
                }
            }
        }
        
        //사진 이미지뷰 둥글게 만들기
        cell.comment_profile_img.clipsToBounds = true
        cell.comment_profile_img.layer.cornerRadius = cell.comment_profile_img.frame.size.width / 2
        
        if gender == 1{
            cell.comment_profile_img.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_woman.png")
        }
        else if gender == 2{
            cell.comment_profile_img.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_man.png")
        }
        
        return cell

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //미구현
    }
}
