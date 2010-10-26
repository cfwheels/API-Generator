
DROP TABLE IF EXISTS `functions`;
CREATE TABLE `functions` (
 `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(30) NOT NULL,
 `wheelsversion` VARCHAR(15) NOT NULL,
 `returntype` VARCHAR(15) NOT NULL,
 `hint` TEXT NOT NULL,
 `examples` TEXT NOT NULL,
 `parentfunctionsectionid` INT NOT NULL,
 `childfunctionsectionid` INT
);
DROP TABLE IF EXISTS `functionarguments`;
CREATE TABLE `functionarguments` (
 `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `functionid` INT NOT NULL,
 `name` VARCHAR(100) NOT NULL,
 `type` VARCHAR(20) DEFAULT 'any',
 `required` TINYINT(1) DEFAULT 0 NOT NULL,
 `defaultvalue` VARCHAR(255),
 `hint` TEXT NOT NULL
);
DROP TABLE IF EXISTS `functionsections`;
CREATE TABLE `functionsections` (
 `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(50) NOT NULL,
 `description` TEXT,
 `ordering` INT NOT NULL,
 `parentfunctionsectionid` INT,
 `slug` VARCHAR(30) NOT NULL
);
INSERT INTO `functionsections` ( `name`,`description`,`ordering`,`id`,`slug` ) VALUES ( 'Model Initialization Functions','These methods are called from the <code>init()</code> methods of your model files.',1,1,'model-initialization' );
INSERT INTO `functionsections` ( `name`,`description`,`ordering`,`id`,`slug` ) VALUES ( 'Model Class Functions','These methods operate on the class as a whole and not on individual objects and thus need to be prefaced with <code>model(&quot;name&quot;)</code>. You can call these methods from anywhere, but it is not recommended to call them from view pages. When calling them from their own model files, it is recommended to reference the scope explicitly with the <code>this</code> keyword.',2,2,'model-class' );
INSERT INTO `functionsections` ( `name`,`description`,`ordering`,`id`,`slug` ) VALUES ( 'Model Object Functions','These methods operate on individual objects, which means you first need to fetch or create an object and then call the method on that object. You can call these methods from anywhere, but it is not recommended to call them from view pages. When calling them from their own model files, it is recommended to reference them explicitly with the <code>this</code> scope keyword.',3,3,'model-object' );
INSERT INTO `functionsections` ( `name`,`description`,`ordering`,`id`,`slug` ) VALUES ( 'View Helper Functions','These functions can be called from the views to create output for use in a <abbr title="Hypertext Markup Language">HTML</abbr> page.',4,4,'view-helper' );
INSERT INTO `functionsections` ( `name`,`description`,`ordering`,`id`,`slug` ) VALUES ( 'Controller Initialization Functions','These functions are called from the <code>init()</code> methods of your controller files.',5,5,'controller-initialization' );
INSERT INTO `functionsections` ( `name`,`description`,`id`,`ordering`,`slug` ) VALUES ( 'Controller Request Functions','These functions are called from actions in your controller files.',6,6,'controller-request' );
INSERT INTO `functionsections` ( `name`,`description`,`ordering`,`id`,`slug` ) VALUES ( 'Global Helper Functions','These functions are general purpose functions and can be called from anywhere.',7,7,'global' );
INSERT INTO `functionsections` ( `name`,`description`,`ordering`,`id`,`slug` ) VALUES ( 'Configuration Functions','These functions should be called from files in the <kbd>config</kbd> folder.',8,8,'configuration' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Statistics Functions',2,1,9,'statistics' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Read Functions',2,1,10,'read' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Validation Functions',1,1,11,'validations' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Association Functions',1,12,1,'associations' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Update Functions',2,13,1,'update' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Miscellaneous Functions',3,14,1,'miscellaneous' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Error Functions',3,1,15,'errors' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Callback Functions',1,16,1,'callbacks' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Form Tag Functions',4,1,17,'forms-plain' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Miscellaneous Functions',7,1,18,'miscellaneous' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Miscellaneous Functions',6,19,1,'miscellaneous' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Text Functions',4,1,20,'text' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Error Functions',4,21,1,'errors' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Form Object Functions',4,22,1,'forms-object' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Link Functions',4,1,24,'links' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'String Functions',7,25,1,'string' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Asset Functions',4,26,1,'assets' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Date Functions',4,27,1,'dates' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'General Form Functions',4,1,28,'forms-general' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Sanitization Functions',4,1,29,'sanitize' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'URL Functions',4,30,1,'urls' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Flash Functions',6,31,1,'flash' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Rendering Functions',6,1,32,'rendering' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Miscellaneous Functions',1,33,1,'miscellaneous' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Create Functions',2,1,34,'create' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Delete Functions',2,35,1,'delete' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'Miscellaneous Functions',2,1,36,'miscellaneous' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Change Functions',3,37,1,'changes' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`ordering`,`id`,`slug` ) VALUES ( 'CRUD Functions',3,1,38,'crud' );
INSERT INTO `functionsections` ( `name`,`parentfunctionsectionid`,`id`,`ordering`,`slug` ) VALUES ( 'Miscellaneous Functions',4,39,1,'miscellaneous' );
DROP TABLE IF EXISTS `dummies`;
CREATE TABLE `dummies` (
 `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY
);
