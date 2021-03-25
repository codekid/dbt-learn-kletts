-- select
--     event_id
-- from raw.ticket_tailor.orders
-- where status = 'completed'
-- select * from raw.ticket_tailor.events
-- select * from raw.ticket_tailor.issued_tickets


SELECT
    event_id, 
    it.status,
    COUNT(it.id) AS ticket_count
FROM {{ ref('stg_ticket_tailor_events') }} AS ev
LEFT JOIN {{ ref('stg_ticket_tailor_issued_tickets') }} AS it
    ON ev.id = it.event_id
-- WHERE it.status = 'valid'
GROUP BY event_id, it.status