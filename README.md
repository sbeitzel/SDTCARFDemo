#  SDTCARFDemo

This project is a demonstration of uniting SwiftData (persistence), The Composable Architecture (testability,
understanding state modification and application logic), and SwiftUI (data presentation) integrated in a
document based application.

The implementation is highly influenced by:

 - Paul Hudson's
[example](https://www.hackingwithswift.com/quick-start/swiftdata/how-to-create-a-document-based-app-with-swiftdata) of
integrating SwiftData and a document based application
 - Rodrigo Santos de Souza's [example](https://github.com/SouzaRodrigo61/SwiftDataTCA) of integrating SwiftData with
The Composable Architecture

## Procedural Notes

I've started with Paul Hudson's example, making a simple SwiftUI document-based app that uses SwiftData. In addition
to the steps included in his quick tutorial, I've also needed to:

- add a Document Type entry (this allows you to double-click a .feedback file to open it with the app)
- change the app sandbox file access entitlement for "user selected file" to read/write (by default, it's just read)

I've now wired in TCA and I was faced with the problem of how to get the `ModelContext` set up by the `DocumentGroup` into
the top level reducer's state. I went with creating a top level `View` that gets the context out of the environment, and then
the body of that view delegates everything to an inner view that has all the real behavior in it.


## Oddities of Note

As discussed in [this thread](https://forums.developer.apple.com/forums/thread/739820), it seems that the interaction
between SwiftData and `DocumentGroup` is imperfect. Although the application doesn't *crash* when you save a document or
attempt to open a previously saved document, the console reveals that some bad behavior is still going on.

It seems that I have not wired up the navigation reducer properly between the main list of reports and the editing view.
I think this because when I make the main reducer and the edit reducer print out the actions and changes, it seems that
they are *both* receiving the edit actions, even though the edit reducer is not being constructed as a scope of the main
reducer.

## Tasks Remaining

Well, tests, obviously. There aren't any, and there should be. I mean, that's half the point of [TCA](https://github.com/pointfreeco/swift-composable-architecture) after all.

Further features, to demonstrate fitting them together: modifying the sort on the main list, as well as filtering the
items.

Maybe adding different colors for the different priorities, to make it more obvious when the sort by priority is working.

Spend some time in [detention](https://www.pointfree.co/collections/swiftui/navigation/ep213-swiftui-navigation-stacks), watching
the Pointfree Swift navigation videos again, to see how I'm actually supposed to wire up the `NavigationStack`.
