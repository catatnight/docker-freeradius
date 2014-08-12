CREATE TABLE `userinfo` (
  `id` int(10) NOT NULL auto_increment,
  `UserName` varchar(30) collate utf8_unicode_ci default NULL,
  `Name` varchar(200) collate utf8_unicode_ci default NULL,
  `Mail` varchar(200) collate utf8_unicode_ci default NULL,
  `Department` varchar(200) collate utf8_unicode_ci default NULL,
  `WorkPhone` varchar(200) collate utf8_unicode_ci default NULL,
  `HomePhone` varchar(200) collate utf8_unicode_ci default NULL,
  `Mobile` varchar(200) collate utf8_unicode_ci default NULL,
  `notes` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  KEY `UserName` (`UserName`),
  KEY `Departmet` (`Department`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=981 ;
