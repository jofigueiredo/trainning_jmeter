## Documentation - API keywords for Jmeter

**Why create/update keyword documentation**
 - The tendency is to increase the number of keywords / files
 - Help (efficiency/ efficacy) on develop / maintenance of new tests scripts
 - It will turn the test scripts more understandable and readable
</br>
</br>

**When update keyword documentation**
 - Every time that exist an PR to update keywords directory on GitHub QA-Automation repository
</br>
</br>

**How update keyword documentation**
  - Upload to PUC all zip files on directory   "../qa-automation/api/src/test/resources/keywords/documentation/setup"
  - On PDI open "../keywords/documentation/setup/apiKeywords job CSV.kjb.zip"
  - Edit "Set Variables" step
    - inputKeywordsDirectory : as local path to keyword directory (ex: "../qa-automation/api/src/test/resources/keywords/")
    - outputFile : local and name where output csv file will be saved
  - Run the Job  
  - Open PUC and go to File\New\Datas Source and insert data and save it:
   - Source Type : csv file
   - Data source name : csvKeyword
   - File : the path of outputFile configured before
   - Delimiter : semicolon
  - Upload and open "../keywords/documentation/setup/apiKeywordsReport.prpti.zip" and run it
  - Save report as apiKeywords.pdf on "../keywords/documentation" GitHub repository directory
</br>
</br>

**Where keyword documentation should be save:**
  - setup files :   "../qa-automation/api/src/test/resources/keywords/documentation/setup"
  - report files :  "../qa-automation/api/src/test/resources/keywords/documentation"
</br>
</br>

**What data to include on keyword Documentation report**
 - Domain : Organize Structure  of keywords
 - Keyword : Name of keyword
 - Description : Info of Variables, conditions and behavior of keyword
 - Conditions : "at initial phase", to complete Description info
