CREATE TRIGGER `pagelinks_before_insert` BEFORE INSERT ON `pagelinks` FOR EACH ROW
BEGIN
  IF (NOT NEW.pl_namespace AND NOT NEW.pl_from_namespace)
  THEN INSERT INTO `edges` (`u1`, `u2`)
       SELECT NEW.pl_from as `u1`, `page_id` AS `u2`
       FROM `page_dflt_ns` WHERE `page_title` = NEW.pl_title;
  END IF;
END
