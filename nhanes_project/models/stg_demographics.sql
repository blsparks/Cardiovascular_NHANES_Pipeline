with raw_demographics as (
    select * from {{ source('nhanes_raw', 'raw_demographic') }}
)

select
    SEQN as patient_id,
    RIDAGEYR as age,
    case 
        when RIAGENDR = 1 then 'Male' 
        when RIAGENDR = 2 then 'Female' 
    end as gender,
    case 
        when RIDRETH3 = 1 then 'Mexican American'
        when RIDRETH3 = 2 then 'Other Hispanic'
        when RIDRETH3 = 3 then 'Non-Hispanic White'
        when RIDRETH3 = 4 then 'Non-Hispanic Black'
        else 'Other/Multiracial'
    end as ethnicity
from raw_demographics