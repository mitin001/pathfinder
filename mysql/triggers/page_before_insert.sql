CREATE TRIGGER `page_before_insert` BEFORE INSERT ON `page` FOR EACH ROW
BEGIN
  IF (NOT NEW.page_namespace)
  THEN INSERT INTO `page_dflt_ns` VALUES (NEW.page_id, NEW.page_title);
  END IF;
END
