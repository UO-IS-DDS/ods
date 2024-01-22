CREATE TABLE LAMPMAN.SPRIDEN AS SELECT * FROM SATURN.SPRIDEN@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SPBPERS AS SELECT * FROM SATURN.SPBPERS@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.GOREMAL AS SELECT * FROM GENERAL.GOREMAL@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SPRADDR AS SELECT * FROM SATURN.SPRADDR@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SPRTELE AS SELECT * FROM SATURN.SPRTELE@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SORLCUR AS SELECT * FROM SATURN.SORLCUR@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SORLFOS AS SELECT * FROM SATURN.SORLFOS@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SGBSTDN AS SELECT * FROM SATURN.SGBSTDN@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVMAJR AS SELECT * FROM SATURN.STVMAJR@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVTERM AS SELECT * FROM SATURN.STVTERM@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SGRADVR AS SELECT * FROM SATURN.SGRADVR@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVATTS AS SELECT * FROM SATURN.STVATTS@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVLEVL AS SELECT * FROM SATURN.STVLEVL@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVCHRT AS SELECT * FROM SATURN.STVCHRT@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVCLAS AS SELECT * FROM SATURN.STVCLAS@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVCOLL AS SELECT * FROM SATURN.STVCOLL@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVDEPT AS SELECT * FROM SATURN.STVDEPT@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SHRLGPA AS SELECT * FROM SATURN.SHRLGPA@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SHRTGPA AS SELECT * FROM SATURN.SHRTGPA@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVESTS AS SELECT * FROM SATURN.STVESTS@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SFBETRM AS SELECT * FROM SATURN.SFBETRM@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SGRCHRT AS SELECT * FROM SATURN.SGRCHRT@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SGRSATT AS SELECT * FROM SATURN.SGRSATT@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SHRTTRM AS SELECT * FROM SATURN.SHRTTRM@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SFRSTCR AS SELECT * FROM SATURN.SFRSTCR@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVRSTS AS SELECT * FROM SATURN.STVRSTS@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVSTYP AS SELECT * FROM SATURN.STVSTYP@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVASTD AS SELECT * FROM SATURN.STVASTD@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SWBTDED AS SELECT * FROM SATURN.SWBTDED@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SHRTRCE AS SELECT * FROM SATURN.SHRTRCE@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.SGRCLSR AS SELECT * FROM SATURN.SGRCLSR@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVSTAT AS SELECT * FROM SATURN.STVSTAT@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.GTVEMAL AS SELECT * FROM GENERAL.GTVEMAL@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVATYP AS SELECT * FROM SATURN.STVATYP@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVCNTY AS SELECT * FROM SATURN.STVCNTY@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVNATN AS SELECT * FROM SATURN.STVNATN@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.STVTELE AS SELECT * FROM SATURN.STVTELE@IOE_PROD.WORLD;
----------------------------------------------------------------------------

-- Build up if getting ORA-01723: zero-length columns are not allowed

CREATE TABLE LAMPMAN.STUDENT AS SELECT person_uid, 
                                                 academic_period, 
                                                 student_level,
                                                 honors_college_flag, 
                                                 packed_majors1, 
                                                 packed_majors2,
                                                 packed_majors3, 
                                                 packed_majors4    FROM ODSMGR.STUDENT@IOE_PROD.WORLD;


CREATE TABLE LAMPMAN.PERSON_DETAIL AS SELECT * FROM ODSMGR.PERSON_DETAIL@IOE_PROD.WORLD;
CREATE TABLE LAMPMAN.PERSON_ADDRESS_UO AS SELECT * FROM ODSMGR.PERSON_ADDRESS_UO@IOE_PROD.WORLD;