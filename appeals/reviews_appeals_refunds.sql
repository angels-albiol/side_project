SELECT LEFT(meta_edd.REVIEW_ACTOR, CHARINDEX('@', meta_edd.REVIEW_ACTOR) - 1)
        AS agent,
        appeals.CUSTOMER_DECISION as decision,
        COUNT(meta_edd.REVIEW_ID) AS_date num_reviews
FROM "REPORTS"."META_EDD_INVESTIGATIONS_OPS_REVIEW" AS meta_edd
LEFT JOIN "RPT_SERVICING_OPS_PLATFORM"."APPEAL_CASES" AS appeals
    ON appeals.USER_ID = meta_edd.USER_ID
WHERE meta_edd.REVIEW_TEAM = 'EDD'
    AND meta_edd.CASE_TYPE = 'APPEAL'
    AND REVIEW_START_TIME >= DATEADD('month', -2, DATE_TRUNC('month', CURRENT_DATE() ))
GROUP BY 1, 2;