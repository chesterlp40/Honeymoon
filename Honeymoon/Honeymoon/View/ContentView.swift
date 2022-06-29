//
//  ContentView.swift
//  Honeymoon
//
//  Created by Ezequiel Rasgido on 29/06/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @State var showAlert = false
    @State var showGuideView = false
    @State var showInfoView = false
    @State private var lastCardIndex = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    @GestureState private var dragState = DragState.inactive
    
    private var dragAreaThreshold: CGFloat = 65.0
    
    // MARK: - CARDS VIEWS
    
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(
                CardView(
                    destination: honeymoonData[index]
                )
            )
        }
        return views
    }()
    
    // MARK: - MOVE CARD
    
    private func moveCards() {
        cardViews.removeFirst()
        self.lastCardIndex += 1
        let honeymoon = honeymoonData[self.lastCardIndex % honeymoonData.count]
        let newCardView = CardView(destination: honeymoon)
        self.cardViews.append(newCardView)
    }
    
    // MARK: - TOP CARD
    
    private func isTopCard(
        _ cardView: CardView)
    -> Bool {
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id}) else {
            return false
        }
        return index == 0
    }
    
    // MARK: - DRAG STATES
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .inactive:
                return false
            case .pressing, .dragging:
                return true
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // MARK: - HEADER
            HeaderView(
                showGuideView: $showGuideView,
                showInfoView: $showInfoView
            )
            .opacity(self.dragState.isDragging ? 0.0 : 1.0)
            .animation(.default)
            
            Spacer()
            
            // MARK: - CARDS
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                // MARK: X MARK SYMBOL
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(
                                        self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView) ? 1.0 : 0.0
                                    )
                                
                                // MARK: X HEART SYMBOL
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(
                                        self.dragState.translation.width > self.dragAreaThreshold && self.isTopCard(cardView) ? 1.0 : 0.0
                                    )
                            }
                        )
                        .offset(
                            x: self.isTopCard(cardView) ? self.dragState.translation.width : 0,
                            y: self.isTopCard(cardView) ? self.dragState.translation.height : 0
                        )
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView) ? 0.85 : 1.0)
                        .rotationEffect(
                            Angle(
                                degrees: self.isTopCard(cardView) ? Double(self.dragState.translation.width / 12) : 0
                            )
                        )
                        .animation(
                            .interpolatingSpring(
                                stiffness: 120,
                                damping: 120
                            )
                        )
                        .gesture(
                            LongPressGesture(minimumDuration: 0.1)
                                .sequenced(before: DragGesture())
                                .updating($dragState, body: { (value, state, transaction) in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                                .onChanged({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragAreaThreshold {
                                        self.cardRemovalTransition = .leadingBottom
                                    }
                                    
                                    if drag.translation.width > self.dragAreaThreshold {
                                        self.cardRemovalTransition = .trailingBottom
                                    }
                                })
                                .onEnded({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                        playSound(sound: "sound-rise", type: "mp3")
                                        self.moveCards()
                                    }
                                })
                        )
                        .transition(self.cardRemovalTransition)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // MARK: - FOOTER
            FooterView(
                showBookingAlert: $showAlert
            )
            .opacity(self.dragState.isDragging ? 0.0 : 1.0)
            .animation(.default)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("SUCCESS"),
                message: Text("Whishing a lovely and most precious of the times together for the amazing couple."),
                dismissButton: .default(Text("Happy Honeymoon!"))
            )
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
