# Nozomu investment

##How To Build 
1. Import the nozomu.sql file in the mysql_db directory into mysql database.
`mysql -u <yourpreferedusername> -p <yourprefereduserdatabase> < nozomu.sql` 

2. Change the .env files with your mysql database info ( replace the {inserthere} with the corresponding value from your database). 

3. install all dependencies with 
`npm install`

4. start the server in port 3000 with 
`npm run dev`
