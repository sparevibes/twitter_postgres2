CREATE INDEX tweets_jsonb_idx_htags ON tweets_jsonb USING gin(((data -> 'entities'::text) -> 'hashtags'::text));

CREATE INDEX tweets_jsonb_idx_exthtags ON tweets_jsonb USING gin((((data -> 'extended_tweet'::text) -> 'entities'::text) -> 'hashtags'::text));

CREATE INDEX tweets_jsonb_idx_fulltext ON tweets_jsonb USING gin(to_tsvector('english', COALESCE((data -> 'extended_tweet' ->> 'full_text'), (data ->> 'text'))));

