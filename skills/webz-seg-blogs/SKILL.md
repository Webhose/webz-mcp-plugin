---
name: webz-seg-blogs
description: Count blog posts with the Webz.io aggregate_webz_blogs MCP tool. Use when the user wants which blogs, authors, or companies write the most about a topic, rather than the posts themselves.
metadata:
  webz-tools: aggregate_webz_blogs
---

# Webz.io Blogs Segmentation

Use the `aggregate_webz_blogs` MCP tool to count blog posts. It returns bucket counts, not posts. The server adds `site_type:blogs` to `q`.

## When to use

- The user asks which blogs, authors, or companies dominate a topic on blogs.
- For the posts themselves, use `search_webz_blogs`.

## How to call

- `q`: required Boolean query. A space means AND. `AND`, `OR`, and `NOT` are uppercase. Quote phrases.
- `field`: what to count. Default `thread.site,organizations` runs both, as two requests. One field is one credit.
- `days`: lookback. Default 7. Maximum 31.
- `from_offset`: next page of buckets. A response has at most 10 buckets, up to 100 total.
- `include_syndicated`: default false.
- `webz_reporter`: default false. Its own argument. A `webz_reporter:` clause inside `q` does not include those posts.

## Fields

- Blog and writer: `thread.site` (the blog), `author`, `thread.site_section`, `thread.country`, `language`.
- Entities: `persons`, `organizations`, `locations`, `trading_symbol.ticker`, `trading_symbol.exchange`. Sentiment splits use the `.positive`, `.negative`, and `.neutral` suffixes on `person` and `organization`.

`topic`, `sentiment`, `category`, `rating`, and `trust.*` exist on news only and are rejected here.

"Which blogs wrote the most about bitcoin this week" -> `q`: `bitcoin`, `field`: `thread.site`, `days`: `7`.

## Using results

- Report the bucket name and its count. Say these are post counts, and name the query and the day window.
- Each comma-separated field is a separate call and costs 1 credit. Wait at least 0.4 seconds between calls. Do not call this tool in parallel.
- Ask for another page with the same `q`, `field`, and `days` plus the returned `from_offset` when the user wants more than the first 10 buckets.
- Zero buckets is a successful empty count. Retry once with a broader `q` or a different `field` before reporting that the topic has no counts.
