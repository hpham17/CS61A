-- CS 61A Fall 2014
-- Name:
-- Login:

create table parents as
  select "abraham" as parent, "barack" as child union
  select "abraham"          , "clinton"         union
  select "delano"           , "herbert"         union
  select "fillmore"         , "abraham"         union
  select "fillmore"         , "delano"          union
  select "fillmore"         , "grover"          union
  select "eisenhower"       , "fillmore"        union
  select "delano"           , "jackson";

create table dogs as
  select "abraham" as name, "long" as fur, 26 as height union
  select "barack"         , "short"      , 52           union
  select "clinton"        , "long"       , 47           union
  select "delano"         , "long"       , 46           union
  select "eisenhower"     , "short"      , 35           union
  select "fillmore"       , "curly"      , 32           union
  select "grover"         , "short"      , 28           union
  select "herbert"        , "curly"      , 31           union
  select "jackson"        , "long"       , 43;

-- All triples of dogs with the same fur that have increasing heights

select "=== Question 1 ===";
select a.name, b.name, c.name from dogs as a, dogs as b, dogs as c where a.name <> b.name and b.name <> c.name and a.fur = b.fur and b.fur = c.fur and a.height < b.height and b.height < c.height;

-- Expected output:
--   abraham|delano|clinton
--   abraham|jackson|clinton
--   abraham|jackson|delano
--   grover|eisenhower|barack
--   jackson|delano|clinton

-- The sum of the heights of at least 3 dogs with the same fur, ordered by sum

select "=== Question 2 ===";
with 
  furadder(fur, prevfur, n, totalheight, prevheight) as (
    select fur, fur, 1, height, height from dogs union
    select a.fur, prevfur, n + 1, totalheight + a.height, a.height from dogs as a, furadder where a.fur = prevfur and a.height > prevheight
    )
select fur, totalheight from furadder where n > 2 order by totalheight;

-- Expected output:
--   long|115
--   short|115
--   long|116
--   long|119
--   long|136
--   long|162

-- The terms of g(n) where g(n) = g(n-1) + 2*g(n-2) + 3*g(n-3) and g(n) = n if n <= 3

select "=== Question 3 ===";
with 
  g_of_n(prevprev, prev, current, n) as (
    select 1, 2, 3, 3 union
    select prev, current, (prevprev * 3 + prev * 2 + current), n + 1 from g_of_n where n < 20
)
select current from g_of_n;


-- Expected output:
--   1
--   2
--   3
--   10
--   22
--   51
--   125
--   293
--   696
--   1657
--   ...
--   9426875
