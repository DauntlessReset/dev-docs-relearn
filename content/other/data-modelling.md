---
title: Data Modelling 
description: Basic concepts and definitions of Data Modelling 
---

In data modelling, you will mainly be dealing with two types of systems:

**1. Transactional Systems** (largely modelled using 3NF (3rd Normal Form))

Transactional systems are systems in which message flows are used to accomplish results. Examples of transactional systems would include a banking system, a recept system at a supermarket or a messaging application. 

These types of systems often used 3rd Normal Form (3NF) to arrange the data. 3NF is a database schema design which normalised data to help:
- ensure referential integrity
- reduce data duplication 
- simplify data management

In the example below we can see that the initial row is not normalised. We see that each row in the vendor table has both a primary key column and name column for bank, which does not have its own table. This will result in large amounts of redundant data as many vendors are likely to have the same bank, and each different bank will always have the same bank code. 

![3rd Normal Form example](/images/3nf.jpeg)

**2. Analytics Systems** (Dimensional Models) 

Analytic databases are purpose-built to analyze huge amounts of data rapidly, can can often perform 100 to 1000 times faster than transactional databases when completing these tasks. 

Part of the reason these models are so fast is because unlike 3NF, they duplicate data intentionally to speed up retrieval, rather than completing joins to retrieve data from adjoining databases.

A fact table is the central table in a star schema of a data warehouse. The fact table holds the data to be analysed ("facts"), while the dimension tables around it store details about the facts e.g. dimensional tables store descriptive information about the numerical values in a fact table. 

Example: If a fact table store rows relating to sales of a particular product, each row representing a transaction and including figures such as quantity, total value and so on, related dimension tables might store information about the product and the customer. 

A fact table usually has a huge number of rows but few columns. All information relevant to the analytics should be pulled into this table to rapid lookup. 

Data in fact tables is often **denormalised**. Denormalisation is the process of adding precomputed redundant data to an otherwise normalised relational database to improve read performance of the database.  

![Fact Table example](/images/fact-table.jpeg)


### Important concepts

##### Entity-Relationship Model

An entity-relationship model describes the entity types and the relationships that can exist between entities. 

For example: using a supermarket transaction system, we may have entities for Customer, Sale and Store. A customer may be associated with many sales, but a sale can only be associated with one customer and store. 

##### Cardinality

Cardinality describes the numerical relationship between entities. Entities may have a one-to-one, one-to-many or many-to-many relationship. 

##### Primary/Surrogate/Foreign Key

A *primary key* is a column whose value uniquely identifies a row in the table. 

A *foreign key* is a column whose value corresponds to the values of the primary key of another table. 

A *surrogate key* is a key which joins the dimension tables to the fact table. An artificially produced key is known as a surrogate key. 

##### Nullability 

The ability of a value to be null. For example, a table for Employee may allow the religion field to be empty, but not the first name field. This helps ensure data integrity. 

##### ETL

Extract - Transform - Load. An ETL system should extract data from source systems, enforce data type and validity and ensure it confirms structurally to the required output format. 

##### Notation

While different notations may be used, here is a popular example:

![Entity-Relationship Model Notation example](/images/erm-notation.png)

##### DDS

Dimensional Data Store (Star Schemas - fact tables)

##### ODS

Operational Data Store (3NF models from remote systems)