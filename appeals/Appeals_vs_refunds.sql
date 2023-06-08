WITH appeals_duration AS
    (SELECT meta_edd.USER_ID,
            meta_edd.REVIEW_ID,
       timestampdiff(minute, meta_edd.REVIEW_START_TIME, meta_edd.REVIEW_END_TIME) AS duration
FROM "REPORTS"."META_EDD_INVESTIGATIONS_OPS_REVIEW" AS meta_edd
WHERE meta_edd.REVIEW_TEAM = 'EDD'
    AND meta_edd.CASE_TYPE = 'APPEAL'
    AND duration <= 600)
SELECT AVG(appeals_duration.duration) AS avg_duration,
       appeals.CUSTOMER_DECISION,
       COUNT(appeals_duration.REVIEW_ID) num_reviews
FROM appeals_duration
LEFT JOIN "RPT_SERVICING_OPS_PLATFORM"."APPEAL_CASES" AS appeals
    ON appeals_duration.USER_ID = appeals.USER_ID
GROUP BY 2;