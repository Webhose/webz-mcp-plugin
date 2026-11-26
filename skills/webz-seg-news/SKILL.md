---
name: webz-seg-news
description: Count mentions in news with the Webz.io aggregate_webz_news MCP tool. Use when the user wants who, which companies, which sites, or which sentiment shows up most in news, rather than the articles themselves.
metadata:
  webz-tools: aggregate_webz_news
---

# Webz.io News Segmentation

Use the `aggregate_webz_news` MCP tool to count mentions in news. It returns bucket counts, not articles.

## When to use

- The user asks who or what is mentioned most, which outlets covered a topic, or how sentiment splits.
- A list of headlines would not answer the question. For the articles themselves, use `search_webz_news`.

## How to call

- `q`: required Boolean query, same language as news search. A space means AND. `AND`, `OR`, and `NOT` are uppercase. Quote phrases (`"climate policy"`).
- `field`: what to count. Default `persons,organizations` runs both, as two requests. One field is one credit.
- `days`: lookback. Default 7. Maximum 31.
- `from_offset`: next page of buckets. A response has at most 10 buckets, up to 100 total.
- `include_syndicated`: default false.
- `webz_reporter`: default false. Its own argument. A `webz_reporter:` clause inside `q` does not include those posts.

## Fields

Pick the field the user asked about. Leave the default when they ask who and which companies.

- People and companies: `persons`, `organizations`. Sentiment splits: `person.positive`, `person.negative`, `person.neutral`, and the same three suffixes for `organization`.
- Places and markets: `locations`, `trading_symbol.ticker`, `trading_symbol.exchange`.
- Sources: `thread.site`, `thread.site_section`, `thread.country`, `author`, `language`.
- News-only buckets: `sentiment`, `category`, `topic`, `trust.bias`, `trust.category`, `trust.source.type`.

Language names inside `q` are lowercase (`language:english`). Country codes are ISO-2 (`country:US`).

"Who and which companies show up in English news about climate policy this week" -> `q`: `"climate policy" language:english`, `field`: `persons,organizations`, `days`: `7`.

## Using results

- Report the bucket name and its count. Say these are mention counts, not article counts, and name the query and the day window.
- Each comma-separated field is a separate call and costs 1 credit. Wait at least 0.4 seconds between calls. Do not call this tool in parallel.
- Ask for another page with the same `q`, `field`, and `days` plus the returned `from_offset` when the user wants more than the first 10 buckets.
- Zero buckets is a successful empty count. Retry once with a broader `q` or a different `field` before reporting that the topic has no counts.
