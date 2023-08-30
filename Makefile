test:
	@xcodebuild test \
	-scheme Metronome \
	-project App/Metronome.xcodeproj \
	-destination "platform=iOS Simulator,name=iPhone 14,OS=17.0"
