SELECT
  b.title,
  b.author,
  COUNT(p.purchase_id) AS sold_count
FROM Purchases AS p
JOIN Listings   AS l ON p.listing_id = l.listing_id
JOIN Books      AS b ON l.book_id     = b.book_id
GROUP BY
  b.book_id,
  b.title,
  b.author
ORDER BY
  sold_count DESC
LIMIT 10;