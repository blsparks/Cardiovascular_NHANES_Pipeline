with diet_raw as (
    select * from {{ source('nhanes_raw', 'raw_diet') }}
)

select
    SEQN as patient_id,
    -- DR1TKCAL is Total Calories
    DR1TKCAL as daily_calories,
    -- DR1TSFAT is Total Saturated Fatty Acids (g)
    DR1TSFAT as saturated_fat_g,
    -- DR1TSODI is Sodium (mg)
    DR1TSODI as sodium_mg,
    -- DR1TSUGR is Total Sugars (g)
    DR1TSUGR as sugar_g
from diet_raw
where SEQN is not null