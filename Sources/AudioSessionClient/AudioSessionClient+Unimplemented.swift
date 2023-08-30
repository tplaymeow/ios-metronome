import DependenciesAdditionsBasics

extension AudioSessionClient {
  public static var unimplemented: Self {
    .init(
      _implementation: .init(
        category: .unimplemented(
          #"@Dependency(\.audioSession.category)"#),
        mode: .unimplemented(
          #"@Dependency(\.audioSession.mode)"#),
        routeSharingPolicy: .unimplemented(
          #"@Dependency(\.audioSession.routeSharingPolicy)"#),
        set: .unimplemented(
          #"@Dependency(\.audioSession.set)"#),
        activate: .unimplemented(
          #"@Dependency(\.audioSession.activate)"#),
        deactivate: .unimplemented(
          #"@Dependency(\.audioSession.deactivate)"#),
        observeOutputVolume: .unimplemented(
          #"@Dependency(\.audioSession.observeOutputVolume)"#)
      )
    )
  }
}
