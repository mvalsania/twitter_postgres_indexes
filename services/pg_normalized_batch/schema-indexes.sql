-- Technically (and fortunately) more indexes are not needed if you take advantage of caches values hehe

-- 1) Speed up “WHERE tag = 'coronavirus'” (and the join to tweets)
CREATE INDEX ON tweet_tags(tag, id_tweets);

-- 2) Speed up the language filter
CREATE INDEX ON tweets(lang);

-- 3) Spped up the full-text searches
CREATE INDEX ON tweets USING GIN (to_tsvector('english', text));
