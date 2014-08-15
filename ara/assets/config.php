<?php
/* ARA configuration file
 *
 * This file will be included for all users.
 *
 * For authenticated users ./config/users/$user.php will be inclued
 * AFTER this file, overriding options written here.
 */

$config = array();

/*
 * GENERAL
 */

/* set this to TRUE to enable debugging */
$config["debug"] = FALSE;

/* full path to PHP CLI */
$config["php_bin"] = "/usr/bin/php";

/* choose FreeRADIUS database storage type */
$config["radius_storage"] = "sql";

/*
 * SQL
 */

/* SQL server setings */
$config["sql_driver"]      = "mysql";
$config["sql_server_host"] = "localhost";
$config["sql_server_port"] = "3306";
$config["sql_username"]    = "usrname";
$config["sql_passwd"]      = "passwd2";
$config["sql_db"]          = "radius";
$config["sql_encoding"]    = "utf8";

/* this probably needs no modification */
$config["sql_table_usergroup"]     = "radusergroup";
$config["sql_table_radacct"]       = "radacct";
$config["sql_table_radreply"]      = "radreply";
$config["sql_table_radcheck"]      = "radcheck";
$config["sql_table_radgroupreply"] = "radgroupreply";
$config["sql_table_radgroupcheck"] = "radgroupcheck";
$config["sql_table_nas"]           = "nas";
$config["sql_debug"]               = FALSE;

/*
 * Extensions
 */

/* read src/lib/sql-user-ext/README */
$config["sql_user_extension"]      = TRUE;
$config["sql_user_extension_name"] = "da";

/* link to external user (session) killer - page that will trigger closing user
 * opened sessions; it will be called with POST parameter named value_name
 * and argument - login of user to be "killed" */
$config["use_user_killer"]        = FALSE;
$config["user_killer_url"]        = "https://yourhost/session-killer/";
$config["user_killer_value_name"] = "user";

/*
 * DATA INTEGRITY.
 */
// renaming user in database is considered
// bad idea, especialy if there are
// external references somewhere that
// does not know about
$config["allow_login_renaming"] = false;


/*
 * DISPLAY
 */

/* following RADIUS attributes' values will be hidden by default - user will
 * be required to click on value field to show it */
$config["masq_attributes"] = array(
	"Password",
	"UserPassword",
	"User-Password",
	"Cleartext-Password"
);

/*
 * PDF settings for accounting
 */
// $config['pdf_font'] = 'FreeMono';
// $config['pdf_font_size'] = 9;
// $config['pdf_left_margin'] = 30;
// $config['pdf_top_margin']  = 20;
// $config['pdf_header_title'] = 'My ISP company';
// $config['pdf_lang'] = 'en';

/* enable statistics of todays total bandwidth
 *
 * the word "quick" is currently little misleading - generation of these
 * stats delays page generation - this is the reason it's disabled by default
 */
$config["use_quick_stats"] = FALSE;

/*
 * AUTHENTICATION
 *
 * defaults are good for http server auth
 */

/* use PHP_AUTH_USER authentication mechanism */
$config["use_auth"] = TRUE;

/*
 * don't let go through users that don't have
 * corresponding users/$user.php file
 */
$config["force_user_file"] = TRUE;

/*
 * don't allow users/$user.php without a password
 */
$config["allow_user_file_without_pass"] = FALSE;

/*
 * AUTHORIZATION
 */

/* values of those attributes will be considered "valuable" (see
 * ACCESS_VIEW below) */
$config["passwd_attributes"] = array(
	"Password",
	"UserPassword",
	"User-Password"
);

/*
 * following are the defaults for all users (even if use_auth == FALSE)
 *
 * these options should be overridden in per-user configuration files
 *
 * hint: overriding sql_* options may be useful too - to use different SQL
 *       accounts (which can have more restrictions)
*/

/*
 * set access level - choose from:
 * ARA_ACCESS_NONE     - guess
 * ARA_ACCESS_VIEW     - can view everything except passwd_attributes
 * ARA_ACCESS_VIEW_ALL - as above, but this time everything
 * ARA_ACCESS_EDIT     - as above, but can save forms
 * ARA_ACCESS_ALL      - is Charlie Root here
 */
$config["access_level"] = ARA_ACCESS_VIEW;

/* by default allow (TRUE) or deny (FALSE) access to modules */
$config["default_access"] = TRUE;

/* forbid access to specified modules, use this if default_access == TRUE
 *
 * eg. $config["forbidden_modules"] = array("user/list-online", "nas/edit");
 */
$config["forbidden_modules"] = array();

/* allow access to specified modules, use this if default_access == FALSE
 *
 * see the sample above
 */
$config["allowed_modules"] = array();

?>
