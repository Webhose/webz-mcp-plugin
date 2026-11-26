# Webz.io plugin

Connects ChatGPT, Codex, Cursor and other MCP clients to Webz.io through one MCP server, `https://mcp.webz.io/mcp`:

- **Dark Web**: check whether accounts, session cookies and API keys or tokens of a domain your Webz.io account is
  authorized to monitor appear in data breaches or infostealer logs; look up known breaches by name; get direct answers
  to threat intelligence questions, with citations from dark web content.
- **Open Web**: search Webz.io's news, blog and forum archives with filters for site, language, country and date; count
  coverage by site, author, person or company; get written answers from the news.

## Setup

1. Install the plugin, or add `https://mcp.webz.io/mcp` as a custom MCP server (OAuth):
   - Grok Build: `grok plugin install Webhose/webz-mcp-plugin --trust`, then `grok plugin enable webz-io`
   - Gemini CLI: `gemini extensions install https://github.com/Webhose/webz-mcp-plugin`
   - Kiro: **Powers → Add Custom Power → Import power from GitHub** with this repository's URL
   - Claude Code: `claude plugin install webz-io --marketplace Webhose/webz-mcp-plugin`
2. Sign in with your Webz.io API token when asked. No token? Get one at [webz.io](https://webz.io).

Breach searches cover the last 365 days, only for domains your account is authorized for.

All tools are read-only. More: [mcp.webz.io](https://mcp.webz.io).

## Agent skills

The plugin includes skills for the Open Web tools. A skill tells the agent when to call a tool, how to fill its
arguments and how to cite the results. Cursor and Claude Code load them with the plugin.

`skills/` is a copy of the [Webhose/skills](https://github.com/Webhose/skills) release named in `SKILLS_VERSION`. To
change a skill, change it in that repository. `scripts/sync-skills.sh vX.Y.Z` pins a new release here.

## Privacy and support

[Privacy policy](https://webz.io/privacy/) · [Terms of service](https://webz.io/tos/) · support@webz.io
