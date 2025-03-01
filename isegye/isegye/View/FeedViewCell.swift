//
//  FeedViewCell.swift
//  isegye
//
//  Created by 손겸 on 3/1/25.
//

import UIKit
import SnapKit

class FeedViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FeedViewCell"
    
    // 프로필 이미지
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    // 닉네임 라벨
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    // 작성 시간 라벨
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    // 글 내용 라벨
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // 버튼 설정은 맨 아래 Extension으로 분리함
    // 좋아요 버튼
    let likeButton: UIButton = UIButton.createCustomButton(
        imageName: "heart",
        title: "10",
        imageSize: 15,
        textSize: 10)
    
    // 댓글 버튼
    let commentButton: UIButton = UIButton.createCustomButton(
        imageName: "comment",
        title: "10",
        imageSize: 15,
        textSize: 10)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 레이아웃 제약
    private func setupLayout() {
        [ profileImageView,
          nicknameLabel,
          timeLabel,
          contentLabel,
          likeButton,
          commentButton
        ].forEach {
            contentView.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalTo(16)
            $0.width.height.equalTo(40)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nicknameLabel)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.leading.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(16)
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        commentButton.snp.makeConstraints {
            $0.top.equalTo(likeButton)
            $0.leading.equalTo(likeButton.snp.trailing).offset(16)
        }
    }
    
    // 데이터를 셀에 바인딩 하는 메서드
    func configure(with post: Post) {
        nicknameLabel.text = post.nickname
        timeLabel.text = post.time
        contentLabel.text = post.content
        likeButton.configuration?.title = "\(post.likes)"
        commentButton.configuration?.title = "\(post.comments)"
    }
}

// UIButton 확장
extension UIButton {
    static func createCustomButton(imageName: String, title: String, imageSize: CGFloat, textSize: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(
            systemName: imageName,
            withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .light, scale: .default)
        )
        
        // 텍스트 스타일 설정
        let attributedString = NSAttributedString(
            string: title,
            attributes: [
                .font: UIFont.systemFont(ofSize: textSize, weight: .light),
                .foregroundColor: UIColor.gray
            ]
        )
        config.attributedTitle = AttributedString(attributedString)
        
        config.imagePadding = 2
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -2, bottom: 0, trailing: 0)
        button.configuration = config
        button.tintColor = .gray
        return button
    }
}
