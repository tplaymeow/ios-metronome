extension MetronomeClient {
  public static var unimplemented: Self {
    .init(
      _implementation: .init(
        setup: .unimplemented(
          #"@Dependency(\.metronome.setup)"#),
        play: .unimplemented(
          #"@Dependency(\.metronome.play)"#),
        stop: .unimplemented(
          #"@Dependency(\.metronome.stop)"#)
      )
    )
  }
}
