import MetronomeModels

extension MetronomeClient {
  public static var dummy: Self {
    .init(
      _implementation: .init(
        setup: .init { item in
          func dummy(_: AudioItem) async throws {}
          return try await dummy(item)
        },
        play: .init { tempo in
          func dummy(_: Tempo) async throws {}
          return try await dummy(tempo)
        },
        stop: .init {
          func dummy() async {}
          return await dummy()
        }
      )
    )
  }
}
