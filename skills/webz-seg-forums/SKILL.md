---
name: webz-seg-forums
description: Count forum posts with the Webz.io aggregate_webz_forums MCP tool. Use when the user wants which forums, boards, authors, or countries discuss a topic the most, rather than the threads themselves.
metadata:
  webz-tools: aggregate_webz_forums
---

# Webz.io Forums Segmentation

Use the `aggregate_webz_forums` MCP tool to count forum and discussion posts. It returns bucket counts, not posts. The server adds `site_type:discussions` to `q`.

## When to use

- The user asks which forums, boards, authors, or countries discuss a topic the most.
- For the threads themselves, use `search_webz_discussions`.

## How to call

- `q`: required Boolean query. A space means AND. `AND`, `OR`, and `NOT` are uppercase. Quote phrases (`"product recall"`).
- `field`: what to count. Default `thread.site,thread.site_section` runs both, as two requests. One field is one credit.
- `days`: lookback. Default 7. Maximum 31.
- `from_offset`: next page of buckets. A response has at most 10 buckets, up to 100 total.
- `include_syndicated`: default false.
- `webz_reporter`: default false. Its own argument. A `webz_reporter:` clause inside `q` does not include those posts.

## Fields

- Forum and board: `thread.site` (the forum), `thread.site_section` (the board), `author`, `thread.country`, `language`, `rating`.

Forums have no person, company, location, or ticker extraction. `persons`, `organizations`, `topic`, `sentiment`, `category`, and `trust.*` are rejected here.

"Which forums and boards talked the most about a product recall this week" -> `q`: `"product recall"`, `field`: `thread.site,thread.site_section`, `days`: `7`.

## Using results

- Report the bucket name and its count. Say these are post counts, and name the query and the day window.
- Each comma-separated field is a separate call and costs 1 credit. Wait at least 0.4 seconds between calls. Do not call this tool in parallel.
- Ask for another page with the same `q`, `field`, and `days` plus the returned `from_offset` when the user wants more than the first 10 buckets.
- Zero buckets is a successful empty count. Retry once with a broader `q` or a different `field` before reporting that the topic has no counts.
