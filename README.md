# TryDiffableDataSource

+ [WWDC 2019 - Advances in UI Data Sources](https://developer.apple.com/videos/play/wwdc2019/220/)
+ [medium.com/@tlimaye91/what-is-diffabledatasource-in-ios13](https://medium.com/@tlimaye91/what-is-diffabledatasource-in-ios13-fcfcf5f27115)

iOS 13 bring a whole new way of loading UITableview and UICollectionViews.

**DiffableDataSource** is completely new approach to change your tableview data with all basic operations with less code. Instead of _performbatchupdates_ it has a simple method called **apply**.

**Key concept**

+ Snapshot, truth of UI state, no more indexPaths, unique identifiers for sections and items
+ Identifiers, must be uniquea and conforms to hashable
+ `dataSource.apply()` replace `perfomBatchUpdates()`
+ See `UICollectionViewDiffableDataSource` and `UITableViewDiffableDataSource`

**What is a Snapshot???**
It is the current state of the UI. It has unique identifier for sections and items. One of the thing you might like is — It does not have indexPaths.

Share sheet on iOS 13 is built on top of *DiffableDataSource*
