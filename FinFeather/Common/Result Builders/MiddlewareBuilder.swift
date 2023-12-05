//
//  MiddlewareBuilder.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

@resultBuilder
struct MiddlewareBuilder<Action> {

    static func buildBlock(_ middlewares: AnyMiddleware<Action>...) -> MiddlewarePipeline<Action> {
        MiddlewarePipeline(middlewares)
    }

    static func buildArray(_ middlewares: [MiddlewarePipeline<Action>]) -> AnyMiddleware<Action> {
        MiddlewarePipeline(middlewares.map { $0.eraseToAnyMiddleware() }).eraseToAnyMiddleware()
    }

    static func buildOptional(_ middleware: MiddlewarePipeline<Action>?) -> AnyMiddleware<Action> {
        guard let middleware else {
            return EchoMiddleware().eraseToAnyMiddleware()
        }
        return middleware.eraseToAnyMiddleware()
    }

    static func buildEither<M: MiddlewareType>(first middleware: M) -> AnyMiddleware<Action> where M.Action == Action {
        middleware.eraseToAnyMiddleware()
    }

    static func buildEither<M: MiddlewareType>(second middleware: M) -> AnyMiddleware<Action> where M.Action == Action {
        middleware.eraseToAnyMiddleware()
    }

    static func buildFinalResult<M: MiddlewareType>(_ middleware: M) -> AnyMiddleware<Action> where M.Action == Action {
        middleware.eraseToAnyMiddleware()
    }
}
