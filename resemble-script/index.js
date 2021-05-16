const compareImages = require("resemblejs/compareImages")
const config = require("./config.json");
const fs = require('fs');

const { before, after, result, options } = config;

resultInfoAllCases = [];

function getFiles(dir) {
  var arrFiles = [];
  let subDirs = fs.readdirSync(dir);
  
  subDirs.forEach(subDir => {
    let files = fs.readdirSync(dir+'/'+subDir);
      
    files.forEach(file => {
      arrFiles.push([subDir,file]);
    });
  });
  
  return arrFiles
}

async function executeTest(){
    let files_3_3_0 = getFiles(before)
    let files_3_42_5 = getFiles(after)
    let resultInfo = {}
    
    if (!fs.existsSync(result)){
      fs.mkdirSync(result, { recursive: true });
    }
    
    for (var i = 0; i < files_3_3_0.length; i++) {
      let resultInfo = {
        scenario: '',
	data: [],
      };
      for (var j = 0; j < files_3_3_0[i].length; j = j + 2) {
      let scenario = files_3_3_0[i][j];
      let file = files_3_3_0[i][j+1];
      let beforeImage = `${before}/${files_3_3_0[i][j]}/${files_3_3_0[i][j+1]}`;
      let afterImage = `${after}/${files_3_42_5[i][j]}/${files_3_42_5[i][j+1]}`;
      let compareImage = `${result}/compare-${files_3_3_0[i][j+1]}}`;
      const data = await compareImages(
        fs.readFileSync(beforeImage),
        fs.readFileSync(afterImage),
        options
      );
      
      resultInfo.scenario = scenario;
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
        }
      });
      
      fs.writeFileSync(compareImage, data.getBuffer());
      }
      resultInfoAllCases.push(resultInfo);
    }
            
    fs.writeFileSync(`${result}/report.html`, createReport(resultInfoAllCases));
    fs.copyFileSync('./index.css', `${result}/index.css`);

    console.log('------------------------------------------------------------------------------------')
    console.log("Execution finished. Check the report under the results folder")
  }
(async ()=>console.log(await executeTest()))();

function singleStep(info){
    return `<div class=" browser">
    <div class=" btitle">
        <h3>Comparing: ${info.file}</h3>
        <p>Data: ${JSON.stringify(info.process)}</p>
    </div>
    <div class="imgline">
      <div class="imgcontainer">
        <span class="imgname">Reference</span>
        <img class="img2" src="../${info.beforeImage}" alt="../${info.beforeImage}" label="Reference">
      </div>
      <div class="imgcontainer">
        <span class="imgname">Test</span>
        <img class="img2" src="../${info.afterImage}" alt="../${info.afterImage}" label="Test">
      </div>
      <div class="imgcontainer">
        <span class="imgname">Diff</span>
        <img class="img2" src="../${info.compareImage}" alt="../${info.compareImage}" label="Diff">
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
        <body>
        `
          for(let rcase of resultInfoAllCases){
            let temp = `<h2>Scenario: ${rcase.scenario}</h2>`
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