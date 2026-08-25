--SELECT 
--   n
--FROM
--   (  SELECT
--         generate_series AS n
--      FROM
--         generate_series(0, 10)
--   ) AS num_list
SELECT
   *
FROM
(  SELECT 
      CONCAT('085030470',
             '000508000',
             '019700000',
             '508407000',
             '040010600',
             '007000000',
             '001300726',
             '900800040',
             '400206090') AS grid
) start_game
JOIN
   generate_series(1, 81) 
ON
   1 = 1
   
