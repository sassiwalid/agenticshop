# Feature request. Product search

Customers need to find a product by typing part of its name.

## Requirements

| Id | Requirement |
|---|---|
| SEARCH-1 | An empty query, or a query made of spaces only, returns every product. |
| SEARCH-2 | Matching ignores case and diacritics. "cafe" finds "Café Press". |
| SEARCH-3 | A product matches when the query is contained in its name, or equals one of its tags. |
| SEARCH-4 | Results keep the order of the catalog. |

## Boundaries

- The feature belongs to the `Catalog` module.
- It works with any `ProductCatalog`, in memory or remote.
- No user interface in this version.
