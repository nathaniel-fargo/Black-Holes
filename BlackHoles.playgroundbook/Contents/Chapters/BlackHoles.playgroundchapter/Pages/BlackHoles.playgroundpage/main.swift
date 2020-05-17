//: Welcome to my Playground! In this playground I've created the first Swift-only Black Hole Raycaster. I would love for you to share a little of my passion I've created around black holes, so I encourage you to share your own black hole that you will create!

// Because most of the code is modulated, all we need for this page is PlaygroundSupport
import PlaygroundSupport

// Create a master view, this is a UIView that manages every view
var masterView = MasterView()

// Start the program at the setup page
masterView.start(with: .setup)

// Set the liveView to the masterView
PlaygroundPage.current.liveView = masterView

// Make fullscreen
PlaygroundPage.current.wantsFullScreenLiveView = true