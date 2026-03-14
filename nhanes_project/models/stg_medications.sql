with meds_raw as (
    select * from {{ source('nhanes_raw', 'raw_medications') }}
)

select
    SEQN as patient_id,
    -- RXDUSE: Taken prescription medicine in past 30 days
    case 
        when RXDUSE = 1 then 'Yes'
        when RXDUSE = 2 then 'No'
        else 'Unknown'
    end as taking_meds,
    -- Count of prescriptions (RXDDRUG)
    count(RXDDRUG) over (partition by SEQN) as prescription_count
from meds_raw
where SEQN is not null