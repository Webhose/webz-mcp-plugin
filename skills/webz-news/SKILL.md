---
name: webz-news
description: Search published news articles with the Webz.io search_webz_news MCP tool. Use when the user wants news filtered by outlet, language, country, sentiment, category, person, company, or ticker.
metadata:
  webz-tools: search_webz_news
---

# Webz.io News

Use the `search_webz_news` MCP tool to search published news articles.

## When to use

- The user wants news articles, outlets, or coverage that can be written as a Boolean query.
- The user names a source, language, country, sentiment, category, person, company, or ticker.

## How to call

- `q`: required Boolean query. A space means AND. `AND`, `OR`, and `NOT` are uppercase. Quote phrases and filter values that contain spaces (`"data breach"`, `person:"elon musk"`). A leading minus means NOT (`tesla -car`).
- `days`: crawl lookback. The API default is 3 days. Use 7 for a week. 31 is the standard history limit. Earlier coverage needs `allow_news_history: true`.
- `size`: posts per page, 1-100. Default 10.
- `sort`: default `crawled`, which pages through the full result set. Use `published` when the user wants newest first. `order` is `asc` or `desc`.
- `webz_reporter`: default false. Pass it as its own argument. A `webz_reporter:` clause inside `q` does not include those posts.
- `include_syndicated`: default false. Set true only when the user wants wire copies.
- Pagination: reuse the `ts`, `ni`, `ns`, or `from_offset` from the previous response with the same `q`. `ts` overrides `days`.

## Filters inside `q`

Values are case-insensitive. Language names are lowercase full names (`language:english`). Country codes are ISO-2 (`country:US`, `country:GB`).

- Source: `site:cnn.com`, `site_section:business`, `domain_rank:<1000`, `site_category:tech`.
- Content: `title:bitcoin`, `text:"supply chain"`, `author:"jane doe"`.
- `sentiment`: `positive`, `negative`, or `neutral`.
- `category`: one of 17 values. Quote multi-word values, for example `category:"Economy, Business and Finance"`. Values: Arts, Culture and Entertainment; Crime, Law and Justice; Disaster and Accident; Economy, Business and Finance; Education; Environment; Health; Human Interest; Labor; Lifestyle and Leisure; Politics; Religion and Belief; Science and Technology; Social Issue; Sport; War, Conflict and Unrest; Weather.
- `topic:"climate change"`, `person:"elon musk"`, `organization:nvidia`, `location:paris`, `ticker:AAPL`, `exchange:NASDAQ`.
- Trust: `trust.bias:left`, `center`, or `right`. `trust.source.type:newsroom`, `gov_news`, or `local_news`.
- Flags that stay inside `q`: `breaking:true`, `has_canonical:true`, `ai_allow:true`, `syndication.syndicated:false`.

Map only what the user asked for. "English UK news about Ronaldo" -> `Ronaldo language:english country:GB`. "Only CNN" -> `site:cnn.com`. "Negative Nvidia coverage" -> `organization:"nvidia" sentiment:negative`. "Apple earnings" -> `organization:apple ticker:AAPL`.

## Using results

- Each result has a title, URL, publish date, site, language, sentiment, and an excerpt of about 600 characters.
- `Total results` is the match count. The page holds only `size` posts.
- Cite the article URLs.
- Zero posts is a successful empty search. Retry once with a broader `q` (drop `site:`, `language:`, `country:`, category, sentiment, or a tight phrase) or a larger `days` before reporting nothing found.
- Wait at least 0.4 seconds between calls. Do not call this tool in parallel.
