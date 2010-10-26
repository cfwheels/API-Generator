
ALTER TABLE `versions` ADD COLUMN `ismajorrelease` TINYINT(1) DEFAULT 0 NOT NULL;
UPDATE `versions` SET `ismajorrelease` = 1 WHERE id=13;
DROP TABLE IF EXISTS `functionsectionversions`;
CREATE TABLE `functionsectionversions` (
 `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `functionsectionid` INT NOT NULL,
 `versionid` INT NOT NULL
);
INSERT INTO `functionsectionversions` ( `functionsectionid`,`versionid` ) VALUES ( 1,13 );
INSERT INTO `functionsectionversions` ( `functionsectionid`,`versionid` ) VALUES ( 2,13 );
INSERT INTO `functionsectionversions` ( `functionsectionid`,`versionid` ) VALUES ( 3,13 );
INSERT INTO `functionsectionversions` ( `functionsectionid`,`versionid` ) VALUES ( 4,13 );
INSERT INTO `functionsectionversions` ( `functionsectionid`,`versionid` ) VALUES ( 5,13 );
INSERT INTO `functionsectionversions` ( `functionsectionid`,`versionid` ) VALUES ( 6,13 );
INSERT INTO `functionsectionversions` ( `functionsectionid`,`versionid` ) VALUES ( 7,13 );
INSERT INTO `functionsectionversions` ( `functionsectionid`,`versionid` ) VALUES ( 8,13 );
