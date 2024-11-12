const fs = require("fs");



// Reading JSON from a file
function parseJSON(){
    const data = fs.readFileSync("./data.json", "utf-8");
    const jsonData = JSON.parse(data);
    return jsonData;
}

let products = parseJSON();
console.log(products);

//writing to JSON File
function addProduct(data){
    products.push(data);
    const jsonData = JSON.stringify(products, null, 2);
    fs.writeFile("data.json", jsonData,(err)=>{
        if(err){
            console.error(err);
            return;
        }
        console.log("File has been written");
    })
}

addProduct({
    id: 4,
    name: "Desktop Computer",
    price: 2000,
    available: true,
    category: "Electronics"
})

function updateProduct(productID, newPrice){
    const product = products.find((product)=> product.id === productID);
    if(product){
        product.price = newPrice;
        console.log('Price updated for product ID ${productID}', product);
    }else{
        console.error("Product not found");
    }
    const jsonData = JSON.stringify(products, null, 2);
    fs.writeFile("data.json", jsonData, (err)=>{
        if(err){
            console.error(err);
            return;
        }
        console.log("File has been written");
    })
}

updateProduct(2, 400);

function filterByAvailability(){
    const availableProducts = products.filter((product)=> product.available);
    return availableProducts;
}

console.log("Available Products:",  filterByAvailability());

function filterByCatergory(category){
    const categoryProducts = products.filter((product)=> product.category.toLowerCase() === category.toLowerCase());
    return categoryProducts;
}

console.log("Product by Category:", filterByCatergory("Electronics"));

