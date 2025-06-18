SELECT
  b.title,
  b.author,
  p.purchase_date
FROM Purchases AS p
JOIN Listings  AS l ON p.listing_id = l.listing_id
JOIN Books     AS b ON l.book_id    = b.book_id
WHERE p.buyer_id = 2
 AND p.purchase_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY p.purchase_date DESC;
