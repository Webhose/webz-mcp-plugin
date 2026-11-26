---
name: webz-forums
description: Search forum posts and replies with the Webz.io search_webz_discussions MCP tool. Use when the user wants Reddit threads, forum boards, replies, or what people are discussing.
metadata:
  webz-tools: search_webz_discussions
---

# Webz.io Forums

Use the `search_webz_discussions` MCP tool to search forum posts and replies.

## When to use

- The user asks about forums, Reddit, boards, threads, or replies.
- The question is what people are discussing, rather than what news sites or blogs published.

## How to call

- `q`: required Boolean query. A space means AND. `AND`, `OR`, and `NOT` are uppercase. Quote phrases (`"electric vehicle"`). A leading minus means NOT.
- `days`: crawl lookback. The API default is 3 days. Use 7 for a week. 31 is the standard history limit.
- `size`: posts per page, 1-100. Default 10.
- `sort`: default `crawled`. Use `published` for newest first, or `replies_count` when the user wants the busiest threads. `order` is `asc` or `desc`.
- `webz_reporter`: default false. Pass it as its own argument. A `webz_reporter:` clause inside `q` does not include those posts.
- `include_syndicated`: default false.
- Pagination: reuse the `ts`, `ni`, `ns`, or `from_offset` from the previous response with the same `q`. `ts` overrides `days`.

## Filters inside `q`

Values are case-insensitive. Language names are lowercase full names (`language:english`). Country codes are ISO-2 (`country:US`).

- Source: `site:reddit.com`, `site_section:` for a board, `domain_rank:<1000`.
- Content: `title:`, `text:`, `author:"jane doe"`.
- Thread: `is_first:true` for opening posts only, `is_first:false` for replies only.
- Volume: `replies_count:>20`, `participants_count:>5`.
- `rating:>4` on review-style posts (0-5).

Forums have no `category`, `sentiment`, `trust`, `person`, `organization`, `location`, or `ticker` filters. Those clauses return zero posts.

Map only what the user asked for. "English Reddit threads about electric vehicles with many replies" -> `site:reddit.com language:english "electric vehicle" replies_count:>20`.

## Using results

- Each result has a title, URL, publish date, site, language, and an excerpt of about 600 characters. A result may be an opening post or a reply.
- `Total results` is the match count. The page holds only `size` posts.
- Cite the thread URLs.
- Zero posts is a successful empty search. Retry once with a broader `q` (drop `site:`, `language:`, `replies_count`, or a tight phrase) or a larger `days` before reporting nothing found.
- Wait at least 0.4 seconds between calls. Do not call this tool in parallel.
