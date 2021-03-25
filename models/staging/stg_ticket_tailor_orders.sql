
with source as (

    select * from {{ source('ticket_tailor', 'orders') }}

),

renamed as (

    select
        created_at,
        currency,
        event_summary,
        id,
        line_items,
        object,
        refund_amount / 100 AS  refund_amount,
        status,
        subtotal / 100 AS subtotal,
        tax / 100 AS tax,
        total / 100 AS total,
        txn_id,
        _sdc_batched_at,
        _sdc_received_at,
        _sdc_sequence,
        _sdc_table_version

    from source

)

select * from renamed