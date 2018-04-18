//
//  Main_Detail.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 11..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class Main_Detail : UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkCallback{
    
    let ud = UserDefaults.standard
    var list : [DetailCommentItemVO] = []
    var detailList : [DetailCommentItemVO] = []
    var answerList : [DetailCommentItemVO] = []
    
    var login_user_id : Int?
    var article_id : Int?
    var detail_user_id : Int?
    var answer_user_id : Int?
    
    var like_state_num = 0
    
    var unclick_like_image = UIImage(named: "main_answer_heart_unclick")?.withRenderingMode(.alwaysOriginal)
    var click_like_image = UIImage(named: "main_answer_heart_click")?.withRenderingMode(.alwaysOriginal)
    
    @IBOutlet weak var detail_TableView: UITableView!
    
    
    @IBAction func unwindToDetailMain(segun : UIStoryboardSegue){}
    
    override func viewDidLoad() {
        login_user_id = ud.integer(forKey: "login_user_id")
        
        //셀이 비어있을때 테이블뷰 줄가있는거 없애기
        detail_TableView.tableFooterView = UIView.init(frame : CGRect.zero)
        detail_TableView.tableHeaderView = UIView.init(frame : CGRect.zero)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        detail_TableView.delegate = self
        detail_TableView.dataSource = self
        
        let model = DetailModel(self)
        model.getDetailComment(article_id: gino(article_id))
    
    }
    
    @IBAction func like_Btn(_ sender: Any) {
        let model = DetailModel(self)
        model.addlike(article_id: gino(article_id))
    }
    
    
    // 답변에 채택된게 있는지 확인
