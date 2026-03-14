with quest_raw as (
    select * from {{ source('nhanes_raw', 'raw_questionnaire') }}
)

select
    SEQN as patient_id,
    -- SMQ020: Smoked at least 100 cigarettes in life 
    case 
        when SMQ020 = 1 then 'Yes'
        when SMQ020 = 2 then 'No'
        else 'Unknown'
    end as smoker_status,
    -- PAQ605: How Active Someone is 
    case 
        when PAQ605 = 1 then 'Active'
        when PAQ605 = 2 then 'Sedentary'
        else 'Unknown'
    end as physical_activity
from quest_raw
where SEQN is not null