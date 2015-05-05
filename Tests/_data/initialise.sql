# User groups
TRUNCATE TABLE `#__usergroups`;

INSERT INTO `#__usergroups` (`id`, `parent_id`, `lft`, `rgt`, `title`)
VALUES
  (1, 0, 1, 22, 'Public'),
  (2, 1, 8, 15, 'Registered'),
  (3, 2, 9, 14, 'Author'),
  (4, 3, 10, 13, 'Editor'),
  (5, 4, 11, 12, 'Publisher'),
  (6, 1, 4, 7, 'Manager'),
  (7, 6, 5, 6, 'Administrator'),
  (8, 1, 20, 21, 'Super Users'),
  (9, 1, 2, 3, 'Guest'),
  (10, 1, 16, 19, 'Subscribers'),
  (11, 10, 17, 18, 'Level 1 Subscriber');

# View access levels

TRUNCATE TABLE `#__viewlevels`;

INSERT INTO `#__viewlevels` (`id`, `title`, `ordering`, `rules`)
VALUES
  (1, 'Public', 0, '[1]'),
  (2, 'Registered', 2, '[6,2,8]'),
  (3, 'Special', 3, '[6,3,8]'),
  (5, 'Guest', 1, '[9]'),
  (6, 'Super Users', 4, '[8]'),
  (7, 'Subscriber Access', 0, '[10]'),
  (8, 'Level 1 Subscriber Access', 0, '[11]');

# Users. Super User login is admin/admin

TRUNCATE TABLE `#__users`;

INSERT INTO `#__users` (`id`, `name`, `username`, `email`, `password`, `block`, `sendEmail`, `registerDate`, `lastvisitDate`, `activation`, `params`, `lastResetTime`, `resetCount`, `otpKey`, `otep`, `requireReset`)
VALUES
	(100, 'Super User', 'admin', 'admin@test.web', '$2y$10$ib5dgJyv9jVG6zCiboPOZOSzKbkt4kCUwU.wKqEujV5ZKonRzR16y', 0, 1, '2015-04-28 21:28:05', '2015-04-28 21:28:31', '0', '', '0000-00-00 00:00:00', 0, '', '', 0),
	(1000, 'User One', 'user1', 'user1@test.web', '$2y$10$vyC0MR3wtTRwD4JjvQylrOu0NGtFJ2HJSUJkpo9eDyHZO9L7.kj4m', 0, 0, '2015-04-29 18:13:57', '0000-00-00 00:00:00', '', '{}', '0000-00-00 00:00:00', 0, '', '', 0),
	(1001, 'User Two', 'user2', 'user2@test.web', '$2y$10$LpoNGSf0UMrt6BCrANfFkOD0bwxvJobHULVr4Daz0cDVkmVjwFCqO', 1, 0, '2015-04-29 18:13:57', '0000-00-00 00:00:00', '', '{}', '0000-00-00 00:00:00', 0, '', '', 0),
	(1002, 'User Three', 'user3', 'user3@test.web', '$2y$10$9ezk6XoWrpyXUXESQccRcOX65xsY0mX8NVLh6tDX7HMxbipQk/ji.', 1, 0, '2015-04-29 18:13:57', '0000-00-00 00:00:00', 'notempty', '{}', '0000-00-00 00:00:00', 0, '', '', 0),
  (1010, 'Business User', 'business', 'business@test.web', '$2y$10$vyC0MR3wtTRwD4JjvQylrOu0NGtFJ2HJSUJkpo9eDyHZO9L7.kj4m', 0, 0, '2015-04-29 18:13:57', '0000-00-00 00:00:00', '', '{}', '0000-00-00 00:00:00', 0, '', '', 0),
  (1011, 'Forced VAT Check', 'forcedvat', 'forcedvat@test.web', '$2y$10$vyC0MR3wtTRwD4JjvQylrOu0NGtFJ2HJSUJkpo9eDyHZO9L7.kj4m', 0, 0, '2015-04-29 18:13:57', '0000-00-00 00:00:00', '', '{}', '0000-00-00 00:00:00', 0, '', '', 0),
  (1020, 'Guinea Pig', 'guineapig', 'guineapig@test.web', '$2y$10$vyC0MR3wtTRwD4JjvQylrOu0NGtFJ2HJSUJkpo9eDyHZO9L7.kj4m', 0, 0, '2015-04-29 18:13:57', '0000-00-00 00:00:00', '', '{}', '0000-00-00 00:00:00', 0, '', '', 0);

