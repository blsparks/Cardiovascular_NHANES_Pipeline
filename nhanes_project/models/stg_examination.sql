with exam_raw as (
    select * from {{ source('nhanes_raw', 'raw_examination') }}
)

select
    SEQN as patient_id,
    -- Body Mass Index (BMI)
    BMXBMI as bmi,
    -- Waist Circumference (cm)
    BMXWAIST as waist_circumference,
    -- Systolic Blood Pressure (Average of readings)
    (BPXSY1 + BPXSY2 + BPXSY3) / 3 as avg_systolic_bp,
    -- Diastolic Blood Pressure (Average of readings)
    (BPXDI1 + BPXDI2 + BPXDI3) / 3 as avg_diastolic_bp,
    -- Simple BMI Classification
    case 
        when BMXBMI < 18.5 then 'Underweight'
        when BMXBMI >= 18.5 and BMXBMI < 25 then 'Normal'
        when BMXBMI >= 25 and BMXBMI < 30 then 'Overweight'
        when BMXBMI >= 30 then 'Obese'
        else 'Unknown'
    end as bmi_category
from exam_raw
where SEQN is not null