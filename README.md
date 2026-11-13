# Taxi Registration

Gujarati-first responsive registration portal for the two registration categories:

- **Taxi Rent**: vehicle number plate, model number, full name, mobile number, start date, end date.
- **Taxi Driver Job**: full name, mobile number, start date, end date.

Both registration types are designed around the agreed **₹99 registration fee**.

## Current status

- Initial responsive Gujarati registration page is available in `index.html`.
- Category switching, required-field validation, 10-digit Indian mobile validation, and date-range validation are implemented.
- The form currently shows an informational message only. **It does not collect money or submit/store personal data yet.**
- Supabase table definitions are in `supabase/schema.sql`.

## Next integration steps

1. Create a Supabase project and run `supabase/schema.sql` in the SQL Editor.
2. Add the Supabase project URL and anon key to the site through a safe configuration method.
3. Implement server-side registration creation and payment-order creation with a payment provider.
4. Verify payment signatures/webhooks on the server before marking a registration as paid.
5. Export paid registrations to Excel and make them available to the Taxi Management admin website.

## Security notes

- Never put a Supabase service-role key or payment secret in browser code.
- Do not expose registration records publicly.
- Do not mark a payment as successful based only on a browser redirect; verify it server-side.
- The SQL schema enables Row Level Security and intentionally adds no public read policies.

## Preview

Open `index.html` locally, or enable GitHub Pages for this repository to publish a static preview. A static GitHub Pages preview will not activate payment or database storage by itself.
