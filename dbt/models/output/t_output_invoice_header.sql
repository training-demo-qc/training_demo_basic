{{
    config(
        tags=[
            "tag_dbt_trunsaction_invoice",
        ]
    )
}}

with
    invoice_item as (
        select * from {{ ref("t_core_invoice_item") }}
        ),
    header as (
        select
            concat(invoice_number,'/',coalesce(own_brand,''),'/',calendar_day) as header_id,
            invoice_number,
            own_brand,
            calendar_day,
            sum(product_margin) as product_margin,
            sum(invoice_quantity) as invoice_quantity,
            sum(trade_turnover) as trade_turnover
        from invoice_item
        group by invoice_number, own_brand, calendar_day
    )

select *
from header
