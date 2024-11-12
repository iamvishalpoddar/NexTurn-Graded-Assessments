-- Vishal Poddar
-- Graded Assessment: MongoDB Scripts with Relationships


--1.1	Create the Collections and Insert Data:
> use GA
output : switched to db GA


> db
--output : GA


db.createCollection("customers");
--{ ok: 1 }



db.createCollection("orders");
--output :{ ok: 1 }


-- Insert customers into 'customers' collection
db.customers.insertMany([
    { "_id": ObjectId("1"), "name": "John Doe", "email": "johndoe@example.com", "address": { "street": "123 Main St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-1234", "registration_date": ISODate("2023-01-01T12:00:00Z") },
    { "_id": ObjectId("2"), "name": "Jane Smith", "email": "janesmith@example.com", "address": { "street": "456 Elm St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-5678", "registration_date": ISODate("2023-02-10T12:00:00Z") },
    { "_id": ObjectId("3"), "name": "Alice Johnson", "email": "alicej@example.com", "address": { "street": "789 Maple Ave", "city": "Springfield", "zipcode": "12345" }, "phone": "555-8765", "registration_date": ISODate("2023-03-15T12:00:00Z") },
    { "_id": ObjectId("4"), "name": "Bob Brown", "email": "bobb@example.com", "address": { "street": "101 Oak St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-9876", "registration_date": ISODate("2023-04-20T12:00:00Z") },
    { "_id": ObjectId("5"), "name": "Charlie Black", "email": "charlieb@example.com", "address": { "street": "102 Pine St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-4321", "registration_date": ISODate("2023-05-01T12:00:00Z") }
]);
--output :
-- {
--   acknowledged: true,
--   insertedIds: {
--     '0': ObjectId('64b95f812b61630000000001'),
--     '1': ObjectId('64b95f812b61630000000002'),
--     '2': ObjectId('64b95f812b61630000000003'),
--     '3': ObjectId('64b95f812b61630000000004'),
--     '4': ObjectId('64b95f812b61630000000005')
--   }
-- }

-- Insert orders into 'orders' collection
db.orders.insertMany([
    { "_id": ObjectId("101"), "order_id": "ORD123456", "customer_id": ObjectId("1"), "order_date": ISODate("2023-05-15T14:00:00Z"), "status": "shipped", "items": [ { "product_name": "Laptop", "quantity": 1, "price": 1500 }, { "product_name": "Mouse", "quantity": 2, "price": 25 } ], "total_value": 1550 },
    { "_id": ObjectId("102"), "order_id": "ORD123457", "customer_id": ObjectId("2"), "order_date": ISODate("2023-06-10T15:00:00Z"), "status": "pending", "items": [ { "product_name": "Phone", "quantity": 1, "price": 800 } ], "total_value": 800 },
    { "_id": ObjectId("103"), "order_id": "ORD123458", "customer_id": ObjectId("3"), "order_date": ISODate("2023-06-20T16:00:00Z"), "status": "shipped", "items": [ { "product_name": "Tablet", "quantity": 1, "price": 600 } ], "total_value": 600 },
    { "_id": ObjectId("104"), "order_id": "ORD123459", "customer_id": ObjectId("1"), "order_date": ISODate("2023-07-01T12:00:00Z"), "status": "delivered", "items": [ { "product_name": "Keyboard", "quantity": 1, "price": 50 } ], "total_value": 50 },
    { "_id": ObjectId("105"), "order_id": "ORD123460", "customer_id": ObjectId("5"), "order_date": ISODate("2023-07-02T13:00:00Z"), "status": "shipped", "items": [ { "product_name": "Monitor", "quantity": 1, "price": 300 } ], "total_value": 300 }
]);
-- --output :
-- {
--   acknowledged: true,
--   insertedIds: {
--     '0': ObjectId('64b95f812b61630000000006'),
--     '1': ObjectId('64b95f812b61630000000007'),
--     '2': ObjectId('64b95f812b61630000000008'),
--     '3': ObjectId('64b95f812b61630000000009'),
--     '4': ObjectId('64b95f812b6163000000000a')
--   }
-- }


-- 1.2. Find Orders for a Specific Customer

const customer = db.customers.findOne({ "name": "John Doe" });
db.orders.find({ "customer_id": customer._id });

-- --output :
-- [
--   {
--     _id: ObjectId('64b95f812b61630000000006'),
--     order_id: 'ORD123456',
--     customer_id: ObjectId('64b95f812b61630000000001'),
--     order_date: ISODate('2023-05-15T14:00:00.000Z'),
--     status: 'shipped',
--     items: [
--       { product_name: 'Laptop', quantity: 1, price: 1500 },
--       { product_name: 'Mouse', quantity: 2, price: 25 }
--     ],
--     total_value: 1550
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000009'),
--     order_id: 'ORD123459',
--     customer_id: ObjectId('64b95f812b61630000000001'),
--     order_date: ISODate('2023-07-01T12:00:00.000Z'),
--     status: 'delivered',
--     items: [ { product_name: 'Keyboard', quantity: 1, price: 50 } ],
--     total_value: 50
--   }
-- ]


-- 1.3. Find the Customer for a Specific Order

const order = db.orders.findOne({ "order_id": "ORD123456" });
db.customers.findOne({ "_id": order.customer_id });

--output :
-- {
--   _id: ObjectId('64b95f812b61630000000001'),
--   name: 'John Doe',
--   email: 'johndoe@example.com',
--   address: { street: '123 Main St', city: 'Springfield', zipcode: '12345' },
--   phone: '555-1234',
--   registration_date: ISODate('2023-01-01T12:00:00.000Z')
-- }


-- 1.4. Update Order Status

db.orders.updateOne(
    { "order_id": "ORD123456" },
    { $set: { "status": "delivered" } }
);

--output :
-- {
--   acknowledged: true,
--   insertedId: null,
--   matchedCount: 1,
--   modifiedCount: 1,
--   upsertedCount: 0
-- }


-- 1.5. Delete an Order

db.orders.deleteOne({ "order_id": "ORD123456" });

--output :
-- { acknowledged: true, deletedCount: 1 }


-- 2.1. Calculate Total Value of All Orders by Customer

db.orders.aggregate([
    { $group: { _id: "$customer_id", totalOrderValue: { $sum: "$total_value" } } },
    { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
    { $unwind: "$customer" },
    { $project: { "customer.name": 1, "totalOrderValue": 1 } }
]);

--output :
-- [
--   {
--     _id: ObjectId('64b95f812b61630000000003'),
--     totalOrderValue: 600,
--     customer: { name: 'Alice Johnson' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000005'),
--     totalOrderValue: 300,
--     customer: { name: 'Charlie Black' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000001'),
--     totalOrderValue: 50,
--     customer: { name: 'John Doe' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000002'),
--     totalOrderValue: 800,
--     customer: { name: 'Jane Smith' }
--   }
-- ]


-- 2.2. Group Orders by Status

db.orders.aggregate([
    { $group: { _id: "$status", count: { $sum: 1 } } }
]);

--output :
-- [
--   { _id: 'pending', count: 1 },
--   { _id: 'shipped', count: 2 },
--   { _id: 'delivered', count: 1 }
-- ]


-- 2.3. List Customers with Their Recent Orders

db.orders.aggregate([
    { $sort: { "order_date": -1 } },
    { $group: { _id: "$customer_id", mostRecentOrder: { $first: "$$ROOT" } } },
    { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
    { $unwind: "$customer" },
    { $project: { "customer.name": 1, "customer.email": 1, "mostRecentOrder.order_id": 1, "mostRecentOrder.total_value": 1 } }
]);

--output :
-- [
--   {
--     _id: ObjectId('64b95f812b61630000000003'),
--     mostRecentOrder: { order_id: 'ORD123458', total_value: 600 },
--     customer: { name: 'Alice Johnson', email: 'alicej@example.com' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000002'),
--     mostRecentOrder: { order_id: 'ORD123457', total_value: 800 },
--     customer: { name: 'Jane Smith', email: 'janesmith@example.com' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000001'),
--     mostRecentOrder: { order_id: 'ORD123459', total_value: 50 },
--     customer: { name: 'John Doe', email: 'johndoe@example.com' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000005'),
--     mostRecentOrder: { order_id: 'ORD123460', total_value: 300 },
--     customer: { name: 'Charlie Black', email: 'charlieb@example.com' }
--   }
-- ]


-- 2.4. Find the Most Expensive Order by Customer

db.orders.aggregate([
    { $sort: { "total_value": -1 } },
    { $group: { _id: "$customer_id", mostExpensiveOrder: { $first: "$$ROOT" } } },
    { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
    { $unwind: "$customer" },
    { $project: { "customer.name": 1, "mostExpensiveOrder.order_id": 1, "mostExpensiveOrder.total_value": 1 } }
]);

--output :
-- [
--   {
--     _id: ObjectId('64b95f812b61630000000001'),
--     mostExpensiveOrder: { order_id: 'ORD123459', total_value: 50 },
--     customer: { name: 'John Doe' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000003'),
--     mostExpensiveOrder: { order_id: 'ORD123458', total_value: 600 },
--     customer: { name: 'Alice Johnson' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000005'),
--     mostExpensiveOrder: { order_id: 'ORD123460', total_value: 300 },
--     customer: { name: 'Charlie Black' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000002'),
--     mostExpensiveOrder: { order_id: 'ORD123457', total_value: 800 },
--     customer: { name: 'Jane Smith' }
--   }
-- ]


-- 3.1. Find All Customers Who Placed Orders in the Last Month

const lastMonth = new Date();
lastMonth.setDate(lastMonth.getDate() - 30);

db.orders.aggregate([
    { $match: { "order_date": { $gte: lastMonth } } },
    { $sort: { "order_date": -1 } },
    { $group: { _id: "$customer_id", mostRecentOrder: { $first: "$$ROOT" } } },
    { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
    { $unwind: "$customer" },
    { $project: { "customer.name": 1, "customer.email": 1, "mostRecentOrder.order_date": 1 } }
]);




3.2. Find All Products Ordered by a Specific Customer

const customer = db.customers.findOne({ "name": "John Doe" });

db.orders.aggregate([
    { $match: { "customer_id": customer._




-- 3.3. Find the Top 3 Customers with the Most Expensive Total Orders

db.orders.aggregate([
    { $group: { _id: "$customer_id", totalSpent: { $sum: "$total_value" } } },
    { $sort: { totalSpent: -1 } },
    { $limit: 3 },
    { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
    { $unwind: "$customer" },
    { $project: { "customer.name": 1, "totalSpent": 1 } }
]);

--output :
-- [
--   {
--     _id: ObjectId('64b95f812b61630000000002'),
--     totalSpent: 800,
--     customer: { name: 'Jane Smith' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000003'),
--     totalSpent: 600,
--     customer: { name: 'Alice Johnson' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000005'),
--     totalSpent: 300,
--     customer: { name: 'Charlie Black' }
--   }
-- ]


3.4. Add a New Order for an Existing Customer

const customer = db.customers.findOne({ "name": "Jane Smith" });

db.orders.insertOne({
    "order_id": "ORD123461",
    "customer_id": customer._id,
    "order_date": new Date(),
    "status": "pending",
    "items": [
        { "product_name": "Smartphone", "quantity": 1, "price": 900 },
        { "product_name": "Headphones", "quantity": 1, "price": 150 }
    ],
    "total_value": 1050
});

--output :
-- {
--   acknowledged: true,
--   insertedId: ObjectId('6733ac55860cd8b5050d8190')
-- }


4.1. Find Customers Who Have Not Placed Orders

db.customers.aggregate([
    { $lookup: { from: "orders", localField: "_id", foreignField: "customer_id", as: "orders" } },
    { $match: { "orders": { $size: 0 } } },
    { $project: { "name": 1, "email": 1 } }
]);


--output :
-- [
--   {
--     _id: ObjectId('64b95f812b61630000000004'),
--     name: 'Bob Brown',
--     email: 'bobb@example.com'
--   }
-- ]


4.2. Calculate the Average Number of Items Ordered per Order

db.orders.aggregate([
    { $unwind: "$items" },
    { $group: { _id: "$order_id", totalItems: { $sum: "$items.quantity" } } },
    { $group: { _id: null, averageItems: { $avg: "$totalItems" } } }
]);


--output :
-- [ { _id: null, averageItems: 1.2 } ]


4.3 Join Customer and Order Data Using $lookup

db.orders.aggregate([
    { $lookup: { from: "customers", localField: "customer_id", foreignField: "_id", as: "customer" } },
    { $unwind: "$customer" },
    { $project: { "customer.name": 1, "customer.email": 1, "order_id": 1, "total_value": 1, "order_date": 1 } }
]);


--output :
-- [
--   {
--     _id: ObjectId('64b95f812b61630000000007'),
--     order_id: 'ORD123457',
--     order_date: ISODate('2023-06-10T15:00:00.000Z'),
--     total_value: 800,
--     customer: { name: 'Jane Smith', email: 'janesmith@example.com' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000008'),
--     order_id: 'ORD123458',
--     order_date: ISODate('2023-06-20T16:00:00.000Z'),
--     total_value: 600,
--     customer: { name: 'Alice Johnson', email: 'alicej@example.com' }
--   },
--   {
--     _id: ObjectId('64b95f812b61630000000009'),
--     order_id: 'ORD123459',
--     order_date: ISODate('2023-07-01T12:00:00.000Z'),
--     total_value: 50,
--     customer: { name: 'John Doe', email: 'johndoe@example.com' }
--   },
--   {
--     _id: ObjectId('64b95f812b6163000000000a'),
--     order_id: 'ORD123460',
--     order_date: ISODate('2023-07-02T13:00:00.000Z'),
--     total_value: 300,
--     customer: { name: 'Charlie Black', email: 'charlieb@example.com' }
--   },
--   {
--     _id: ObjectId('6733ac55860cd8b5050d8190'),
--     order_id: 'ORD123461',
--     order_date: ISODate('2024-11-12T19:28:21.336Z'),
--     total_value: 1050,
--     customer: { name: 'Jane Smith', email: 'janesmith@example.com' }
--   }
-- ]


