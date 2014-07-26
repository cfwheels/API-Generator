ColdFusion on Wheels API Generator
==================================

The API Generator is designed to inspect the inline documentation in the current install of Wheels and save its contents to a database.
It can inspect previous version of wheels as well, provided they are downloaded as wheelsX.Y sub folder under the root.

Installation
------------

1.  Deploy this code into the root of a CFML website or use the embedded server by executing "mvn jetty:run" (Maven required).

2.  Rename the `wheels1.1` folder to just `wheels`. (If you want to generate for another version of Wheels instead, rename its given folder name in the same manner.)

3.  Setup a data source in the ColdFusion administrator called `cfwdocs`. This application has been tested on MySQL 5.

SKIPPED FOR ERROR 4.  Run the DBMigrate plugin by going to this URL. (Replace `localhost` with your server's name.):
SKIPPED FOR ERROR > http://localhost/wheels/wheels?view=plugins&name=dbmigrate
SKIPPED FOR ERROR 5.  In the "Migrate to version" selection, run _All non-migrated_. Review the log generated on screen to make sure that no errors occurred with the migration.
WORKAROUND FOR ERROR import from existing production MySQL database dump

Running the Generator
---------------------

1.  Run the main screen of the API Generator at this URL. (Replace `localhost` with your server's name.):
    > http://localhost:8080/index.cfm/main

2.  Verify that the desired version and data source are displaying at the top of the screen. For "Version," enter the version number that should be represented by the generated documentation (for example, `1.1`). Click the _Generate API Docs_ button.

3.  The generator may take 30-60 seconds to process. You may need to change your application's timeout temporarily to cater to this, but this should run fine on most non-stressed environments.

4.  A "Generated Functions" screen will appear indicating which functions' docs were generated, whether the data validated, and whether the data was saved successfully. This is useful in debugging the documentation written in the source.

5.  Due to the intensiveness of this process, you now have the option to have the API Generator generate a SQL script to run on your production server (MySQL only). To access the script for 1.1, for example, go to this URL. (Notice that the "dot" in `1.1` has been changed to a hyphen, as in `1-1`.). You can copy the SQL generated on the screen and run on the database directly:
    > http://localhost:8080/index.cfm/main/sql/1-1

Download the API Generator on GitHub
------------------------------------

The ColdFusion on Wheels API Generator is available on GitHub at the following URL:
> http://github.com/cfwheels/API-Generator

Licensing: Apache 2.0 License
-----------------------------

Copyright 2010 ColdFusion on Wheels. All rights reserved.

Licensed under the Apache License, Version 2.0