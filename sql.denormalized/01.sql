/*
 * Count the number of tweets that use #coronavirus
 */
SELECT count(DISTINCT data->>'id')
FROM tweets_jsonb
WHERE jsonb_path_exists(
        data->'entities'->'hashtags',
        '$[*] ? (@.text == "coronavirus")'
      )
   OR jsonb_path_exists(
        data->'extended_tweet'->'entities'->'hashtags',
        '$[*] ? (@.text == "coronavirus")'
      );
