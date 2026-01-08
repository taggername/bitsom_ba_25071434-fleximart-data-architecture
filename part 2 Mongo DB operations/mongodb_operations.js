1.// Import the provided JSON file into collection 'products'

mongoimport --db myDatabase --collection catalog --file catalog.json --jsonArray

2. // Find all products in "Electronics" category with price less than 50000
// Return only: name, price, stock

{ category: "Electronics", price: { $lt: 50000 } }

3. // Find all products that have average rating >= 4.0
// Use aggregation to calculate average from reviews array

// Operation 3: Review Analysis
db.products.aggregate([
    {
        // 1. Calculate the average rating for each document
        $project: {
            name: 1,
            pid: 1,
            averageRating: { $avg: "$reviews.rating" }
        }
    },
    {
        // 2. Filter for products where the calculated average is 4.0 or higher
        $match: {
            averageRating: { $gte: 4.0 }
        }
    }
]);

4. // Add a new review to product "ELEC001"
// Review: {user: "U999", rating: 4, comment: "Good value", date: ISODate()}


// Operation 4: Update Operation
db.products.updateOne(
    // 1. Selection Criteria: Find the specific product
    { pid: "ELEC001" }, 

5. // Calculate average price by category
// Return: category, avg_price, product_count
// Sort by avg_price descending

db.getCollection('Products').aggregate(
  [
    {
      $group: {
        _id: '$category',
        avg_price: { $avg: '$price' },
        product_count: { $sum: 1 }
      }
    },
    {
      $project: {
        _id: 0,
        category: '$_id',
        avg_price: 1,
        product_count: 1
      }
    },
    { $sort: { avg_price: -1 } }
  ],
  { maxTimeMS: 60000, allowDiskUse: true }
);

