//
//  FeedTableViewCell.swift
//  isegye
//
//  Created by 손겸 on 3/1/25.
//

import UIKit
import SnapKit
import Combine

class FeedTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FeedTableViewCell"
    
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
        textSize: 15
    )
    
    // 댓글 버튼
    let commentButton: UIButton = UIButton.createCustomButton(
        imageName: "bubble.right",
        title: "10",
        imageSize: 15,
        textSize: 15
    )
    
    // ViewModel 프로퍼티
    var viewModel: FeedViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
        setupButtonActions()
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
        
        // FeedViewModel에 상태 업데이트
        viewModel?.isLiked = false // 초기 상태 설정
    }
    
    // 버튼 액션 설정
    private func setupButtonActions() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func likeButtonTapped() {
        viewModel?.toggleLike()
    }
    
    // ViewModel 바인딩
    private func bindViewModel() {
        viewModel?.$isLiked
            .receive(on: RunLoop.main)
            .sink { [weak self] isLiked in
                self?.likeButton.isSelected = isLiked
                self?.likeButton.tintColor = isLiked ? .systemRed : .gray
                self?.likeButton.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
            }
            .store(in: &cancellables)
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
        config.title = title
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: textSize, weight: .light)
            outgoing.foregroundColor = UIColor.gray
            return outgoing
        }
        
        config.imagePadding = 2
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -2, bottom: 0, trailing: 0)
        
        // 배경 설정
        config.background.backgroundColor = .clear // 배경색을 투명하게 설정
        config.background.strokeColor = .clear // 테두리 색상을 투명하게 설정
        
        button.configuration = config
        
        // 기본 색상
        button.tintColor = .gray
        
        // configurationUpdateHandler를 사용하여 highlighted 상태 처리
        button.configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            switch button.state {
            case .highlighted:
                // highlighted 상태에서 이미지와 텍스트 색상 변경
                updatedConfig?.image = UIImage(
                    systemName: "\(imageName).fill",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .light, scale: .default)
                )?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                updatedConfig?.baseForegroundColor = .systemRed
            case .selected:
                // selected 상태에서 이미지와 텍스트 색상 변경
                updatedConfig?.image = UIImage(
                    systemName: "\(imageName).fill",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .light, scale: .default)
                )?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                updatedConfig?.baseForegroundColor = .systemRed
            default:
                // 기본 상태
                updatedConfig?.image = UIImage(
                    systemName: imageName,
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .light, scale: .default)
                )?.withTintColor(.gray, renderingMode: .alwaysOriginal)
                updatedConfig?.baseForegroundColor = .gray
            }
            button.configuration = updatedConfig
        }
        
        return button
    }
}
