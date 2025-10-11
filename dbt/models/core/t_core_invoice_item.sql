{{
    config(
        tags=[
            
            "tag_dbt_trunsaction_invoice",
            'tag_test'
        ]
    )
}}

with
    invoice as (
        select
            nexus_material_id,
            nexus_invoice_id,
            invoice_number,
            invoice_item,
            calendar_day,
            trade_turnover,
            invoice_quantity,
            product_margin
        from {{ source("training_input", "t_output_bw_invoice") }}
        where material_id not in (select material_id from {{ ref('t_seed_material_exclution_list') }} )
    ),
    material as (
        select nexus_material_id, own_brand
        from {{ source("training_input", "t_output_material_master") }}

    ),
    final as (
        select
            invoice.nexus_material_id,
            nexus_invoice_id,
            invoice_number,
            invoice_item,
            own_brand,
            calendar_day,
            product_margin,
            trade_turnover,
            invoice_quantity
        from invoice
        left join material using (nexus_material_id)
    )
select *
from final