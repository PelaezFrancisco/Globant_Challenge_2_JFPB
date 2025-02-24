with
    source as (
        select
            r.age,
            replace(replace(r.job, '.', ''), ',', '') as job,
            r.marital,
            replace(r.education, '.', ' ') as education,
            r.default,
            r.housing,
            r.loan,
            r.contact,
            r.month,
            r.day_of_week,
            r.duration,
            r.campaign,
            r.pdays,
            r.previous,
            r.poutcome,
            r.emp_var_rate,
            r.cons_price_idx,
            r.cons_conf_idx,
            r.euribor3m,
            r.nr_employed,
            r.y,
            r._partitiontime as partitiontime
        from `dbt-globant.dbt_fpelaez_globant.raw_bank_marketing` as r
        where timestamp_trunc(_partitiontime, day) = timestamp("2025-02-23")
    )
select *
from source
