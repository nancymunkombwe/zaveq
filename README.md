# ZAVÉQ — V2.0 Commerce & Delivery
*A NAVHÉRA Group Venture* · Your style. Your world.

A separate fashion marketplace prototype for Zambia. React + TypeScript + Vite, with optional Supabase Postgres and Auth. No connection to the Nancy portfolio.

## Run locally (Windows PowerShell)

Extract this ZIP into a new folder, open `zaveq-v2` in VS Code and use a terminal from that folder:

```powershell
cd frontend
npm install
npm run dev
```

Open the URL shown by Vite (normally http://localhost:5173). Node 22 recommended. If port 5173 is occupied, use the printed alternative. No account or `.env` file is necessary for demo mode. Stop with Ctrl+C. `npm run build` performs a TypeScript check and creates `dist`. Package dependencies must be downloaded from npm.

## What's implemented

- Responsive editorial storefront with locally bundled SVG illustrations, fictional vendors and prices in ZMW.
- Discover / Official Stores / Shop Local; search, category, city, price ceiling, sorting; store discovery.
- Product quick view, size selection, shopping bag, quantity editing, wishlist and simulated checkout/history.
- Budget-based outfit recommendation (simple cheapest-item algorithm, not AI; may return a partial look).
- Seller application form; guest demo storage or signed-in database submission.
- Optional Supabase customer signup/login/logout and live catalogue reading.
- SQL migration with RLS for public active products and user-owned applications; store membership table for later merchant roles.

Demo bag, wishlist, orders and guest seller applications use browser localStorage, are not account-synced and should only contain test data. Do not enter real personal data in demo mode or use it for genuine commerce. Demo checkout does not collect money, reserve/decrement stock, issue seller orders or ship anything. Illustrations and names are placeholders; no actual retail partnership is implied.

## Optional cloud configuration (after testing the demo)

Create a **new dedicated ZAVÉQ Supabase project**, separate from the portfolio. In its SQL Editor run `supabase/001_schema.sql` once, then `supabase/002_demo_seed.sql` once if sample data is desired. Use the project's API URL and browser-safe publishable/anon key only. Never use a service role or secret key in any VITE variable. In `frontend`, copy `.env.example` to `.env` and populate:

```dotenv
VITE_SUPABASE_URL=https://YOUR_PROJECT.supabase.co
VITE_SUPABASE_ANON_KEY=YOUR_PUBLIC_KEY
```

Restart Vite. Configure Auth email provider, confirmation and permitted redirect URLs for local and deployed frontend in the dedicated Supabase project. Email delivery restrictions may apply. No Render server is required for this release: Supabase provides the scoped API and authentication. A dedicated backend will be introduced for privileged business logic and commerce later.

Store and product writes are currently restricted to a privileged operator in Supabase. Seller applications are pending and cannot self-approve. An operator can review applications in Supabase Table Editor; the full seller/admin UI is the next release. Do not publish real retail names, logos or catalogues without rights/permission. Future seller portal will use membership-based authorization and moderation, not editable client roles.

## Deployment plan

Use a new dedicated ZAVÉQ repo and independent cloud resources, subject to each provider's policies. Never reuse portfolio credentials. Netlify base `frontend`, build `npm run build`, publish `dist`; set browser-safe VITE environment variables only if enabling Supabase. A free subdomain is enough for a demo. No domain purchase or paid services needed for local development. Verify current free-tier allowances before cloud deployment.

## Local QA checklist

1. Open Discover: 8 sample products. Switch Official Stores and Shop Local: 4 each.
2. Search for blazer; reset filters. Choose Lusaka / category / max price and verify results.
3. Quick shop; choose a size; add to bag and change quantity. Verify subtotal.
4. Save a product; view wishlist. Refresh; verify persistence.
5. Add products from two stores. Open checkout, enter a fictional city/area, choose a method per store and verify fees. Place a demo order and simulate shipment status in local mode. No money moves.
6. Adjust the Style Studio budget; verify suggested total stays at or below budget.
7. Submit a fictional seller application; verify local acknowledgement.
8. Test mobile width, keyboard focus and Escape to close overlays.
9. If cloud enabled: test sign-up, login, catalogue and seller submission; verify anon cannot submit applications, signed-in users cannot read other users' applications or change approval status, and inactive products/stores are not public.

## Next versions

Seller portal, platform admin, product editing/CSV imports, size-level stock, server-side order processing, retailer branch management, Concierge and visual search. Real payment integration, operational security and legal readiness are not included yet.

## Verification status

Source files and SVG assets generated. The build and browser acceptance tests must be run locally: npm registry was unreachable in the generation environment. Supabase migration has not been run against a live database.

## V2 delivery configuration

Open ZAVÉQ Control (demo) in the footer. Add a manual courier, edit its name, fee, service scope, estimate and enabled status. In local mode these settings persist only in the browser. Test by refreshing and opening checkout; disabled providers must not appear. Same-city delivery requires matching dispatch and destination cities; nationwide means any entered city in this demo, not actual carrier coverage. Fees are per store, not per item. Collection is free. Shipment tracking is simulated and each order retains its original provider and fee.

For cloud configuration, run `003_delivery.sql` after `001_schema.sql` in the dedicated ZAVÉQ Supabase project (never the portfolio). Create/confirm your own Auth user then grant admin access using the exact UUID as shown in the migration comment. Sign out and back in. Only approved admins may edit providers through database policies. Customers see enabled providers; settings refresh on initial load or auth change. Validate RLS with a separate nonadmin account before deployment. Do not open real commerce yet: orders remain browser-local, not private account-synced records, prices and fees are client-side estimates, and no payments, courier API integrations, driver GPS, actual bookings, server order processing or production dispatch exist. Use fictional test data only. A courier name is configuration, not a partnership.
