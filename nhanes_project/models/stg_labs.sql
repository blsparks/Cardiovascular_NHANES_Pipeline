with labs_raw as (
    select * from {{ source('nhanes_raw', 'raw_labs') }}
)

select
    SEQN as patient_id,
    -- LBXTC is Total Cholesterol (mg/dL)
    LBXTC as total_cholesterol,
    -- LBXTR is Triglycerides (mg/dL)
    LBXTR as triglycerides,
    -- LBXHDL is HDL "Good" Cholesterol (mg/dL)
    LBDHD as hdl_cholesterol,
    -- LBXGLU is Fasting Glucose (mg/dL)
    LBXGLT as glucose_level,
    -- A simple check for high cholesterol (example logic)
    case 
        when LBXTC >= 240 then 'High'
        when LBXTC >= 200 then 'Borderline'
        when LBXTC < 200 then 'Normal'
        else 'Unknown'
    end as cholesterol_status
from labs_raw
where SEQN is not null