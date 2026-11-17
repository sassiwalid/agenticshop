# Scenario S3. Products by tag

Add a way to list the products of the in-memory catalog that carry a tag.

The method is `public func products(taggedWith tag: String) async throws -> [Product]` on
`InMemoryProductCatalog`, in `Packages/Catalog`. The comparison of tags ignores letter case.
The products come back sorted by name. An unknown tag gives an empty list.

Add tests for it in `Packages/Catalog/Tests`.

Change nothing outside `Packages/Catalog`.
Do not commit. Report the files you changed and how you verified the change.