# Users to user groups

TRUNCATE TABLE `#__user_usergroup_map`;

INSERT INTO `#__user_usergroup_map` (`user_id`, `group_id`)
VALUES
  (100, 8),
  (1000, 2),
  (1000, 10),
  (1001, 2),
  (1002, 2),
  (1010, 2),
  (1010, 10),
  (1011, 2),
  (1011, 10),
  (1020, 2);

# Akeeba Subscriptions: Users

TRUNCATE TABLE `#__akeebasubs_users`;

INSERT INTO `#__akeebasubs_users` (`akeebasubs_user_id`, `user_id`, `isbusiness`, `businessname`, `occupation`, `vatnumber`, `viesregistered`, `taxauthority`, `address1`, `address2`, `city`, `state`, `zip`, `country`, `params`, `notes`, `needs_logout`)
VALUES
  (1, 1010, 1, 'Η Εταιρία', 'Κατασκευή προγραμμάτων', '', 0, NULL, 'Μεγάλου Αλεξάνδρου 1', 'Γραφείο 101', 'Κωλοπετινίτσα', 'GR-ATT', '99999', 'GR', '[]', '', 0),
  (2, 1011, 1, 'Τρία Κιλά Κώδικα ΑΕ', 'Εμπορία λογισμικού', '123456789', 2, NULL, 'Μακρυγιάννη 13', '', 'Μικρό Πεύκο', 'GR-ATT', '99888', 'GR', '[]', '', 0);

# Akeeba Subscriptions: Tax Rules (Cyprus, 19% VAT, VIES registered)

TRUNCATE TABLE `#__akeebasubs_taxrules`;

