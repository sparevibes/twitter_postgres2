/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT '#' || htags AS tag, COUNT(DISTINCT id)
FROM (SELECT jsonb_array_elements(
        COALESCE(
            (data -> 'extended_tweet'::text -> 'entities'::text -> 'hashtags'),
            (data -> 'entities'::text -> 'hashtags'))) ->> 'text' AS htags,
    data -> 'id' AS id
    FROM tweets_jsonb
    WHERE (data -> 'extended_tweet'::text -> 'entities'::text -> 'hashtags'::text) @> '[{"text": "coronavirus"}]' OR
    (data -> 'entities'::text -> 'hashtags'::text) @> '[{"text": "coronavirus"}]') AS a
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
