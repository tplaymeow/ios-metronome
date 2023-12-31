import CasePaths
import URLRouting

let appRouter = OneOf {
  Route(.case(AppRoute.default))

  Route(.case(AppRoute.startMetronome)) {
    Path { "startMetronome" }
  }

  Route(.case(AppRoute.stopMetronome)) {
    Path { "stopMetronome" }
  }
}.baseURL("tplaymeow://metronome")
