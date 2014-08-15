<?php
/*
 * In this file you can override all configuration options for user "example"
 */

/* this sets example's password to "expass" */
$ara_user["pass"] = "expass2";

/* SQL server setings */
//$config["sql_username"]    = "radius-restricted";
//$config["sql_passwd"]      = "radiusabc";

/* set access level - choose from:
 * 	ARA_ACCESS_NONE     - guess
 * 	ARA_ACCESS_VIEW     - can view everything except passwd_attributes
 * 	ARA_ACCESS_VIEW_ALL - as above, but this time everything
 * 	ARA_ACCESS_EDIT     - as above, but can save forms
 * 	ARA_ACCESS_ALL      - is Charlie Root here
 */
$config["access_level"] = ARA_ACCESS_EDIT;

/* by default allow (TRUE) or deny (FALSE) access to modules */
$config["default_access"] = TRUE;

/* forbid access to specified modules, use this if default_access == TRUE
 *
 * eg. $config["forbidden_modules"] = array("user/list-online", "nas/edit");
 */
//$config["forbidden_modules"] = array();

/* allow access to specified modules, use this if default_access == FALSE
 *
 * see the sample above
 */
//$config["allowed_modules"] = array("nas/edit");

?>
