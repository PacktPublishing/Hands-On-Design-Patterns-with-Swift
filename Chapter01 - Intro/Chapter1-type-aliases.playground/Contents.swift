import Foundation
import Cocoa

typealias MyString = String
typealias Block = () -> Void
typealias TypedBlock<T, U> = (T) -> U
typealias ReturningBlock<U> = () -> U

typealias RBlock = ReturningBlock<()>

protocol SomeProtocol {}
protocol OtherProtocol {}
typealias ViewControllerProtocol = NSViewController & SomeProtocol
typealias BothProtocols = SomeProtocol & OtherProtocol
