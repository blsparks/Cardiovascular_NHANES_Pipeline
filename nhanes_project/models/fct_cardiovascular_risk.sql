with demographics as (
    select * from {{ ref('stg_demographics') }}
),

labs as (
    select * from {{ ref('stg_labs') }}
),

exams as (
    select * from {{ ref('stg_examination') }}
),

diet as (
    select * from {{ ref('stg_diet') }}
),

lifestyle as (
    select * from {{ ref('stg_questionnaire') }}
)

select
    d.patient_id,
    d.age,
    d.gender,
    d.ethnicity,
    l.total_cholesterol,
    l.hdl_cholesterol,
    l.cholesterol_status,
    e.bmi,
    e.bmi_category,
    e.avg_systolic_bp,
    e.avg_diastolic_bp,
    dt.daily_calories,
    dt.sodium_mg,
    ls.smoker_status,
    ls.physical_activity
from demographics d
left join labs l on d.patient_id = l.patient_id
left join exams e on d.patient_id = e.patient_id
left join diet dt on d.patient_id = dt.patient_id
left join lifestyle ls on d.patient_id = ls.patient_id