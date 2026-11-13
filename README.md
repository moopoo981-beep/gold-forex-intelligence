# Gold & Forex Intelligence Dashboard — V2.0

A minimal Thai-language dashboard for XAU/USD and USD macro context.

## V2 features

- Automatically collects macro and geopolitical headlines from Federal Reserve, BLS, BEA, BBC World and CNBC RSS feeds.
- Pulls a 5-day XAU/USD chart and DXY quote from Yahoo Finance chart endpoints (unofficial; may be delayed or changed without notice).
- Optional Twelve Data quote for XAU/USD when `TWELVEDATA_API_KEY` is configured. Twelve Data documents `/quote` and `/time_series` market-data endpoints.
- Pulls US 10-year Treasury yield (`DGS10`) and 10-year real yield (`DFII10`) from FRED daily observations. If `FRED_API_KEY` is set, the app uses the documented FRED API; otherwise it uses the FRED graph CSV download fallback. These are daily observations, not intraday quotes.
- Pulls the current weekly USD economic calendar from the Forex Factory public weekly JSON feed. The calendar is a third-party feed; verify high-impact times with the issuing agency.
- Calculates a transparent rule-based context score using gold change, SMA20/50, RSI14, DXY change and US10Y daily change.
- AI analysis covers MARKET OVERVIEW, GOLD TREND, USD IMPACT, GEOPOLITICS, GOLD SENTIMENT, TECHNICAL CONTEXT and ACTION PLAN.
- Saves AI analysis snapshots to `data/history.json` (last 180 records).
- Responsive minimal dashboard for desktop and mobile.
- Refresh intervals: market data cache 120 seconds (dashboard polls every 60 seconds), news 15 minutes, calendar 60 minutes.
- AI auto-analysis defaults to one call on first load and then at most once per configured interval when the news fingerprint changes.

## Requirements

- Node.js 20+
- Gemini API key for AI analysis (Google AI Studio Free Tier, subject to quota)
- Optional Twelve Data API key for XAU/USD quote enhancement

## Run locally

1. Extract the ZIP.
2. Open a terminal in the project folder.
3. Install packages:

   ```bash
   npm install
   ```

4. Copy `.env.example` to `.env`.
5. Add your Gemini API key:

   ```env
   GEMINI_API_KEY=your_gemini_api_key
   GEMINI_MODEL=gemini-3.8-flash
   ```

6. Optional: add Twelve Data key:

   ```env
   TWELVEDATA_API_KEY=your_twelve_data_api_key
   ```

7. Start:

   ```bash
   npm start
   ```

8. Open http://localhost:3000

## Environment variables

- `GEMINI_API_KEY` — required for AI analysis. Create a key in Google AI Studio; keep it server-side only.
- `GEMINI_MODEL` — defaults to `gemini-3.8-flash` (confirm current Free Tier model availability in AI Studio).
- `TWELVEDATA_API_KEY` — optional; used for XAU/USD quote. Yahoo Finance chart data remains the fallback.
- `FRED_API_KEY` — optional; uses the documented FRED API instead of its graph CSV download fallback.
- `DASHBOARD_PASSWORD` — optional locally; required when `NODE_ENV=production`. Protects the whole site and API with HTTP Basic Auth.
- `ANALYZE_MAX_PER_HOUR` — defaults to 6 AI analyses per IP per hour to limit unexpected API spend.
- `AUTO_ANALYZE` — defaults to `true`.
- `AUTO_ANALYZE_MINUTES` — defaults to `60` and is clamped to at least 30 minutes.
- `PORT` — defaults to `3000`.

## Data integrity and limitations

- Yahoo Finance's chart endpoint is not a documented public API. Values can be delayed, rate-limited or unavailable. The UI labels the provider and identifies a futures proxy if spot XAU/USD is not available.
- FRED `DGS10` and `DFII10` are daily observations, not live intraday yields. The dashboard shows the observation date.
- Forex Factory's weekly JSON feed covers the current calendar week. It is a third-party feed, not an official government calendar. Confirm high-impact event times on the issuing agency's website.
- The rule-based bias is a transparent context score, not a predictive model or trade signal.
- AI summaries are generated from the information retrieved at that time. The AI must not invent missing prices, event times, levels or economic data.
- Gemini Free Tier has model-specific quotas and rate limits. Do not enable a paid Google Cloud billing tier if the requirement is zero cost. AI auto-analysis can be disabled using `AUTO_ANALYZE=false`.
- API keys must never be committed to source control or placed in frontend code.
- Before public deployment, set a strong `DASHBOARD_PASSWORD`; the server refuses to start in production without it. Keep the dashboard private even when the API key itself remains server-side.

## Deployment

Deploy as a Node.js web service (Node 20+) on a host such as Render, Railway or a VPS. Set environment variables in the hosting dashboard. Persist the `data/` directory with a persistent disk if analysis history must survive redeployments.


## Provider documentation

- Gemini generateContent API: https://ai.google.dev/api/generate-content
- Twelve Data market-data documentation: https://twelvedata.com/docs/market-data/quote
- FRED API documentation: https://fred.stlouisfed.org/docs/api/fred/
- FRED observations endpoint: https://fred.stlouisfed.org/docs/api/fred/series_observations.html
- Forex Factory weekly calendar feed: https://nfs.faireconomy.media/ff_calendar_thisweek.json


## Zero-cost AI configuration

The app's AI integration uses the Gemini Developer API. Google currently lists free input/output tokens for selected models, including a limited Free Tier. Free-tier prompts and responses may be used to improve Google's products, so only send public news and non-sensitive information. Check the current model-specific limits and terms before use.

- Google AI Studio API keys: https://aistudio.google.com/apikey
- Gemini API pricing and Free Tier: https://ai.google.dev/gemini-api/docs/pricing
- Gemini API rate limits: https://ai.google.dev/gemini-api/docs/rate-limits
