  Oracle Materialized View is the fastest-cycling Cross-Platform CDC method
  from Oracle-to-Oracle, and Oracle-to-PostGres (thus DuckDB too).

  In IOEP, these refresh on-schedule ever 30 min from Banner PROD.  During 
  this 30 min cycle, all ODS Materialized Views become sync'd with Banner 
  after an average of 15 min processing, then are frozen until the cycle 
  repeats.

  Since our other ingestion methods are slower, and not CDC yet, these
  Materialized Views provide a useful discrete pause cycle from continuous
  update.  This pause (~15 min) provides a time-window which can be used for
  snapshotting a Banner table-set in a relatively coherent state.  Once in
  this state, additional ingestion/transfer methods can be used/developed.

  Depending on the domain of data, this coherent state may be sufficient for
  DBT/Consumption development over an extended period of time before a new
  coherent state is prudent.

  During ODS Refactor efforts, the timing of snapshotting a coherent state
  should be as close as feasible to the state of the ***DAILY*** refreshed
  ODS Composite Tables (also called 'Reporting' tables), completing ususally
  by 8am.  Unless MViews refreshes are suspended for a portion of the day, 
  closest to (but after) 8am is best, if ***manually*** frozen.

  This file provides SQL statements to affect the freezing, organized by 
  domain, and includes and ODSMGR RViews under active refactoring.

  These are intended to be run in IOEP, manually, or by schedule. 


``` sql
-- Domain: Common -----------------------------------------------------------
CREATE TABLE IDRWORX.SPRIDEN AS SELECT * FROM SATURN.SPRIDEN;
CREATE TABLE IDRWORX.SPBPERS AS SELECT * FROM SATURN.SPBPERS;
CREATE TABLE IDRWORX.GOREMAL AS SELECT * FROM GENERAL.GOREMAL;
CREATE TABLE IDRWORX.SPRADDR AS SELECT * FROM SATURN.SPRADDR;
CREATE TABLE IDRWORX.SPRTELE AS SELECT * FROM SATURN.SPRTELE;
CREATE TABLE IDRWORX.STVSTAT AS SELECT * FROM SATURN.STVSTAT;
CREATE TABLE IDRWORX.GTVEMAL AS SELECT * FROM GENERAL.GTVEMAL;
CREATE TABLE IDRWORX.STVATYP AS SELECT * FROM SATURN.STVATYP;
CREATE TABLE IDRWORX.STVCNTY AS SELECT * FROM SATURN.STVCNTY;
CREATE TABLE IDRWORX.STVNATN AS SELECT * FROM SATURN.STVNATN;
CREATE TABLE IDRWORX.STVTELE AS SELECT * FROM SATURN.STVTELE;

-- RViews
CREATE TABLE IDRWORX.PERSON_DETAIL AS SELECT * FROM ODSMGR.PERSON_DETAIL;
CREATE TABLE IDRWORX.PERSON_ADDRESS_UO AS SELECT * FROM ODSMGR.PERSON_ADDRESS_UO;
```
----------------------------------------------------------------------------
----------------------------------------------------------------------------
``` sql
-- Domain: Registrar -------------------------------------------------------
CREATE TABLE IDRWORX.SORLCUR AS SELECT * FROM SATURN.SORLCUR;
CREATE TABLE IDRWORX.SORLFOS AS SELECT * FROM SATURN.SORLFOS;
CREATE TABLE IDRWORX.SGBSTDN AS SELECT * FROM SATURN.SGBSTDN;
CREATE TABLE IDRWORX.STVMAJR AS SELECT * FROM SATURN.STVMAJR;
CREATE TABLE IDRWORX.STVTERM AS SELECT * FROM SATURN.STVTERM;
CREATE TABLE IDRWORX.SGRADVR AS SELECT * FROM SATURN.SGRADVR;
CREATE TABLE IDRWORX.STVATTS AS SELECT * FROM SATURN.STVATTS;
CREATE TABLE IDRWORX.STVLEVL AS SELECT * FROM SATURN.STVLEVL;
CREATE TABLE IDRWORX.STVCHRT AS SELECT * FROM SATURN.STVCHRT;
CREATE TABLE IDRWORX.STVCLAS AS SELECT * FROM SATURN.STVCLAS;
CREATE TABLE IDRWORX.STVCOLL AS SELECT * FROM SATURN.STVCOLL;
CREATE TABLE IDRWORX.STVDEPT AS SELECT * FROM SATURN.STVDEPT;
CREATE TABLE IDRWORX.SHRLGPA AS SELECT * FROM SATURN.SHRLGPA;
CREATE TABLE IDRWORX.SHRTGPA AS SELECT * FROM SATURN.SHRTGPA;
CREATE TABLE IDRWORX.STVESTS AS SELECT * FROM SATURN.STVESTS;
CREATE TABLE IDRWORX.SFBETRM AS SELECT * FROM SATURN.SFBETRM;
CREATE TABLE IDRWORX.SGRCHRT AS SELECT * FROM SATURN.SGRCHRT;
CREATE TABLE IDRWORX.SGRSATT AS SELECT * FROM SATURN.SGRSATT;
CREATE TABLE IDRWORX.SHRTTRM AS SELECT * FROM SATURN.SHRTTRM;
CREATE TABLE IDRWORX.SFRSTCR AS SELECT * FROM SATURN.SFRSTCR;
CREATE TABLE IDRWORX.STVRSTS AS SELECT * FROM SATURN.STVRSTS;
CREATE TABLE IDRWORX.STVSTYP AS SELECT * FROM SATURN.STVSTYP;
CREATE TABLE IDRWORX.STVASTD AS SELECT * FROM SATURN.STVASTD;
CREATE TABLE IDRWORX.SWBTDED AS SELECT * FROM SATURN.SWBTDED;
CREATE TABLE IDRWORX.SHRTRCE AS SELECT * FROM SATURN.SHRTRCE;
CREATE TABLE IDRWORX.SGRCLSR AS SELECT * FROM SATURN.SGRCLSR;

-- RViews
CREATE TABLE IDRWORX.STUDENT AS SELECT * FROM ODSMGR.STUDENT;
```

