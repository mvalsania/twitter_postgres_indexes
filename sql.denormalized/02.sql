/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT
  '#' || elem->>'text' AS tag,
  COUNT(*) AS count
FROM (
  SELECT DISTINCT
    data->>'id'       AS id_tweet,
    elem
  FROM tweets_jsonb
  CROSS JOIN LATERAL jsonb_array_elements(
    coalesce(
      data->'extended_tweet'->'entities'->'hashtags',
      data->'entities'->'hashtags',
      '[]'::jsonb
    )
  ) AS elem
  WHERE
    (data->'entities'->'hashtags'        @@ '$[*].text == "coronavirus"')
    OR
    (data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"')
) sub
WHERE elem->>'text' LIKE '#%'
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

