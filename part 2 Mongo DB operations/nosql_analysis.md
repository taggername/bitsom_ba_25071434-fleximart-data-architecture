Task 2.1: NoSQL Justification Report 

Section A: Limitations of RDBMS 

The current relational database (RDBMS) faces significant challenges when handling a modern, diverse e-commerce catalog. First, heterogeneous attributes create "sparse tables." Since laptops require columns for RAM and CPU, while shoes require Size and Color, an RDBMS forces every row to include all columns, resulting in many NULL values and wasted storage. 

Second, schema rigidity is a bottleneck. Adding a new product type (e.g., "Smart Home Devices") requires an ALTER TABLE command, which can lock the database and cause downtime in production environments. Finally, storing nested data like customer reviews in an RDBMS requires complex "Joins" across separate tables. As the volume of reviews grows, these joins become computationally expensive, slowing down page load times and complicating the data retrieval process for the application. 

 

Section B: NoSQL Benefits 

MongoDB addresses these limitations through a document-oriented model. Its flexible schema allows each document (product) to have its own unique set of fields. This means a "Laptop" document and a "Shoe" document can coexist in the same collection without empty columns or wasted space. 

To handle reviews, MongoDB uses embedded documents. By storing reviews directly within the product document, the system can retrieve a product and all its feedback in a single read operation, eliminating the need for expensive joins. Furthermore, MongoDB offers superior horizontal scalability through "sharding." Instead of needing a larger, more expensive single server (vertical scaling), MongoDB distributes data across multiple cheaper servers, allowing the system to handle massive increases in traffic and data volume seamlessly. 

 

Section C: Trade-offs 

While MongoDB offers flexibility, it has two primary disadvantages compared to MySQL: 