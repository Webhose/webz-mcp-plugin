---
name: webz-blogs
description: Search blog posts with the Webz.io search_webz_blogs MCP tool. Use when the user wants blogs, bloggers, or a company blog rather than news sites or forums.
metadata:
  webz-tools: search_webz_blogs
---

# Webz.io Blogs

Use the `search_webz_blogs` MCP tool to search blog posts.

## When to use

- The user asks about blogs, bloggers, Medium, or a company blog.
- The question is about posts on blogs, rather than news articles or forum threads.

## How to call

- `q`: required Boolean query. A space means AND. `AND`, `OR`, and `NOT` are uppercase. Quote phrases and filter values that contain spaces (`"supply chain"`, `author:"jane doe"`). A leading minus means NOT.
- `days`: crawl lookback. The API default is 3 days. Use 7 for a week. 31 is the standard history limit.
- `size`: posts per page, 1-100. Default 10.
- `sort`: default `crawled`. Use `published` when the user wants newest first. `order` is `asc` or `desc`.
- `webz_reporter`: default false. Pass it as its own argument. A `webz_reporter:` clause inside `q` does not include those posts.
- `include_syndicated`: default false.
- Pagination: reuse the `ts`, `ni`, `ns`, or `from_offset` from the previous response with the same `q`. `ts` overrides `days`.

## Filters inside `q`

Values are case-insensitive. Language names are lowercase full names (`language:english`). Country codes are ISO-2 (`country:US`).

- Source: `site:medium.com`, `site_section:`, `domain_rank:<1000`.
- Content: `title:bitcoin`, `text:"supply chain"`, `author:"jane doe"`.
- Entities: `person:"elon musk"`, `organization:nvidia`, `location:paris`, `ticker:AAPL`, `exchange:NASDAQ`. Entity extraction covers English, German, Spanish, and Italian.

`category:`, `sentiment:`, and `trust.*` are news-only and return zero blog posts. Leave them out.

Map only what the user asked for. "English Medium posts about supply chain delays" -> `"supply chain" delays site:medium.com language:english`.

## Using results

- Each result has a title, URL, publish date, site, language, and an excerpt of about 600 characters.
- `Total results` is the match count. The page holds only `size` posts.
- Cite the post URLs.
- Zero posts is a successful empty search. Retry once with a broader `q` (drop `site:`, `language:`, `country:`, or a tight phrase) or a larger `days` before reporting nothing found.
- Wait at least 0.4 seconds between calls. Do not call this tool in parallel.
