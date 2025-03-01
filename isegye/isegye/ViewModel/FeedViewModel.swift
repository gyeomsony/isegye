//
//  FeedViewModel.swift
//  isegye
//
//  Created by 손겸 on 3/1/25.
//

import Combine

class FeedViewModel {
    // 좋아요 상태를 Published로 관리
    @Published var isLiked: Bool = false
    
    // 좋아요 버튼이 눌렸을 때 호출될 메서드
    func toggleLike() {
        isLiked.toggle()
    }
}
