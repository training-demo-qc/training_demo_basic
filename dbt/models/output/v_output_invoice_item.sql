{{
    config(
        tags=[
            "tag_dbt_trunsaction_invoice",
        ],
        materialized="view",
    )
}}


select concat(invoice_number,'/',coalesce(own_brand,''),'/',calendar_day) as header_id,*
from {{ ref("t_core_invoice_item") }}