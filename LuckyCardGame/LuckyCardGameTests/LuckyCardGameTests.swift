//
//  LuckyCardGameTests.swift
//  LuckyCardGameTests
//
//  Created by sangyeon on 2023/07/04.
//

import XCTest
@testable import LuckyCardGame

final class LuckyCardGameTests: XCTestCase {
    
    private var sut: LuckyGame!
    
    override func setUp() {
        super.setUp()
        let luckyCardManager = LuckyCardManager()
        sut = LuckyGame(cardManager: luckyCardManager)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - 참가자 수에 따라 적절하게 카드를 분배해주는지 테스트

    func test_카드분배_참가자가3명일때() {
        // given
        let gameType = LuckyGame.GameType.threePlayer
        
        // when
        _ = sut.splitCard(gameType: gameType)
        
        // then
        for index in 0..<gameType.playerCount {
            XCTAssertEqual(sut.players[index].cards.count, 8)
        }
        XCTAssertEqual(sut.remainCards.count, 9)
    }
    
    func test_참가자가3명일때_12번카드가_포함되지않는지() {
        // given
        let gameType = LuckyGame.GameType.threePlayer
        
        // when
        _ = sut.splitCard(gameType: gameType)
        
        // then
        for index in 0..<gameType.playerCount {
            XCTAssertFalse(sut.players[index].cards.contains(where: { $0.number == .twelve }))
        }
        XCTAssertFalse(sut.remainCards.contains(where: { $0.number == .twelve }))
    }
    
    func test_카드분배_참가자가4명일때() {
        // given
        let gameType = LuckyGame.GameType.fourPlayer
        
        // when
        _ = sut.splitCard(gameType: gameType)
        
        // then
        for index in 0..<gameType.playerCount {
            XCTAssertEqual(sut.players[index].cards.count, 7)
        }
        XCTAssertEqual(sut.remainCards.count, 8)
    }
    
    func test_카드분배_참가자가5명일때() {
        // given
        let gameType = LuckyGame.GameType.fivePlayer
        
        // when
        _ = sut.splitCard(gameType: gameType)
        
        // then
        for index in 0..<gameType.playerCount {
            XCTAssertEqual(sut.players[index].cards.count, 6)
        }
        XCTAssertEqual(sut.remainCards.count, 6)
    }
    
    // MARK: - 카드 숫자 오름차순 정렬 테스트
    
    func test_플레이어의카드를_숫자오름차순정렬() {
        // given
        let stringLiteralsArray = [
            ["🐶01", "🐮01", "🐱01", "🐱10", "🐱05", "🐮09", "🐱06", "🐮02"],
            ["🐱07", "🐶10", "🐶11", "🐮03", "🐶04", "🐶02", "🐮08", "🐶06"],
            ["🐮04", "🐱08", "🐮07", "🐱04", "🐱09", "🐱03", "🐱02", "🐶03"],
            ["🐱11", "🐶08", "🐮05", "🐶09", "🐮06", "🐶05", "🐮10", "🐶07", "🐮11"]]
        let splitedCards: [[LuckyCard]] = stringLiteralsArray
            .map { $0.compactMap { .init(stringLiteral: $0) } }
        
        let luckyCardManager = MockLuckyCardManager(splitedCards: splitedCards)
        sut = LuckyGame(cardManager: luckyCardManager)
        let gameType = LuckyGame.GameType.threePlayer
        
        let playerIndex = 0
        _ = sut.splitCard(gameType: gameType)
        
        // when
        sut.sortPlayerCards(playerIndex: playerIndex)
        
        // then
        XCTAssertEqual(splitedCards[0].sorted(), sut.players[playerIndex].cards)
    }
    
    func test_바닥카드를_숫자오름차순정렬() {
        // given
        let stringLiteralsArray = [
            ["🐶01", "🐮01", "🐱01", "🐱10", "🐱05", "🐮09", "🐱06", "🐮02"],
            ["🐱07", "🐶10", "🐶11", "🐮03", "🐶04", "🐶02", "🐮08", "🐶06"],
            ["🐮04", "🐱08", "🐮07", "🐱04", "🐱09", "🐱03", "🐱02", "🐶03"],
            ["🐱11", "🐶08", "🐮05", "🐶09", "🐮06", "🐶05", "🐮10", "🐶07", "🐮11"]]
        let splitedCards: [[LuckyCard]] = stringLiteralsArray
            .map { $0.compactMap { .init(stringLiteral: $0) } }
        
        let luckyCardManager = MockLuckyCardManager(splitedCards: splitedCards)
        sut = LuckyGame(cardManager: luckyCardManager)
        
        let gameType = LuckyGame.GameType.threePlayer
        _ = sut.splitCard(gameType: gameType)
        
        // when
        sut.sortRemainCards()
        
        // then
        XCTAssertEqual(splitedCards[gameType.playerCount].sorted(), sut.remainCards)
    }
    
    // MARK: - 그 외 테스트
    
    func test_같은숫자카드3개를가진_플레이어가존재하는지() {
        // given
        let stringLiteralsArray = [
            ["🐶01", "🐮01", "🐱01", "🐱10", "🐱05", "🐮09", "🐱06", "🐮02"],
            ["🐱07", "🐶10", "🐶11", "🐮03", "🐶04", "🐶02", "🐮08", "🐶06"],
            ["🐮04", "🐱08", "🐮07", "🐱04", "🐱09", "🐱03", "🐱02", "🐶03"],
            ["🐱11", "🐶08", "🐮05", "🐶09", "🐮06", "🐶05", "🐮10", "🐶07", "🐮11"]]
        let splitedCards: [[LuckyCard]] = stringLiteralsArray
            .map { $0.compactMap { .init(stringLiteral: $0) } }
        
        let luckyCardManager = MockLuckyCardManager(splitedCards: splitedCards)
        sut = LuckyGame(cardManager: luckyCardManager)
        
        _ = sut.splitCard(gameType: .threePlayer)
        
        // then
        XCTAssertTrue(sut.existsPlayerHaving3SameNumberCard())
    }

    func test_참가자의최대최소숫자카드와_바닥카드중_3개선택했을때_같은지() {
        // given
        let stringLiteralsArray = [
            ["🐶01", "🐮01", "🐱01", "🐱10", "🐱05", "🐮09", "🐱06", "🐮02"],
            ["🐱07", "🐶10", "🐮03", "🐶04", "🐶02", "🐮08", "🐶06", "🐶11"],
            ["🐮04", "🐱08", "🐮07", "🐱04", "🐱09", "🐱03", "🐱02", "🐮11"],
            ["🐱11", "🐶08", "🐮05", "🐶09", "🐮06", "🐶05", "🐮10", "🐶07", "🐶03"]]
        let splitedCards: [[LuckyCard]] = stringLiteralsArray
            .map { $0.compactMap { .init(stringLiteral: $0) } }
        
        let luckyCardManager = MockLuckyCardManager(splitedCards: splitedCards)
        sut = LuckyGame(cardManager: luckyCardManager)
        
        _ = sut.splitCard(gameType: .threePlayer)
        
        // when
        sut.selectPlayerCard(playerIndex: 1, cardIndex: 7)
        sut.selectPlayerCard(playerIndex: 2, cardIndex: 7)
        sut.selectRemainCard(index: 0)
        
        // then
        XCTAssertTrue(sut.checkSelectedCardsAreSame())
    }
}
