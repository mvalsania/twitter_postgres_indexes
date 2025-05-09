-- Here I took a different approach since the tests took >40 minutes to run the first time so I wanted to avoid waiting again and I opted for being overly cautious and adding as many indexes as possible. 
-- GIN index on all hashtags arrays (using jsonb_path_ops)
CREATE INDEX ON tweets_jsonb
USING GIN (
  (
    coalesce(
      data->'entities'->'hashtags',
      data->'extended_tweet'->'entities'->'hashtags',
      '[]'
    )
  ) jsonb_path_ops
);

-- B-tree index on language
CREATE INDEX ON tweets_jsonb ((data->>'lang'));

-- B-tree index on tweet ID
CREATE INDEX ON tweets_jsonb ((data->>'id'));

-- GIN full-text index on the tweet text
CREATE INDEX ON tweets_jsonb
USING GIN (
  to_tsvector(
    'english',
    coalesce(
      data->'extended_tweet'->>'full_text',
      data->>'text'
    )
  )
);
