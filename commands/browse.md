Open a URL in a headless browser, take screenshots, and report what you see.

Target: $ARGUMENTS

## Steps

1. **Check Playwright**: Run `npx playwright --version`. If missing, install: `npm install playwright && npx playwright install chromium`

2. **Create and run browser script**:

```javascript
const { chromium } = require('playwright');
(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();

  // Desktop viewport
  await page.setViewportSize({ width: 1280, height: 720 });
  await page.goto('TARGET_URL', { waitUntil: 'networkidle' });
  await page.screenshot({ path: '/tmp/browse-desktop.png', fullPage: true });

  // Mobile viewport
  await page.setViewportSize({ width: 375, height: 812 });
  await page.screenshot({ path: '/tmp/browse-mobile.png', fullPage: true });

  // Collect console errors
  const errors = [];
  page.on('console', msg => { if (msg.type() === 'error') errors.push(msg.text()); });

  // Get page title and meta
  const title = await page.title();
  const metaDesc = await page.$eval('meta[name="description"]', el => el.content).catch(() => 'none');

  console.log(JSON.stringify({ title, metaDesc, errors }, null, 2));
  await browser.close();
})();
```

3. **Show screenshots** to the user using the Read tool (image files)

4. **Report**:
   - Page title & meta description
   - Screenshots (desktop + mobile)
   - Console errors (if any)
   - Broken images or missing resources
   - Basic observations (layout, loading state, visible content)

## Rules
- Always wait for `networkidle` before screenshot
- Capture both desktop (1280px) and mobile (375px)
- Report console errors even if page looks fine
- If URL requires auth, inform the user and ask for credentials
- Clean up temp screenshot files after showing them
- If $ARGUMENTS is not a URL, check if it's a local dev server route and construct the full URL
