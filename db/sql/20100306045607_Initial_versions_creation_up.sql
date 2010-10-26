
DROP TABLE IF EXISTS `versions`;
CREATE TABLE `versions` (
 `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `version` VARCHAR(10) NOT NULL,
 `filename` VARCHAR(255) NOT NULL,
 `createdat` DATE NOT NULL
);
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '0.6 Lite',1,'cfwheels_0.6_lite.zip','2006-12-01' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( 0.7,2,'cfwheels.0.7.zip','2008-04-21' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( 0.8,3,'cfwheels.0.8.zip','2008-08-18' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '0.8.1',4,'cfwheels.0.8.1.zip','2008-08-21' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '0.8.2',5,'cfwheels.0.8.2.zip','2008-09-29' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '0.8.3',6,'cfwheels.0.8.3.zip','2008-10-28' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( 0.9,7,'cfwheels.0.9.zip','2009-03-04' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '0.9.1',8,'cfwheels.0.9.1.zip','2009-04-27' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '0.9.2',9,'cfwheels.0.9.2.zip','2009-05-18' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '0.9.3',10,'cfwheels.0.9.3.zip','2009-07-10' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '0.9.4',11,'cfwheels.0.9.4.zip','2009-09-15' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '1.0 RC1',12,'cfwheels.1.0-rc1-public.zip','2009-11-02' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( 1.0,13,'cfwheels.1.0-final.zip','2009-11-24' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '1.0.1',14,'cfwheels.1.0.1.zip','2010-02-16' );
INSERT INTO `versions` ( `version`,`id`,`filename`,`createdat` ) VALUES ( '1.0.2',15,'cfwheels.1.0.2.zip','2010-02-18' );
