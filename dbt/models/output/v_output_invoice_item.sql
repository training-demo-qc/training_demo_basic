
{{
    config (
        materialized = 'view',
        tags = ['output','invoice']
    )
}}

select concat(invoice_number,'/',own_brand,'/',calendar_day) as header_id, * from {{ ref('t_core_invoice_item') }}