# Vitacrop Technologies — website

Static one-page site (`index.html` + `assets/`). Hosted free on **GitHub Pages**.

## What was fixed to make it web-ready

The original `Vitacrop-5.html` could not be hosted as-is:

| Problem | Fix |
| --- | --- |
| Images linked with local paths like `/Users/vivekanandtiwari/Desktop/...` | Copied into `assets/` and re-linked with relative paths |
| `<meta charset="UTF-">` (invalid) | Now `<meta charset="UTF-8">` |
| Logo + favicon used unresolvable `wix:image://...` URLs | Now point to `assets/logo.png` |
| `MSME.png.png` typo | Now `assets/msme.png` |
| Filenames with spaces (`Birac logo.png`, `StartUp India.png`, …) | Renamed to hyphenated lowercase in `assets/` |

External resources (Tailwind CDN, Font Awesome, Google Fonts, Unsplash/Pixabay images) are loaded over HTTPS and work on GitHub Pages unchanged.

## Publish it (free)

1. Make a free account at <https://github.com>.
2. Create a new **empty** repo named `vitacrop-website` at <https://github.com/new>
   (no README / .gitignore / license).
3. From this folder, run:

   ```bash
   ./deploy.sh https://github.com/YOUR-USERNAME/vitacrop-website.git
   ```

4. In the repo: **Settings → Pages → Source: "Deploy from a branch" → Branch: `main` / `/ (root)` → Save**.
5. Live in ~1 minute at:

   ```
   https://YOUR-USERNAME.github.io/vitacrop-website/
   ```

## Update it later

Edit `index.html` or files in `assets/`, then:

```bash
./deploy.sh
```

## Putting this page on your existing Wix site

Wix will not let you replace a whole page with your own HTML document, but you
can drop the whole page in as an **HTML embed** on a Wix page. Pick where the
images live:

- **Route A** — GitHub Pages hosts the images (run `./deploy.sh`).
- **Route B** — Wix hosts the images (no GitHub at all). Described below.

### Route B — everything on Wix (`vitacrop-wix-embed.html`)

Nothing on GitHub is used in this route; `index.html` / `deploy.sh` can be ignored.

**1. Upload the images to Wix**

In the Wix dashboard open **Media Manager** and upload all 12 files from
`vitacrop-website/assets/`:

```
logo.png              potato-protoplast.png   precision-editing.png
feature-image8.png    birac-logo.png          mutagenesis.png
opc.png               startup-india.png       startup-karnataka.png
msme.png              c-camp.png              uasb.png
```

(Compress the big ones first — see the last section.)

**2. Get each image's public URL**

For each file, hover it in Media Manager → **⋯** menu → **Copy URL**
(some Wix plans label it "Get link"). The URL looks like
`https://static.wixstatic.com/media/xxxxxxxx~mv2.png`.

If your Media Manager has no "Copy URL": drop the image onto any page, click
**Publish**, open the published page, right-click the image →
**Copy Image Address**, then remove it from the page again (the file and its URL
stay).

**3. Fill in the URL list in the file**

Open `vitacrop-wix-embed.html`, scroll to the `IMAGES { ... }` block near the
bottom, and paste each URL between the quotes:

```js
var IMAGES = {
    "assets/logo.png":              "https://static.wixstatic.com/media/abc123~mv2.png",
    "assets/potato-protoplast.png": "https://static.wixstatic.com/media/def456~mv2.png",
    ...
};
```

**4. Paste into Wix**

Wix Editor → **Add → Embed Code → Embed HTML → "Code"** → paste the **entire
file** → **Update**. Then size the element **full width** and drag it **tall**
(~3200 px). **Publish.** The page is now live at that Wix page's address, e.g.
`https://www.vita-crop.com/<page-name>` (set it as your homepage if you want it
at the root).

To edit later: change `vitacrop-wix-embed.html`, paste it into the same embed
element again, republish.

### Route A — GitHub Pages hosts the images

1. Run `./deploy.sh` (steps above), confirm
   `https://YOUR-USERNAME.github.io/vitacrop-website/` loads.
2. Simplest: Wix Editor → **Add → Embed Code → Embed a Site (iFrame)**, paste
   that URL, full width, ~3200 px tall, publish. Edits go live via `./deploy.sh`
   with no Wix change.

### Which page should the domain point at?

If you want `vita-crop.com` itself to be this site (not just an embed on one Wix
page), don't use Wix at all for it — repoint the domain's DNS to GitHub Pages:
A records for the apex to `185.199.108.153`–`185.199.111.153`, `www` as a CNAME
to `YOUR-USERNAME.github.io`, then set the custom domain in the repo's
**Settings → Pages**. That takes the domain off the Wix site.

### Wix embed caveats

- The embed element has a **fixed height** — it does not grow to fit content.
  Pick a height that fits the whole page or accept an inner scrollbar.
- `position: fixed` (the top nav) pins to the top of the embed frame, not the
  Wix page — fine, but it only sticks while scrolling *inside* the frame.
- Wix scales embeds down on mobile; check the phone view after publishing.

## Optional: shrink the big images

`assets/mutagenesis.png` (4.5 MB), `assets/potato-protoplast.png` (3.6 MB) and
`assets/opc.png` (1.9 MB) make the page slow on mobile. Compressing them
(e.g. <https://squoosh.app>) to well under 500 KB each is worth doing but not required.
