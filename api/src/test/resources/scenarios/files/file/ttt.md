| user-agent | userRole | statusCode | responseBody             | #notes | #TC1                |
| ---------- | -------- | ---------- | ------------------------ | ------ | ------------------- |
| FireFox    | admin    | 200        | application/xml          |        | #TC1.1# GET Method  |
| FireFox    | admin    | 200        | application/octet-stream |        | #TC1.2# GET Method  |
| FireFox    | suzy     | 403        |                          |        | #TC1.3# GET Method  |
| FireFox    | unknown  | 403        |                          |        | #TC1.4# GET Method  |
| Chrome     | admin    | 200        | application/xml          |        | #TC1.5# GET Method  |
| Chrome     | admin    | 200        | application/octet-stream |        | #TC1.6# GET Method  |
| Chrome     | suzy     | 403        |                          |        | #TC1.7# GET Method  |
| Chrome     | unknown  | 403        |                          |        | #TC1.8# GET Method  |
| IE         | admin    | 200        | application/xml          |        | #TC1.9# GET Method  |
| IE         | admin    | 200        | application/octet-stream |        | #TC1.10# GET Method |
| IE         | suzy     | 403        |                          |        | #TC1.12# GET Method |
| IE         | unknown  | 403        |                          |        | #TC1.13# GET Method |
| Edge       | admin    | 200        | application/xml          |        | #TC1.14# GET Method |
|            | admin    | 200        | application/octet-stream |        | #TC1.15# GET Method |
|            | suzy     | 403        |                          |        | #TC1.16# GET Method |
|            | unknown  | 403        |                          |        | #TC1.17# GET Method |
