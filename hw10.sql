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
  select "eisenhower"       , "fillmore";

create table dogs as
  select "abraham" as name, "long" as fur, 26 as height union
  select "barack"         , "short"      , 52           union
  select "clinton"        , "long"       , 47           union
  select "delano"         , "long"       , 46           union
  select "eisenhower"     , "short"      , 35           union
  select "fillmore"       , "curly"      , 32           union
  select "grover"         , "short"      , 28           union
  select "herbert"        , "curly"      , 31;

create table sizes as
  select "toy" as size, 24 as min, 28 as max union
  select "mini",        28,        35        union
  select "medium",      35,        45        union
  select "standard",    45,        60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The names of all "toy" and "mini" dogs
create table dogsizes as 
  select name, size from dogs as a, sizes as b where a.height >= b.min and a.height <= b.max;
select name from dogsizes where size = "toy" or size = "mini";

-- Expected output:
--   abraham
--   eisenhower
--   fillmore
--   grover
--   herbert

-- All dogs with parents ordered by decreasing height of their parent
select child from parents as c, dogs as d where c.parent = d.name order by -d.height;

-- Expected output:
--   herbert
--   fillmore
--   abraham
--   delano
--   grover
--   barack
--   clinton

-- Sentences about siblings that are the same size
with 
  siblings(first, second) as (
    select a.child, b.child from parents as a, parents as b 
      where a.parent = b.parent and a.child <> b.child
    ) 
select c.name || " and " || d.name || " are " || c.size || " siblings" from dogsizes as c, dogsizes as d, siblings where c.size = d.size and first = c.name and second = d.name and first < second;

-- Expected output:
--   barack and clinton are standard siblings
--   abraham and grover are toy siblings

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
with 
  dogstack(lastdog, prevdogs, n, totalheight, lastheight) as (
    select name, name, 1, height, height from dogs union
    select name, prevdogs || ", " || name, n+1, totalheight + height, height
      from dogstack, dogs
      where height > lastheight and n < 4 
    )
select prevdogs, totalheight from dogstack where totalheight >= 170 order by totalheight;
-- Expected output:
--   abraham, delano, clinton, barack|171
--   grover, delano, clinton, barack|173
--   herbert, delano, clinton, barack|176
--   fillmore, delano, clinton, barack|177
--   eisenhower, delano, clinton, barack|180


