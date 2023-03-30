---
title: SQL Basics
description: An overview of basic SQL commands
---

## Querying single table

Fetch all columns from the ```country``` table:
```
SELECT *
FROM country;
```

Fetch specific columns from the ```city``` table:
```
SELECT id, name
FROM city;
```

Fetch city names sorted by the ```rating``` column in the default ascending order:
```
SELECT name
FROM city
ORDER BY rating [ASC];
```
Fetch city names sorted by the ```rating``` column in descending order:
```
SELECT name
FROM city
ORDER BY rating DESC;
```

## Aliases

Used to give a table or column a temporary name (usually to make it more readable).

```
SELECT column_name AS alias
FROM table_name;
```

### Columns

```
SELECT name AS city_name
FROM city;
```

### Tables

```
SELECT co.name, ci.name
FROM city AS ci
JOIN country AS co
    ON ci.country_id = co.id;
```

## Distinct

Return unique values only.

```
SELECT DISTINCT name FROM city;
```