INSERT INTO `#__akeebasubs_taxrules` (`akeebasubs_taxrule_id`, `country`, `state`, `city`, `vies`, `taxrate`, `akeebasubs_level_id`, `enabled`, `ordering`, `created_on`, `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`)
VALUES
  (34, '', '', '', 0, 0, 0, 1, 1, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (35, '', '', '', 1, 0, 0, 1, 2, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (36, 'CY', '', '', 0, 19, 0, 1, 3, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (37, 'CY', '', '', 1, 19, 0, 1, 4, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (38, 'BE', '', '', 0, 21, 0, 1, 5, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (39, 'BG', '', '', 0, 20, 0, 1, 6, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (40, 'CZ', '', '', 0, 21, 0, 1, 7, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (41, 'DK', '', '', 0, 25, 0, 1, 8, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (42, 'DE', '', '', 0, 19, 0, 1, 9, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (43, 'EE', '', '', 0, 20, 0, 1, 10, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (44, 'GR', '', '', 0, 23, 0, 1, 11, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (45, 'ES', '', '', 0, 21, 0, 1, 12, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (46, 'FR', '', '', 0, 20, 0, 1, 13, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (47, 'HR', '', '', 0, 25, 0, 1, 14, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (48, 'IE', '', '', 0, 23, 0, 1, 15, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (49, 'IT', '', '', 0, 22, 0, 1, 16, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (50, 'LV', '', '', 0, 21, 0, 1, 17, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (51, 'LT', '', '', 0, 21, 0, 1, 18, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (52, 'LU', '', '', 0, 17, 0, 1, 19, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (53, 'HU', '', '', 0, 27, 0, 1, 20, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (54, 'MT', '', '', 0, 18, 0, 1, 21, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (55, 'NL', '', '', 0, 21, 0, 1, 22, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (56, 'AT', '', '', 0, 20, 0, 1, 23, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (57, 'PL', '', '', 0, 23, 0, 1, 24, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (58, 'PT', '', '', 0, 23, 0, 1, 25, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (59, 'RO', '', '', 0, 24, 0, 1, 26, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (60, 'SI', '', '', 0, 22, 0, 1, 27, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (61, 'SK', '', '', 0, 20, 0, 1, 28, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (62, 'FI', '', '', 0, 24, 0, 1, 29, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (63, 'SE', '', '', 0, 25, 0, 1, 30, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (64, 'GB', '', '', 0, 20, 0, 1, 31, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (65, 'MC', '', '', 0, 20, 0, 1, 32, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (66, 'IM', '', '', 0, 20, 0, 1, 33, '2015-04-30 07:18:21', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

# Subscription levels

TRUNCATE TABLE `#__akeebasubs_levels`;

INSERT INTO `#__akeebasubs_levels` (`akeebasubs_level_id`, `title`, `slug`, `image`, `description`, `duration`, `price`, `signupfee`, `ordertext`, `orderurl`, `canceltext`, `cancelurl`, `only_once`, `recurring`, `forever`, `akeebasubs_levelgroup_id`, `access`, `fixed_date`, `payment_plugins`, `renew_url`, `content_url`, `params`, `enabled`, `ordering`, `created_on`, `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`, `notify1`, `notify2`, `notifyafter`)
VALUES
	(1, 'LEVEL1', 'level1', 'images/joomla_black.gif', '<p>Sample subscription level with a non-zero price and a sign-up fee</p>', 365, 100, 10, '<p>Successful sign-up</p>', '', '<p>Canceled sign-up</p>', '', 0, 0, 0, 0, 1, '0000-00-00 00:00:00', '', '', '', '{\"slavesubs_maxSlaves\":\"0\"}', 1, 0, '2015-04-30 10:45:10', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 30, 15, 0),
	(2, 'LEVEL2', 'level2', 'images/joomla_black.gif', '<p>Sample subscription level with a non-zero price and no sign-up fee</p>', 365, 100, 0, '<p>Successful sign-up</p>', '', '<p>Canceled sign-up</p>', '', 0, 0, 0, 0, 1, '0000-00-00 00:00:00', '', '', '', '{\"joomla_addgroups\":[\"10\"],\"joomla_removegroups\":[\"10\"],\"slavesubs_maxSlaves\":\"1\"}', 1, 0, '2015-04-30 10:49:56', 100, '2015-04-30 10:50:58', 100, '0000-00-00 00:00:00', 0, 30, 15, 0),
	(3, 'RECURRING', 'recurring', 'images/joomla_black.gif', '<p>Sample subscription level with a non-zero price, sign-up fee and recurring</p>', 365, 100, 10, '<p>Successful sign-up</p>', '', '<p>Canceled sign-up</p>', '', 0, 1, 0, 0, 1, '0000-00-00 00:00:00', '', '', '', '{\"joomla_addgroups\":[\"10\"],\"joomla_removegroups\":[\"10\"],\"slavesubs_maxSlaves\":\"1\"}', 1, 0, '2015-05-04 08:24:34', 100, '2015-05-04 08:25:19', 100, '0000-00-00 00:00:00', 0, 30, 15, 0),
	(4, 'FOREVER', 'forever', 'images/joomla_black.gif', '<p>Non-zero price, no sign-up fee, forever active</p>', 0, 100, 0, '<p>Successful sign-up</p>', '', '<p>Canceled sign-up</p>', '', 0, 0, 1, 0, 1, '0000-00-00 00:00:00', '', '', '', '{\"joomla_addgroups\":[\"10\"],\"joomla_removegroups\":[\"10\"],\"slavesubs_maxSlaves\":\"1\"}', 1, 0, '2015-05-04 08:25:23', 100, '2015-05-04 08:25:55', 100, '0000-00-00 00:00:00', 0, 30, 15, 0),
	(5, 'FIXED', 'fixed', 'images/joomla_black.gif', '<p>Non-zero price, fixed expiration date (January 1st, 2030)</p>', 0, 100, 0, '<p>Successful sign-up</p>', '', '<p>Canceled sign-up</p>', '', 0, 0, 0, 0, 1, '2030-01-01 00:00:00', '', '', '', '{\"joomla_addgroups\":[\"10\"],\"joomla_removegroups\":[\"10\"],\"slavesubs_maxSlaves\":\"1\"}', 1, 0, '2015-05-04 08:26:02', 100, '2015-05-04 08:26:50', 100, '0000-00-00 00:00:00', 0, 30, 15, 0),
	(6, 'FREE', 'free', 'images/joomla_black.gif', '<p>zero price, no signup fee</p>', 365, 0, 0, '<p>Successful sign-up</p>', '', '<p>Canceled sign-up</p>', '', 0, 0, 0, 0, 1, '0000-00-00 00:00:00', '', '', '', '{\"joomla_addgroups\":[\"10\"],\"joomla_removegroups\":[\"10\"],\"slavesubs_maxSlaves\":\"1\"}', 1, 0, '2015-05-04 08:26:56', 100, '2015-05-04 08:27:28', 100, '0000-00-00 00:00:00', 0, 30, 15, 0),
	(7, 'FREEWITHSIGNUP', 'freewithsignup', 'images/joomla_black.gif', '<p>Zero price, non-zero signup fee. Why would someone do that is beyond me.</p>', 365, 0, 10, '<p>Successful sign-up</p>', '', '<p>Canceled sign-up</p>', '', 0, 0, 0, 0, 1, '0000-00-00 00:00:00', '', '', '', '{\"joomla_addgroups\":[\"10\"],\"joomla_removegroups\":[\"10\"],\"slavesubs_maxSlaves\":\"1\"}', 1, 0, '2015-05-04 08:27:32', 100, '2015-05-04 08:28:09', 100, '0000-00-00 00:00:00', 0, 30, 15, 0),
	(8, 'NORENEW', 'norenew', 'images/powered_by.png', '<p>Forbid renewals. Non-zero price, nothing else.</p>', 30, 50, 0, '', '', '', '', 0, 0, 0, 0, 1, '0000-00-00 00:00:00', '', '', '', '{\"slavesubs_maxSlaves\":\"0\"}', 1, 0, '2015-05-04 08:29:06', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 30, 15, 0);


# Coupons

TRUNCATE TABLE `#__akeebasubs_coupons`;

INSERT INTO `#__akeebasubs_coupons` (`akeebasubs_coupon_id`, `akeebasubs_apicoupon_id`, `title`, `coupon`, `publish_up`, `publish_down`, `subscriptions`, `user`, `email`, `params`, `hitslimit`, `userhits`, `usergroups`, `type`, `value`, `enabled`, `ordering`, `created_on`, `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`, `hits`)
VALUES
  (1, 0, '50% off', 'VALIDALL', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:45:49', 100, '2015-04-30 10:47:37', 100, '0000-00-00 00:00:00', 0, 0),
  (2, 0, 'Not yet active', 'NOTYETACTIVE', '2030-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:48:20', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (3, 0, 'Already expired', 'ALREADYEXPIRED', '2001-01-01 00:00:00', '2015-01-01 00:00:00', '', 0, '', NULL, 0, 0, '', 'percent', 50, 0, 0, '2015-04-30 10:48:52', 100, '2015-04-30 10:48:52', 100, '0000-00-00 00:00:00', 0, 0),
  (4, 0, 'For LEVEL1', 'FORLEVEL1', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '1', 0, '', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:49:26', 100, '2015-04-30 10:49:49', 100, '0000-00-00 00:00:00', 0, 0),
  (5, 0, 'For LEVEL2', 'FORLEVEL2', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '2', 0, '', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:51:23', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (6, 0, 'For user1', 'FORUSER1', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 1000, '', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:52:08', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (7, 0, 'For business user', 'FORBUSINESS', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 1010, '', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:52:28', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (8, 0, 'For user1\'s email', 'FORUSER1EMAIL', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, 'user1@test.web', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:57:13', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (9, 0, 'For user2\'s email', 'FORUSER2EMAIL', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, 'user2@test.web', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:57:41', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (10, 0, 'For subscribers', 'FORSUBSCRIBERS', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 0, '10', 'percent', 50, 1, 0, '2015-04-30 10:58:12', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (11, 0, 'For super users', 'FORSUPERUSERS', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 0, '8', 'percent', 50, 1, 0, '2015-04-30 10:58:46', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (12, 0, 'Ten hits', 'TENHITS', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 10, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:59:15', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (13, 0, 'One hit', 'ONEHIT', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 1, 0, '', 'percent', 50, 1, 0, '2015-04-30 10:59:31', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (14, 0, 'Ten user hits', 'TENUSERHITS', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 10, '', 'percent', 50, 1, 0, '2015-04-30 10:59:49', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (15, 0, 'One user hit', 'ONEUSERHIT', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 1, '', 'percent', 50, 1, 0, '2015-04-30 11:00:08', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (16, 0, 'Inside date range', 'INSIDEDATERANGE', '2015-03-01 00:00:00', '2030-03-01 00:00:00', '', 0, '', NULL, 0, 0, '', 'percent', 50, 1, 0, '2015-04-30 11:01:46', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (17, 0, 'Two user hits', 'TWOUSERHITS', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 2, '', 'percent', 50, 1, 0, '2015-04-30 11:04:27', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (18, 0, '12.34€ off', 'FIXED1234', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 0, '', 'value', 12.34, 1, 0, '2015-04-30 10:45:49', 100, '2015-04-30 10:47:37', 100, '0000-00-00 00:00:00', 0, 0),
  (19, 0, 'Last transaction 50%', 'LAST50', '2001-01-01 00:00:00', '2038-01-18 00:00:00', '', 0, '', NULL, 0, 0, '', 'lastpercent', 50, 1, 0, '2015-04-30 10:45:49', 100, '2015-04-30 10:47:37', 100, '0000-00-00 00:00:00', 0, 0);

# Subscriptions

TRUNCATE TABLE `#__akeebasubs_subscriptions`;

INSERT INTO `#__akeebasubs_subscriptions` (`akeebasubs_subscription_id`, `user_id`, `akeebasubs_level_id`, `publish_up`, `publish_down`, `notes`, `enabled`, `processor`, `processor_key`, `state`, `net_amount`, `tax_amount`, `gross_amount`, `recurring_amount`, `tax_percent`, `created_on`, `params`, `ip`, `ip_country`, `akeebasubs_coupon_id`, `akeebasubs_upgrade_id`, `akeebasubs_affiliate_id`, `affiliate_comission`, `akeebasubs_invoice_id`, `prediscount_amount`, `discount_amount`, `contact_flag`, `first_contact`, `second_contact`, `after_contact`)
VALUES
  (1, 1000, 1, '2013-04-30 00:00:00', '2014-04-30 00:00:00', '', 0, 'none', '20130430000000', 'C', 80, 0, 80, 0, 0, '2013-04-30 00:00:00', '[]', '', '', 14, NULL, NULL, 0, NULL, NULL, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (2, 1000, 2, '2014-04-30 00:00:00', '2015-04-29 00:00:00', '', 0, 'none', '20140430000000', 'C', 90, 0, 90, 0, 0, '2014-04-30 00:00:00', '[]', '', '', 15, NULL, NULL, 0, NULL, NULL, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (3, 1010, 1, '2013-04-30 00:00:00', '2014-04-30 00:00:00', '', 0, 'none', '20130430001010', 'C', 80, 0, 80, 0, 0, '2013-04-30 00:00:00', '[]', '', '', 17, NULL, NULL, 0, NULL, NULL, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (4, 1010, 1, '2014-04-30 00:00:00', '2015-04-29 00:00:00', '', 0, 'none', '20140430001010', 'C', 90, 0, 90, 0, 0, '2014-04-30 00:00:00', '[]', '', '', 17, NULL, NULL, 0, NULL, NULL, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (5, 1010, 2, '2013-04-30 00:00:00', '2014-04-29 00:00:00', '', 0, 'none', '20140430101010', 'C', 90, 0, 90, 0, 0, '2014-04-30 00:00:00', '[]', '', '', 12, NULL, NULL, 0, NULL, NULL, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (6, 1010, 2, '2014-04-30 00:00:00', '2015-04-29 00:00:00', '', 0, 'none', '20140430111010', 'C', 90, 0, 90, 0, 0, '2014-04-30 00:00:00', '[]', '', '', 13, NULL, NULL, 0, NULL, NULL, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (7, 1010, 1, '2015-04-30 00:00:00', '2025-04-29 00:00:00', '', 0, 'none', '20150430001010', 'C', 100, 0, 100, 0, 0, '2015-04-30 00:00:00', '[]', '', '', 0, NULL, NULL, 0, NULL, NULL, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

# Upgrade rules

TRUNCATE TABLE `#__akeebasubs_upgrades`;

INSERT INTO `#__akeebasubs_upgrades` (`akeebasubs_upgrade_id`, `title`, `from_id`, `to_id`, `min_presence`, `max_presence`, `type`, `value`, `combine`, `expired`, `enabled`, `ordering`, `created_on`, `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`, `hits`)
VALUES
  (1, 'LEVEL1 renewal 10% six first months', 1, 1, 0, 180, 'percent', 10, 0, 0, 1, 0, '2015-05-04 10:19:41', 100, '2015-05-04 10:21:08', 100, '0000-00-00 00:00:00', 0, 0),
  (2, 'LEVEL1 to LEVEL2 – 5€ off', 1, 2, 0, 600, 'value', 5, 0, 0, 1, 0, '2015-05-04 10:20:26', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (3, 'LEVEL1 renewal 20% last after 6 months', 1, 1, 180, 720, 'lastpercent', 20, 0, 0, 1, 0, '2015-05-04 10:40:57', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (4, 'LEVEL1 resubscribe 30% after expiration', 1, 1, 0, 365, 'percent', 30, 0, 1, 1, 0, '2015-05-04 10:41:43', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (5, 'Expired LEVEL1 up to 10 days to LEVEL2, 12.34€ off', 1, 2, 0, 10, 'value', 12.34, 0, 1, 1, 0, '2015-05-04 10:42:46', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (6, 'LEVEL1 to FOREVER 10%, combine', 1, 4, 0, 365, 'percent', 10, 1, 0, 1, 0, '2015-05-04 10:46:23', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (7, 'LEVEL2 to FOREVER 10%, combine', 2, 4, 0, 365, 'percent', 10, 1, 0, 1, 0, '2015-05-04 10:46:44', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (8, 'RECURRING to FIXED active, 10%, combine', 3, 5, 0, 365, 'percent', 10, 1, 0, 1, 0, '2015-05-04 10:49:43', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (9, 'RECURRING to FIXED after expiration, 10%, combine', 3, 5, 0, 700, 'percent', 10, 1, 1, 1, 0, '2015-05-04 10:50:10', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (10, 'FREE to FIXED, unpublished', 6, 5, 0, 365, 'percent', 10, 0, 0, 0, 0, '2015-05-04 10:50:45', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (11, 'LEVEL2 to LEVEL1, active – 15€ off', 2, 1, 0, 600, 'value', 15, 0, 0, 1, 0, '2015-05-04 10:20:26', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0),
  (12, 'LEVEL2 to LEVEL1, inactive – 5€ off', 2, 1, 0, 600, 'value', 5, 0, 1, 1, 0, '2015-05-04 10:20:26', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, 0);

# Subscription level relations

TRUNCATE TABLE `#__akeebasubs_relations`;

INSERT INTO `#__akeebasubs_relations` (`akeebasubs_relation_id`, `source_level_id`, `target_level_id`, `mode`, `type`, `amount`, `low_threshold`, `low_amount`, `high_threshold`, `high_amount`, `flex_amount`, `flex_period`, `flex_uom`, `flex_timecalculation`, `time_rounding`, `expiration`, `combine`, `enabled`, `ordering`, `created_on`, `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`)
VALUES
  (1, 1, 1, 'rules', 'percent', 0, 0, 0, 0, 0, 0, 0, 'd', 'current', 'round', 'replace', 0, 1, 0, '2015-05-05 08:00:52', 100, '2015-05-05 08:32:31', 100, '0000-00-00 00:00:00', 0),
  (2, 1, 2, 'rules', 'percent', 0, 0, 0, 0, 0, 0, 0, 'd', 'current', 'round', 'after', 0, 1, 0, '2015-05-05 08:01:05', 100, '2015-05-05 08:32:31', 100, '0000-00-00 00:00:00', 0),
  (3, 2, 4, 'rules', 'percent', 0, 0, 0, 0, 0, 0, 0, 'd', 'current', 'round', 'overlap', 0, 1, 0, '2015-05-05 08:31:20', 100, '2015-05-05 08:32:31', 100, '0000-00-00 00:00:00', 0),
  (4, 7, 1, 'fixed', 'value', 5, 0, 0, 0, 0, 0, 0, 'd', 'current', 'round', 'replace', 0, 1, 0, '2015-05-05 08:32:14', 100, '2015-05-05 08:32:31', 100, '0000-00-00 00:00:00', 0),
  (5, 7, 2, 'fixed', 'percent', 10, 0, 0, 0, 0, 0, 0, 'd', 'current', 'round', 'replace', 0, 1, 0, '2015-05-05 08:32:27', 100, '2015-05-05 08:32:31', 100, '0000-00-00 00:00:00', 0),
  (6, 6, 1, 'flexi', 'value', 0, 2, 2, 11, 12, 1, 1, 'm', 'current', 'round', 'replace', 0, 1, 0, '2015-05-05 08:33:18', 100, '2015-05-05 08:38:50', 100, '0000-00-00 00:00:00', 0),
  (7, 6, 2, 'flexi', 'value', 0, 2, 2, 20, 22, 1, 1, 'm', 'future', 'round', 'replace', 0, 1, 0, '2015-05-05 08:40:32', 100, '2015-05-05 08:49:51', 100, '0000-00-00 00:00:00', 0),
  (8, 1, 3, 'fixed', 'value', 10, 0, 0, 0, 0, 0, 0, 'd', 'current', 'round', 'replace', 1, 1, 0, '2015-05-05 08:50:43', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
  (9, 2, 3, 'fixed', 'value', 15, 0, 0, 0, 0, 0, 0, 'd', 'current', 'round', 'replace', 1, 1, 0, '2015-05-05 08:50:59', 100, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
