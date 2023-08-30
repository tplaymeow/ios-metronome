extension ActivityClient {
  public static var dummy: Self {
    .init(
      _implementation: .init(
        request: .init {
          func dummy<A, B, C>(_: A, _: B, _: C) async throws {}
          return try await dummy($0, $1, $2)
        },
        update: .init {
          func dummy<A>(_: A) async throws {}
          return try await dummy($0)
        },
        end: .init {
          func dummy<A, B>(_: A, _: B) async throws {}
          return try await dummy($0, $1)
        }
      )
    )
  }
}
