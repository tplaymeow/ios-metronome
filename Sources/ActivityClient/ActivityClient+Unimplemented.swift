extension ActivityClient {
  public static var unimplemented: Self {
    .init(
      _implementation: .init(
        request: .unimplemented(
          #"@Dependency(\.activity.request)"#),
        update: .unimplemented(
          #"@Dependency(\.activity.update)"#),
        end: .unimplemented(
          #"@Dependency(\.activity.end)"#)
      )
    )
  }
}
