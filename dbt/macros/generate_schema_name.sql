{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema-%}

    {%- if custom_schema_name is none -%}
        {{ default_schema }}

    {%- else -%}

        {%- if (target.schema=='dev' or target.schema=='qa' or target.schema=='prod') -%}

            {{ custom_schema_name | trim }}

        {%- else -%}

            {{ default_schema }}_{{ custom_schema_name | trim }}

        {%- endif -%}

    {%- endif -%}

{%- endmacro %}
