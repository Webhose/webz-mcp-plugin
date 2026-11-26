---
name: webz-news-answers
description: Answer one news question with the Webz.io answer_webz_news MCP tool. Use when the user wants a written, cited answer from news rather than a list of articles or mention counts.
metadata:
  webz-tools: answer_webz_news
---

# Webz.io News Answers

Use the `answer_webz_news` MCP tool to answer one question from Webz.io news.

## When to use

- The user asks a question and wants a written answer with sources.
- A short answer is enough unless they ask for detail, developments, or where reports disagree.

For a list of articles, use `search_webz_news` or `news_search_by_webz`. For mention counts, use `aggregate_webz_news`.

## How to call

- `query`: the question in the user's words. Required. At most 750 characters and 100 words. Leave it as a question. Do not rewrite it into a Boolean `q` string, and do not add dates or filters. The question is the whole request.
- `detailed`: `false` (default) is the short answer. `true` is the long answer, with developments, sources, and where reports disagree.
- Allow up to 30 seconds for the response.
- Wait at least 1 second between calls. Do not call this tool in parallel.

"Why has Nvidia been under regulatory scrutiny in the past week? Keep it short." -> `query`: that question, `detailed`: `false`.

## Using results

- The response starts with `Style: short` or `Style: detailed`, then the answer. `[1]` is the first citation. Keep the citation numbers and URLs in your reply.
- `total_results` is how many news matches backed the answer.
- If the answer says there is not enough evidence, say that. Do not invent sources or fill gaps from general knowledge.
- A failed call is not charged. Empty question, or a question over 750 characters or 100 words, is a 400. Shorten the question and call once more.