//    func is_chosen_check() -> Bool{
//        
//        for item in answerList{
//            if item.is_chosen == 1{
//                return true
//            }
//        }
//        return false
//    }
    
    // 채택하기 버튼 이벤트
    func adopt(_ sender : UIButton){
    
        let index = sender.tag

        let choice_article_id = answerList[index].article_id
    
//        if let cell = detail_TableView.cellForRow(at: IndexPath(row:index, section:3)) as? AnswerCell{
//        // 유저타입에 따른 기본 백그라운드 분기
//        }
        
        guard let choice_answer = storyboard?.instantiateViewController(withIdentifier: "ChoiceAnswer") as? ChoiceAnswer else{
            return
        }
        choice_answer.article_id = choice_article_id
        self.present(choice_answer, animated: true)
        
    }
    
    // 답변하기 버튼 이벤트
    func write_answer(){
        if gino(login_user_id) == gino(detail_user_id){
            simpleAlert(title: "중요", msg: "자신의 상담글은 답변할수 없습니다.")
        }
        else {
            guard let write_answer = storyboard?.instantiateViewController(withIdentifier: "Detail_Answer") as? Detail_Answer else{
                        return
            }
            write_answer.parent_article_id = article_id
            navigationController?.pushViewController(write_answer, animated: true)
                    
        }
    }
    
    //디테일 이미지뷰 클릭시 프로필 이동 메소드
    func DetailimageTapped(_ sender : AnyObject){
        
        guard let user_profile = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as? UserProfileVC else {
            return
        }
        user_profile.user_id = detail_user_id
        self.present(user_profile, animated: true)
    }
    
    //답변 이미지뷰 클릭시 프로필 이동 메소드
    func AnswerimageTapped(_ sender : UITapGestureRecognizer){
        
        if(sender.state == .ended){
            guard let user_profile = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as? UserProfileVC else {
                return
            }
            self.present(user_profile, animated: true)
        }
        
        let row = answerList[0]
    }
    
    
    //테이블 섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //테이블 셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (0 == section){
            return detailList.count
        }
        else if (1 == section){
            return 1
        }
        else if (2 == section){
            return 1
        }
        else {
            return answerList.count
        }
    }
    
    
    //테이블 셀 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            var row = detailList[indexPath.row]
            let cell = detail_TableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
            
            let open_name = gino(row.open_name)
            let gender = gino(row.gender)
            detail_user_id = gino(row.user_id)
            
            cell.Detail_nickname_Label.text = row.nickname
            cell.Detail_title_Label.text = row.title
            cell.Detail_Content_Label.text = row.content
            cell.Detail_reward_ink_Label.text = "\(gino(row.reward_ink)) ink"
            
            //내정보 공개에 따른 분기
            if open_name == 1{
                cell.Detail_nickname_Label.text = gsno(row.nickname)
                
                if gino(row.age) <= 10{
                    cell.Detail_age_Label.text = "유아 / 기타 정보"
                }
                else if gino(row.age) <= 20 && gino(row.age) > 10{
                    cell.Detail_age_Label.text = "10대 / 기타 정보"
                }
                else if gino(row.age) <= 30 && gino(row.age) > 20{
                    cell.Detail_age_Label.text = "20대 / 기타 정보"
                }
                else if gino(row.age) <= 40 && gino(row.age) > 30{
                    cell.Detail_age_Label.text = "30대 / 기타 정보"
                }
                
                if gender == 1{
                    cell.Detail_profile_ImageView.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_woman.png")
                }
                else if gender == 2{
                    cell.Detail_profile_ImageView.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_man.png")
                }
            }
            else {
                cell.Detail_nickname_Label.text = "비공개"
                cell.Detail_age_Label.text = ""
            }
            
            // 작성시간
            let currentTime = getCurrentMillis()
            let wr_time = Int64(gino(row.written_time))
            let write_time : Int64 = (currentTime - wr_time) / 1000 / 60
            var time = Int(write_time)
            if time <= 1 {
                cell.Detail_written_time_Label.text = "방금 전"
            }
            else{
                cell.Detail_written_time_Label.text = "\(time) 분전"
                if time >= 60 {
                    time /= 60
                    cell.Detail_written_time_Label.text = "\(time) 시간전"
                    if time >= 24{
                        time /= 24
                        cell.Detail_written_time_Label.text = "\(time) 일전"
                    }
                }
            }
            
            //사진 이미지뷰 둥글게 만들기
            cell.Detail_profile_ImageView.clipsToBounds = true
            cell.Detail_profile_ImageView.layer.cornerRadius = cell.Detail_profile_ImageView.frame.size.width / 2
            
            //이미지뷰 클릭시 프로필로 이동
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailimageTapped))
            
            cell.Detail_profile_ImageView.isUserInteractionEnabled = true
            cell.Detail_profile_ImageView.addGestureRecognizer(tapGestureRecognizer)
            
            return cell
        }
        else if (indexPath.section == 1){
            let cell = detail_TableView.dequeueReusableCell(withIdentifier: "AnswerBtnCell") as! AnswerBtnCell
            cell.Write_Answer_Btn.addTarget(self, action: #selector(write_answer), for: .touchUpInside)
            return cell
        }
        else if (indexPath.section == 2){
            let cell = detail_TableView.dequeueReusableCell(withIdentifier: "LabelCell") as! LabelCell
            cell.answer_count_Label.text = "\(answerList.count)개의 답변이 달렸어요"
            return cell
        }
        else {
            var row = answerList[indexPath.row]
            let cell = detail_TableView.dequeueReusableCell(withIdentifier: "AnswerCell") as! AnswerCell
            let gender = gino(row.gender)
            answer_user_id = gino(row.user_id)
            let level = gino(row.level)
            
            cell.Answer_profile_ImageView.tag = indexPath.row
            cell.Answer_choice_Btn.tag = indexPath.row
            cell.Answer_nickname_Label.text = gsno(row.nickname)
            cell.Answer_title_Label.text = gsno(row.title)
            cell.Answer_content_Label.text = gsno(row.content)
            
            if gino(row.age) <= 10{
                cell.Answer_age_Label.text = "유아 / 기타 정보"
            }
            else if gino(row.age) <= 20 && gino(row.age) > 10{
                cell.Answer_age_Label.text = "10대 / 기타 정보"
            }
            else if gino(row.age) <= 30 && gino(row.age) > 20{
                cell.Answer_age_Label.text = "20대 / 기타 정보"
            }
            else if gino(row.age) <= 40 && gino(row.age) > 30{
                cell.Answer_age_Label.text = "30대 / 기타 정보"
            }
            
            if gender == 1{
                cell.Answer_profile_ImageView.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_woman.png")
            }
            else if gender == 2{
                cell.Answer_profile_ImageView.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_man.png")
            }
            
            // 작성시간
            let currentTime = getCurrentMillis()
            let wr_time = Int64(gino(row.written_time))
            let write_time : Int64 = (currentTime - wr_time) / 1000 / 60
            var time = Int(write_time)
            if time <= 1 {
                cell.Answer_written_time_Label.text = "방금 전"
            }
            else{
                cell.Answer_written_time_Label.text = "\(time) 분전"
                if time >= 60 {
                    time /= 60
                    cell.Answer_written_time_Label.text = "\(time) 시간전"
                    if time >= 24{
                        time /= 24
                        cell.Answer_written_time_Label.text = "\(time) 일전"
                    }
                }
            }
            
            //사진 이미지뷰 둥글게 만들기
            cell.Answer_profile_ImageView.clipsToBounds = true
            cell.Answer_profile_ImageView.layer.cornerRadius = cell.Answer_profile_ImageView.frame.size.width / 2
            
            //이미지뷰 클릭시 프로필로 이동
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AnswerimageTapped))
            
            cell.Answer_profile_ImageView.isUserInteractionEnabled = true
            cell.Answer_profile_ImageView.addGestureRecognizer(tapGestureRecognizer)
            
            if level == 1{
                cell.Answer_mentor_normal_ImageView.isHidden = true
            }
            else {
                cell.Answer_mentor_normal_ImageView.isHidden = false
                cell.Answer_Base_ImageView.image = UIImage(named: "main_answer_mentor_box.png")
            }
            
            if gino(login_user_id) == gino(detail_user_id){
                cell.Answer_choice_Btn.isHidden = false
                cell.Answer_choice_Btn.addTarget(self, action: #selector(adopt(_:)), for: .touchUpInside)
            }
            else if gino(login_user_id) != gino(detail_user_id)  {
                cell.Answer_choice_Btn.isHidden = true
            }

            return cell
        }
    }
    
    // no event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    // 테이블 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return UITableViewAutomaticDimension
        }
        else if (indexPath.section == 1){
            return 57
        }
        else if (indexPath.section == 2){
            return UITableViewAutomaticDimension
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
    
    //통신 성공
    func networkResult(resultData: Any, code: String) {
        if code == "4-1"{
            list = resultData as! [DetailCommentItemVO]
            
            if detailList.isEmpty == true {
                detailList.append(list.first!)
            }
            answerList = list
            answerList.remove(at: 0)
            answerList.reverse()
            
            detail_TableView.estimatedRowHeight = 40.0
            detail_TableView.rowHeight = UITableViewAutomaticDimension
            
            detail_TableView.reloadData()
        }
        else if code == "1"{
            let msg = resultData as? String
            simpleAlert(title: "에러", msg: gsno(msg))
        }
        else if code == "2"{
            let msg = resultData as? String
            simpleAlert(title: "에러", msg: gsno(msg))
        }
        else if code == "3"{
            let msg = resultData as? String
            simpleAlert(title: "에러", msg: gsno(msg))
        }
    }
    
    //통신 실패
    func networkFailed() {
        simpleAlert(title: "에러", msg: "네트워크를 확인해주세요.")
    }
}
