SET search_path TO public;

SELECT ROUND(AVG(c.age),0) AS Avg_age
FROM client AS c
JOIN campaign AS cm ON c.client_id = cm.client_id
WHERE cm.campaign_outcome = TRUE;


SELECT COUNT(c.client_id)
FROM client AS c
JOIN campaign AS cm ON c.client_id = cm.client_id
WHERE number_contacts > (
	SELECT AVG(number_contacts)
	FROM campaign);

SELECT COUNT(client_id)
FROM client;

SELECT ROUND(COUNT(DISTINCT c.client_id) * 100.0 / (SELECT COUNT(DISTINCT client_id) FROM client),2) AS pct_above_avg
FROM client AS c
JOIN campaign AS cm ON c.client_id = cm.client_id
WHERE number_contacts > (
	SELECT AVG(number_contacts)
	FROM campaign);


SELECT 
    client_id,
    SUM(contact_duration) AS total_contact_duration,
    RANK() OVER (ORDER BY SUM(contact_duration) DESC) AS rank_duration
FROM campaign
GROUP BY client_id
ORDER BY total_contact_duration DESC;


SELECT 
    c.client_id,
    COUNT(*) FILTER (WHERE cm.campaign_outcome = TRUE) AS successful_campaigns,
    AVG(COUNT(*) FILTER (WHERE cm.campaign_outcome = TRUE)) 
        OVER () AS avg_successful_campaigns,
    e.cons_price_idx,
    e.euribor_three_months
FROM client AS c
JOIN campaign AS cm 
    ON c.client_id = cm.client_id
JOIN economics AS e 
    ON c.client_id = e.client_id
GROUP BY c.client_id, e.cons_price_idx, e.euribor_three_months
ORDER BY successful_campaigns DESC;
