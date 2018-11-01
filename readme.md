# 5.3.-RIS3-budgeting
Provides a framework for using different budgeting methods (incremental, zero budgeting) to capture the funding dimension of the RIS3 action plan and the needs for funding across the defined implementation period.

## Prerequisites
- PHP version 5.2.4 or greater
- MySQL version 5.0.15 or greater or any version of MariaDB
- (Optional) (Required for Multisite) Apache mod_rewrite module (for clean URIs known as Permalinks)


## Installing
Step 1: Create the **root directory** for your project and save the project files to it.
 
Step 2: Create a **MySQL Database** and a MySQL **user** with all privileges for accessing and modifying it, and then run the **install.sql** which is located in db_installer directory to create the database schema.
 
Step 3 (Optional): Configure the **wp-config.php** with your database information.
	
Step 4: Go through the **installation process**
 - Access the URL of your project in a web browser and run the WordPress installation script.
 - Install the 'Insert PHP' plugin.
 - Activate the OnlineS3 theme for your project

## License
This project is licensed under the MIT License - see the [LICENSE.md](https://opensource.org/licenses/MIT) file for details
