SELECT meta_edd.REVIEW_ACTOR AS agent,
    CASE WHEN appeals.CUSTOMER_DECISION = 'APPEAL' OR appeals.CUSTOMER_DECISION IS NULL THEN 'APPEAL'
    ELSE 'REFUND' END AS decision,
    meta_edd.REVIEW_id as review_id,
    date(meta_edd.REVIEW_START_TIME) AS date_review
FROM "REPORTS"."META_EDD_INVESTIGATIONS_OPS_REVIEW" AS meta_edd
LEFT JOIN "RPT_SERVICING_OPS_PLATFORM"."APPEAL_CASES" AS appeals
    ON appeals.USER_ID = meta_edd.USER_ID
WHERE meta_edd.REVIEW_TEAM = 'EDD'
    AND meta_edd.CASE_TYPE = 'APPEAL'
    AND DATE(meta_edd.REVIEW_START_TIME) >= DATEADD('week', -8, DATE_TRUNC('day', CURRENT_DATE() ))
ORDER BY 1;