//
//  Game.swift
//  QuizEnginee
//
//  Created by Hoang Anh Tuan on 17/02/2022.
//

import Foundation

public class Game<Question, Answer, R: Router> where Question == R.Question, Answer == R.Answer {
    private let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question: Hashable, Answer: Equatable, R: Router>(question: [Question],
                                                   router: R,
                                                   correctAnswer: [Question: Answer]) -> Game<Question, Answer, R> where Question == R.Question, Answer == R.Answer {
    let flow = Flow(questions: question, router: router, scoring: scoring(correctAnswer: correctAnswer))
    flow.start()
    let game = Game(flow: flow)
    return game
}

private func scoring<Question: Hashable, Answer: Equatable>(correctAnswer: [Question: Answer]) -> (([Question: Answer]) -> Int) {
    return { answer in
        return correctAnswer.reduce(0) { score, data in
            return answer[data.key] == data.value ? score + 1 : score
        }
    }
}
