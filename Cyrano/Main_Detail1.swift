////
////  Main_Detail.swift
////  Cyrano
////
////  Created by 갓거 on 2017. 7. 2..
////  Copyright © 2017년 MOON. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Cosmos
//
//class Main_Detail1 : UIViewController,UITableViewDataSource,UITableViewDelegate, NetworkCallback {
//    
//    @IBOutlet var full_detail_view: UIView!
//    
//    @IBOutlet weak var zero_detail_view: UIView!
//    
//    let ud = UserDefaults.standard
//    
//    var login_user_id : Int?
//    var now_user_id : Int?
//    
//    
//    @IBOutlet weak var choose_profile_Img: UIImageView!
//    @IBOutlet weak var choose_nickname_Label: UILabel!
//    @IBOutlet weak var choose_age_Label: UILabel!
//    @IBOutlet weak var choose_reward_ink_Label: UILabel!
//    @IBOutlet weak var choose_time_Label: UILabel!
//    @IBOutlet weak var choose_title_Label: UILabel!
//    @IBOutlet weak var choose_content_Label: UILabel!
//    @IBOutlet weak var choose_like_Btn: UIButton!
//    @IBOutlet weak var choose_comment_Btn: UIButton!
//    
//    @IBOutlet weak var scrollview: UIScrollView!
//    
//    //테이블 셀 불러오기
//    
//    var nickname : String?
//    var age : Int?
//    var rInk : Int?
//    var time : Int?
//    var title_title : String?
//    var content : String?
//    var gender : Int?
//    var article_id : Int?
//    var article_type : Int?
//    var open_name : Int?
//    var comment_article_id : Int?
//    var level : Int?
//    var is_chosen : Int?
//    var profile_picture : String?
//    var like_count : Int?
//    var comment_count : Int?
//    
//    var choose_message : String?
//    var rating : Int?
//    var choice_article_id : Int?
//    
//    
//    var commentList : [DetailCommentItemVO] = []
//    var choiceDetailList : [DetailChoiceVO] = []
//    
//    
//    @IBOutlet weak var detailTableView: UITableView!
//    
//    @IBOutlet weak var bridge_Label: UILabel!
//    
//    
//    
//    @IBOutlet weak var write_answer_Btn_Outlet: UIButton!
//    
//    
//    func adopt(_ sender : UIButton){
//        
//        let index = sender.tag
//        
//        let row1 = commentList[index]
//        
//        comment_article_id = gino(row1.article_id)
//        
//        sender.isHidden = true
//        
//        if let cell = detailTableView.cellForRow(at: IndexPath(row:index, section:0)) as? DetailCell{
//            // 유저타입에 따른 기본 백그라운드 분기
//             
//            
//        }
//        
//        guard let choice_answer = storyboard?.instantiateViewController(withIdentifier: "ChoiceAnswer") as? ChoiceAnswer else{
//            return
//        }
//        choice_answer.article_id = comment_article_id
//        self.present(choice_answer, animated: true)
//    
//    }
//    
//    // 좋아요 구현
//    var heart : UIImage = UIImage(named:"main_answer_heart_click.png")!.withRenderingMode(.alwaysOriginal)
//    var no_heart : UIImage = UIImage(named:"main_answer_heart_unclick.png")!.withRenderingMode(.alwaysOriginal)
//    var check : Bool = false // 버튼 클릭 확인
//    
//    func clickEvent(_ sender:UIButton){
//        
//        if check{ // 좋아요 -> 기본
//            sender.setImage(no_heart, for: .normal)
//            sender.setTitleColor(UIColor.init(red: 255/255.0, green: 101/255, blue: 122/255, alpha: 1.0), for: .normal)
//            sender.setTitle("\(gino(like_count))", for: .normal)
//            check = false
//        }
//            
//        else{ // 기본 -> 좋아요
//            sender.setImage(heart, for: .normal)
//            sender.setTitleColor(UIColor.white, for: .normal)
//            sender.setTitle("\(gino(like_count))", for: .normal)
//            check = true
//
//        }
//    }
//    
//    
//    // 답변하기
//    func write_answer(){
//        
//        if gino(login_user_id) == gino(now_user_id){
//            simpleAlert(title: "중요", msg: "자신의 상담글은 답변할수 없습니다.")
//        }
//        else {
//            guard let write_answer = storyboard?.instantiateViewController(withIdentifier: "Detail_Answer") as? Detail_Answer else{
//                return
//            }
//            write_answer.parent_article_type = article_type
//            write_answer.parent_article_id = article_id
//            navigationController?.pushViewController(write_answer, animated: true)
//            
//        }
//    }
//
//    // 테이블뷰 세가지 메소드
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVO = commentList[indexPath.row]
//        
//        if detailVO.level == 1{
//            guard let user_profile = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as? UserProfileVC else {
//                return
//            }
//            
//            user_profile.user_id = detailVO.user_id
//            self.present(user_profile, animated: true)
//        }
//        else {
//            guard let mentor_profile = storyboard?.instantiateViewController(withIdentifier: "MentorProfileVC") as? MentorProfileVC else {
//                return
//            }
//            
//            mentor_profile.user_id = detailVO.user_id
//            self.present(mentor_profile, animated: true)
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return commentList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        
//        var row = commentList[indexPath.row]
//        let cell = detailTableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
//        
//        is_chosen = gino(row.is_chosen)
//        level = gino(row.level)
//
//        if choiceDetailList.count != 0{
//            var row2 = choiceDetailList[indexPath.row]
//            
//            choose_message = gsno(row2.choose_message)
//            rating = gino(row2.rate)
//            choiceDetailList.removeAll()
//            cell.choice_answer_Btn.isHidden = true
//        }
//
// 
//        
//        //테이블 기본 베이스
//        cell.choice_answer_Btn.tag = indexPath.row
//        cell.nickname_Label.text = gsno(row.nickname)
//        cell.title_Label.text = gsno(row.title)
//        cell.content_Label.text = gsno(row.content)
//        //사진 이미지뷰 둥글게 만들기
//        cell.profile_Img.clipsToBounds = true
//        cell.profile_Img.layer.cornerRadius = cell.profile_Img.frame.size.width / 2
//        // 작성시간에 따른 시간 분기
//        let currentTime = getCurrentMillis()
//        let wr_time = Int64(gino(row.written_time))
//        let write_time : Int64 = (currentTime - wr_time) / 1000 / 60
//        var time = Int(write_time)
//        if time <= 1 {
//            cell.time_Label.text = "방금 전"
//        }
//        else{
//            cell.time_Label.text = "\(time) 분전"
//            if time >= 60 {
//                time /= 60
//                cell.time_Label.text = "\(time) 시간전"
//                if time >= 24{
//                    time /= 24
//                    cell.time_Label.text = "\(time) 일전"
//                }
//            }
//        }
//        
//        
//        // 나이에 따른 나이대 분기
//        if gino(row.age) <= 10{
//            cell.age_Label.text = "유아 / 기타 정보"
//        }
//        else if gino(row.age) <= 20 && gino(row.age) > 10{
//            cell.age_Label.text = "10대 / 기타 정보"
//        }
//        else if gino(row.age) <= 30 && gino(row.age) > 20{
//            cell.age_Label.text = "20대 / 기타 정보"
//        }
//        else if gino(row.age) <= 40 && gino(row.age) > 30{
//            cell.age_Label.text = "30대 / 기타 정보"
//        }
//        
//        
//        
//        // 성별에 따른 이미지 분기
//        let gender = gino(row.gender)
//        if gender == 1{
//            cell.profile_Img.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_woman.png")
//        }
//        else if gender == 2{
//            cell.profile_Img.imageFromUrl(gsno(row.profile_picture), defaultImgPath: "profile_man.png")
//        }
//        
//        
//        // 유저타입에 따른 기본 백그라운드 분기
//        if level == 1 && is_chosen == 0 {
//            cell.answer_background_Img.image = UIImage(named: "main_answer_normaluser_box.png")
//            cell.choose_best_Img.isHidden = true
//            cell.choose_Label.isHidden = true
//            cell.choice_answer_Btn.isHidden = true
//        }
//        else if level == 2 && is_chosen == 0{
//            cell.answer_background_Img.image = UIImage(named: "main_answer_mentor_box.png")
//            cell.mentor_Img.image = UIImage(named: "main_answer_mentor_profile.png")
//            cell.choose_best_Img.isHidden = true
//            cell.choose_Label.isHidden = true
//            cell.choice_answer_Btn.isHidden = true
//        }
//        
//        // 채택 버튼 분기
//        if gino(login_user_id) == gino(now_user_id){
//            cell.choice_answer_Btn.isHidden = false
//            cell.choice_answer_Btn.addTarget(self, action: #selector(adopt(_:)), for: .touchUpInside)
//        }
//        else{
//            cell.choice_answer_Btn.isHidden = true
//        }
//        
//        cell.choice_answer_line.isHidden = true
//        cell.choice_thanks_message_label.isHidden = true
//        cell.choice_rating_view.isHidden = true
//        
//        // 채택을 함에 따른 채택 화면 분기
//        if is_chosen == 1 && level == 1{
//            cell.answer_background_Img.image = UIImage(named: "main_answer_yellow_box.png")
//            cell.choice_normal_Img.image = UIImage(named: "main_answer_adopt_profile.png")
//            cell.choice_answer_line.isHidden = false
//            cell.choice_thanks_message_label.isHidden = false
//            cell.choice_rating_view.isHidden = false
//            cell.choice_rating_view.settings.updateOnTouch = false
//            cell.choice_rating_view.rating = Double(gino(rating)/2)
//            cell.choice_thanks_message_label.text = choose_message
//            cell.choice_answer_Btn.isHidden = true
//            cell.choose_best_Img.isHidden = false
//            cell.choose_Label.isHidden = false
//        }
//        else if is_chosen == 1 && level == 2{
//            cell.choice_mentor_Img.image = UIImage(named: "main_answer_mentor_profile_ad.png")
//            cell.answer_background_Img.image = UIImage(named: "main_answer_mentor_box.png")
//            cell.choice_answer_line.isHidden = false
//            cell.choice_thanks_message_label.isHidden = false
//            cell.choice_rating_view.isHidden = false
//            cell.choice_rating_view.settings.updateOnTouch = false
//            cell.choice_rating_view.rating = Double(gino(rating)/2)
//            cell.choice_thanks_message_label.text = choose_message
//            cell.choice_answer_Btn.isHidden = true
//            cell.mentor_Img.isHidden = true
//            cell.choose_best_Img.isHidden = false
//            cell.choose_Label.isHidden = false
//        }
//
//
//        // 다른 유저가 봤을때 (이건 맞음)
//        if gino(login_user_id) != gino(now_user_id){
//            cell.choice_answer_Btn.isHidden = true
//            if is_chosen == 0 && level == 1{
//                cell.choice_answer_line.isHidden = true
//                cell.choice_thanks_message_label.isHidden = true
//                cell.choice_rating_view.isHidden = true
//                cell.answer_background_Img.image = UIImage(named: "main_answer_normaluser_box.png")
//            }
//            if is_chosen == 0 && level == 2{
//                cell.choice_answer_line.isHidden = true
//                cell.choice_thanks_message_label.isHidden = true
//                cell.choice_rating_view.isHidden = true
//                cell.answer_background_Img.image = UIImage(named: "main_answer_mentor_box.png")
//                cell.mentor_Img.image = UIImage(named: "main_answer_mentor_profile.png")
//            }
//            if is_chosen == 1 && level == 1{
//                cell.answer_background_Img.image = UIImage(named: "main_answer_yellow_box.png")
//                cell.choice_normal_Img.image = UIImage(named: "main_answer_adopt_profile.png")
//                cell.choice_answer_line.isHidden = false
//                cell.choice_thanks_message_label.isHidden = false
//                cell.choice_rating_view.isHidden = false
//                cell.choice_rating_view.settings.updateOnTouch = false
//                cell.choice_rating_view.rating = Double(gino(rating)/2)
//                cell.choice_thanks_message_label.text = choose_message
//            }
//            if is_chosen == 1 && level == 2{
//                cell.choice_mentor_Img.image = UIImage(named: "main_answer_mentor_profile_ad.png")
//                cell.answer_background_Img.image = UIImage(named: "main_answer_mentor_box.png")
//                cell.choice_answer_line.isHidden = false
//                cell.choice_thanks_message_label.isHidden = false
//                cell.choice_rating_view.isHidden = false
//                cell.choice_rating_view.settings.updateOnTouch = false
//                cell.choice_rating_view.rating = Double(gino(rating)/2)
//                cell.choice_thanks_message_label.text = choose_message
//                cell.mentor_Img.isHidden = true
//            }
//        }
//        cell.choice_answer_Btn.addTarget(self, action: #selector(adopt(_:)), for: .touchUpInside)
//        
//        
//        
//        return cell
//    }
//
//    
//    //통신 성공
//    func networkResult(resultData: Any, code: String) {
//        
//        if code == "4-1"{
//            print("성공")
//            commentList = resultData as! [DetailCommentItemVO]
//            commentList.removeFirst()
//            
//            detailTableView.estimatedRowHeight = 40.0
//            detailTableView.rowHeight = UITableViewAutomaticDimension
//
//            bridge_Label.text = "\(commentList.count)개의 답변이 등록되었습니다."
//            if commentList.count == 0{
//                scrollview.contentSize = CGSize(width: self.view.frame.size.width, height: 0)
//            }
//            else {
//                scrollview.contentSize = CGSize(width: self.view.frame.size.width, height: 1030)
//            }
//            
//            detailTableView.reloadData()
//        }
//        else if code == "1"{
//            let msg = resultData as! String
//            simpleAlert(title: "에러", msg: msg)
//        }
//        else if code == "2"{
//            let msg = resultData as! String
//            simpleAlert(title: "에러", msg: msg)
//        }
//        else if code == "3"{
//            let msg = resultData as! String
//            simpleAlert(title: "에러", msg: msg)
//        }
//        
//        if code == "4-2"{
//            choiceDetailList = resultData as! [DetailChoiceVO]
//        }
//    }
//    
//    //통신 실패
//    func networkFailed() {
//        simpleAlert(title: "오류", msg: "네트워크 연결을 확인하삼")
//    }
//    
//    override func viewDidLoad() {
//        
//        login_user_id = self.ud.integer(forKey: "user_id")
//        
//        // 답변하기 버튼 자신의 글 답변 금지
//        write_answer_Btn_Outlet.addTarget(self, action: #selector(write_answer), for: .touchUpInside)
//    }
//    
//    var comment_q_article_id : Int?
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        detailTableView.reloadData()
//        self.navigationItem.title = "공개 고민"
//
//        
//        choose_comment_Btn.setTitle("\(gino(comment_count))", for: .normal)
//        choose_like_Btn.addTarget(self, action: #selector(clickEvent(_:)), for: .touchUpInside)
//        
//        //내정보 공개에 따른 분기
//        if gino(open_name) == 1{
//            choose_nickname_Label.text = nickname
//            
//            if gino(age) <= 10{
//                choose_age_Label.text = "유아 / 기타 정보"
//            }
//            else if gino(age) <= 20 && gino(age) > 10{
//                choose_age_Label.text = "10대 / 기타 정보"
//            }
//            else if gino(age) <= 30 && gino(age) > 20{
//                choose_age_Label.text = "20대 / 기타 정보"
//            }
//            else if gino(age) <= 40 && gino(age) > 30{
//                choose_age_Label.text = "30대 / 기타 정보"
//            }
//            
//            if gender == 1{
//                choose_profile_Img.imageFromUrl(gsno(profile_picture), defaultImgPath: "profile_woman.png")
//            }
//            else if gender == 2{
//                choose_profile_Img.imageFromUrl(gsno(profile_picture), defaultImgPath: "profile_man.png")
//            }
//        }
//        else {
//            choose_nickname_Label.text = "비공개"
//            choose_age_Label.text = ""
//            
//            if gender == 1{
//                choose_profile_Img.imageFromUrl("", defaultImgPath: "profile_woman.png")
//            }
//            else if gender == 2{
//                choose_profile_Img.imageFromUrl("", defaultImgPath: "profile_man.png")
//            }
//        }
//        
//        choose_title_Label.text = title_title
//        choose_content_Label.text = content
//        choose_reward_ink_Label.text = "\(gino(rInk)) ink"
//        
//        let currentTime = getCurrentMillis()
//        let wr_time = Int64(gino(time))
//        let write_time : Int64 = (currentTime - wr_time) / 1000 / 60
//        var time1 = Int(write_time)
//        
//        if time1 <= 1 {
//            choose_time_Label.text = "방금 전"
//        }
//        else{
//            choose_time_Label.text = "\(time1) 분전"
//            if time1 >= 60 {
//                time1 /= 60
//                choose_time_Label.text = "\(time1) 시간전"
//                if time1 >= 24{
//                    time1 /= 24
//                    choose_time_Label.text = "\(time1) 일전"
//                }
//            }
//        }
//        
//        
//        //사진 이미지뷰 둥글게 만들기
//        choose_profile_Img.clipsToBounds = true
//        choose_profile_Img.layer.cornerRadius = choose_profile_Img.frame.size.width / 2
//        
//        detailTableView.delegate = self
//        detailTableView.dataSource = self
//        
//        let model = DetailModel(self)
//        model.getDetailComment(article_id: gino(article_id))
//        
//        //이미지뷰 클릭시 프로필로 이동
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
//        
//        choose_profile_Img.isUserInteractionEnabled = true
//        choose_profile_Img.addGestureRecognizer(tapGestureRecognizer)
//        
//    }
//    
//    //이미지뷰 클릭시 프로필 이동 메소드
//        func imageTapped(_ sender : AnyObject){
//            
//            guard let user_profile = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as? UserProfileVC else {
//                return
//            }
//    
//            user_profile.user_id = now_user_id
//            self.present(user_profile, animated: true)
//        }
//    
//    @IBAction func comment_Btn(_ sender: Any) {
//        
//        guard let comment = storyboard?.instantiateViewController(withIdentifier: "Comment") as? Comment else{
//            return
//        }
//        comment.article_id = gino(article_id)
//        
//        navigationController?.pushViewController(comment, animated: true)
//    }
//    
//    @IBAction func unwindToDetailMain(segun : UIStoryboardSegue){}
//    
//    
//}
