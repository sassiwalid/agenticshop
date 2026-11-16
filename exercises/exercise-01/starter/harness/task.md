# Task. Product search

## Goal

Implement the feature described below in the `Catalog` module.

Customers need to find a product by typing part of its name.

| Id | Requirement |
|---|---|
| SEARCH-1 | An empty query, or a query made of spaces only, returns every product. |
| SEARCH-2 | Matching ignores case and diacritics. "cafe" finds "Café Press". |
| SEARCH-3 | A product matches when the query is contained in its name, or equals one of its tags. |
| SEARCH-4 | Results keep the order of the catalog. |

The feature works with any `ProductCatalog`, in memory or remote. No user interface in this version.

## Scope

You may change files under `Packages/Catalog/`. Nothing else.

## Verify

Run `swift test`. Every requirement SEARCH-1 to SEARCH-4 has at least one test whose name contains its identifier.

## Stop and report, without making the change, if

- a file outside the scope must change
- a requirement is ambiguous
- a test fails for a reason unrelated to your change

## Report

- the files you changed
- the output of `swift test`
- any assumption you made
