const express = require("express");
const app = express();
const https = require('https');
const csv = require('csvtojson');
const fs = require('fs');
 
const url = 'https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+pl_name,hostname,disc_year,pl_orbper,pl_radj,pl_dens,st_teff,st_rad,sy_kmag+from+pscomppars+where+pl_controv_flag=0&format=csv'
const port = process.env.port || 3000
//Entrypoint of the API
app.get("/", function(req, res){

    let data = '';

    console.log("Fetching the API...")
    //HTTP GET on NASA API
    https.get(url, (resp) => {

        // Creating the data
        console.log("Reading API data...")
        resp.on('data', (chunk) => {
            data += chunk;
        });

        // On finished, we create the json file to consume in the app
        resp.on('end', () => {
            console.log("CSV data generated.")      
            csv().fromString(data).then(function(data){
                console.log("Sending data to Flutter :)")
                //Sending the data to Flutter
                res.send(data);
            });
        });
    })
}).on("error", (err) => {
    console.log("Error: " + err.message);
});

app.listen(port, function(){
    console.log("Server running on port " + port)
})