const compareImages = require("resemblejs/compareImages")
const config = require("./config.json");
const fs = require('fs');
const { resolveSoa } = require("dns");

const { regressionCases, options } = config;

resultInfoAllCases = [];

async function executeTest(){
    if(regressionCases.length === 0){
        return;
    }
    for(let rcase of regressionCases){
        let files = fs.readdirSync(rcase.before);

        if (!fs.existsSync(`./results/${rcase.feature}/${rcase.scenario}`)){
            fs.mkdirSync(`./results/${rcase.feature}/${rcase.scenario}`, { recursive: true });
        }
        let resultInfo = {
            feature: rcase.feature,
            scenario: rcase.scenario,
            data: [],
        };
        for(let file of files){
            let beforeImage = `${rcase.before}/${file}`;
            let afterImage = `${rcase.after}/${file}`;
            let compareImage = `./results/${rcase.feature}/${rcase.scenario}/compare-${file}`;
            const data = await compareImages(
                fs.readFileSync(beforeImage),
                fs.readFileSync(afterImage),
                options
            );
            resultInfo.data.push({
                file,
                beforeImage,
                afterImage,
                compareImage,
                process: {
                isSameDimensions: data.isSameDimensions,
                dimensionDifference: data.dimensionDifference,
                rawMisMatchPercentage: data.rawMisMatchPercentage,
                misMatchPercentage: data.misMatchPercentage,
                diffBounds: data.diffBounds,
                analysisTime: data.analysisTime
            }})
            fs.writeFileSync(compareImage, data.getBuffer());
        }
        resultInfoAllCases.push(resultInfo);
    }

    fs.writeFileSync(`./report.html`, createReport(resultInfoAllCases));

    console.log('------------------------------------------------------------------------------------')
    console.log("Execution finished. Check the report under the results folder")
    
}

(async () => await executeTest())();

function singleStep(info){
    return `<div class=" browser">
    <div class=" btitle">
        <h3>Comparing: ${info.file}</h3>
        <p>Data: ${JSON.stringify(info.process)}</p>
    </div>
    <div class="imgline">
      <div class="imgcontainer">
        <span class="imgname">Reference</span>
        <img class="img2" src="${info.beforeImage}" alt="${info.beforeImage}" label="Reference">
      </div>
      <div class="imgcontainer">
        <span class="imgname">Test</span>
        <img class="img2" src="${info.afterImage}" alt="${info.afterImage}" label="Test">
      </div>
      <div class="imgcontainer">
        <span class="imgname">Diff</span>
        <img class="img2" src="${info.compareImage}" alt="${info.compareImage}" label="Diff">
      </div>
    </div>
  </div>`
}

function createReport(resultInfoAllCases){
    let result = `
    <html>
        <head>
            <title> VRT Report </title>
            <link href="index.css" type="text/css" rel="stylesheet">
        </head>
        <body>`
    for(let rcase of resultInfoAllCases){
        let temp = `<h1>Feature: ${rcase.feature}</h1>
        <h2>Scenario: ${rcase.scenario}</h2>`
        for(let step of rcase.data){
            temp += `<div id="visualizer">
            ${singleStep(step)}
            </div>`;
        }
        result += temp + '<hr/>';
    }

    return result + `</body>
    </html>`
}