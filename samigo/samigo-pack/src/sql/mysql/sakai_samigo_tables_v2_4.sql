alter table SAM_ANSWERFEEDBACK_T drop foreign key FK58CEF0D8DEC85889;
alter table SAM_ANSWER_T drop foreign key FKDD0580933288DBBD;
alter table SAM_ANSWER_T drop foreign key FKDD058093278A7DAD;
alter table SAM_ASSESSACCESSCONTROL_T drop foreign key FKC945448A694216CC;
alter table SAM_ASSESSEVALUATION_T drop foreign key FK6A6F29F5694216CC;
alter table SAM_ASSESSFEEDBACK_T drop foreign key FK557D4CFE694216CC;
alter table SAM_ASSESSMETADATA_T drop foreign key FK7E6F9A28694216CC;
alter table SAM_ATTACHMENT_T drop foreign key FK99FA8CB8CAC2365B;
alter table SAM_ATTACHMENT_T drop foreign key FK99FA8CB83288DBBD;
alter table SAM_ATTACHMENT_T drop foreign key FK99FA8CB870CE2BD;
alter table SAM_GRADINGSUMMARY_T drop foreign key FKBC88AA27D02EF633;
alter table SAM_ITEMFEEDBACK_T drop foreign key FK3254E9ED3288DBBD;
alter table SAM_ITEMGRADING_T drop foreign key FKB68E675667B430D5;
alter table SAM_ITEMMETADATA_T drop foreign key FK5B4737173288DBBD;
alter table SAM_ITEMTEXT_T drop foreign key FK271D63153288DBBD;
alter table SAM_ITEM_T drop foreign key FK3AAC5EA870CE2BD;
alter table SAM_MEDIA_T drop foreign key FKD4CF5A194D7EA7B3;
alter table SAM_PUBLISHEDACCESSCONTROL_T drop foreign key FK2EDF39E09482C945;
alter table SAM_PUBLISHEDANSWERFEEDBACK_T drop foreign key FK6CB765A624D77573;
alter table SAM_PUBLISHEDANSWER_T drop foreign key FKB41EA36131446627;
alter table SAM_PUBLISHEDANSWER_T drop foreign key FKB41EA36126460817;
alter table SAM_PUBLISHEDATTACHMENT_T drop foreign key FK270998869482C945;
alter table SAM_PUBLISHEDATTACHMENT_T drop foreign key FK2709988631446627;
alter table SAM_PUBLISHEDATTACHMENT_T drop foreign key FK27099886895D4813;
alter table SAM_PUBLISHEDEVALUATION_T drop foreign key FK94CB245F9482C945;
alter table SAM_PUBLISHEDFEEDBACK_T drop foreign key FK1488D9E89482C945;
alter table SAM_PUBLISHEDITEMFEEDBACK_T drop foreign key FKB7D03A3B31446627;
alter table SAM_PUBLISHEDITEMMETADATA_T drop foreign key FKE0C2876531446627;
alter table SAM_PUBLISHEDITEMTEXT_T drop foreign key FK9C790A6331446627;
alter table SAM_PUBLISHEDITEM_T drop foreign key FK53ABDCF6895D4813;
alter table SAM_PUBLISHEDMETADATA_T drop foreign key FK3D7B27129482C945;
alter table SAM_PUBLISHEDSECTIONMETADATA_T drop foreign key FKDF50FC3B895D4813;
alter table SAM_PUBLISHEDSECTION_T drop foreign key FK424F87CC9482C945;
alter table SAM_PUBLISHEDSECUREDIP_T drop foreign key FK1EDEA25B9482C945;
alter table SAM_QUESTIONPOOLITEM_T drop foreign key FKF0FAAE2A39ED26BB;
alter table SAM_SECTIONMETADATA_T drop foreign key FK762AD74970CE2BD;
alter table SAM_SECTION_T drop foreign key FK364450DACAC2365B;
alter table SAM_SECUREDIP_T drop foreign key FKE8C55FE9694216CC;
drop table if exists SAM_ANSWERFEEDBACK_T;
drop table if exists SAM_ANSWER_T;
drop table if exists SAM_ASSESSACCESSCONTROL_T;
drop table if exists SAM_ASSESSEVALUATION_T;
drop table if exists SAM_ASSESSFEEDBACK_T;
drop table if exists SAM_ASSESSMENTBASE_T;
drop table if exists SAM_ASSESSMENTGRADING_T;
drop table if exists SAM_ASSESSMETADATA_T;
drop table if exists SAM_ATTACHMENT_T;
drop table if exists SAM_AUTHZDATA_T;
drop table if exists SAM_FUNCTIONDATA_T;
drop table if exists SAM_GRADINGSUMMARY_T;
drop table if exists SAM_ITEMFEEDBACK_T;
drop table if exists SAM_ITEMGRADING_T;
drop table if exists SAM_ITEMMETADATA_T;
drop table if exists SAM_ITEMTEXT_T;
drop table if exists SAM_ITEM_T;
drop table if exists SAM_MEDIA_T;
drop table if exists SAM_PUBLISHEDACCESSCONTROL_T;
drop table if exists SAM_PUBLISHEDANSWERFEEDBACK_T;
drop table if exists SAM_PUBLISHEDANSWER_T;
drop table if exists SAM_PUBLISHEDASSESSMENT_T;
drop table if exists SAM_PUBLISHEDATTACHMENT_T;
drop table if exists SAM_PUBLISHEDEVALUATION_T;
drop table if exists SAM_PUBLISHEDFEEDBACK_T;
drop table if exists SAM_PUBLISHEDITEMFEEDBACK_T;
drop table if exists SAM_PUBLISHEDITEMMETADATA_T;
drop table if exists SAM_PUBLISHEDITEMTEXT_T;
drop table if exists SAM_PUBLISHEDITEM_T;
drop table if exists SAM_PUBLISHEDMETADATA_T;
drop table if exists SAM_PUBLISHEDSECTIONMETADATA_T;
drop table if exists SAM_PUBLISHEDSECTION_T;
drop table if exists SAM_PUBLISHEDSECUREDIP_T;
drop table if exists SAM_QUALIFIERDATA_T;
drop table if exists SAM_QUESTIONPOOLACCESS_T;
drop table if exists SAM_QUESTIONPOOLITEM_T;
drop table if exists SAM_QUESTIONPOOL_T;
drop table if exists SAM_SECTIONMETADATA_T;
drop table if exists SAM_SECTION_T;
drop table if exists SAM_SECUREDIP_T;
drop table if exists SAM_STUDENTGRADINGSUMMARY_T;
drop table if exists SAM_TYPE_T;
create table SAM_ANSWERFEEDBACK_T (ANSWERFEEDBACKID bigint not null auto_increment, ANSWERID bigint not null, TYPEID varchar(255), TEXT text, primary key (ANSWERFEEDBACKID));
create table SAM_ANSWER_T (ANSWERID bigint not null auto_increment, ITEMTEXTID bigint not null, ITEMID bigint not null, TEXT text, SEQUENCE bigint not null, LABEL varchar(20), ISCORRECT bit, GRADE varchar(80), SCORE float, primary key (ANSWERID));
create table SAM_ASSESSACCESSCONTROL_T (ASSESSMENTID bigint not null, SUBMISSIONSALLOWED integer, UNLIMITEDSUBMISSIONS bit, SUBMISSIONSSAVED integer, ASSESSMENTFORMAT integer, BOOKMARKINGITEM integer, TIMELIMIT integer, TIMEDASSESSMENT integer, RETRYALLOWED integer, LATEHANDLING integer, STARTDATE datetime, DUEDATE datetime, SCOREDATE datetime, FEEDBACKDATE datetime, RETRACTDATE datetime, AUTOSUBMIT integer, ITEMNAVIGATION integer, ITEMNUMBERING integer, DISPLAYSCORE integer, SUBMISSIONMESSAGE text, RELEASETO varchar(255), USERNAME varchar(255), PASSWORD varchar(255), FINALPAGEURL text, primary key (ASSESSMENTID));
create table SAM_ASSESSEVALUATION_T (ASSESSMENTID bigint not null, EVALUATIONCOMPONENTS varchar(255), SCORINGTYPE integer, NUMERICMODELID varchar(255), FIXEDTOTALSCORE integer, GRADEAVAILABLE integer, ISSTUDENTIDPUBLIC integer, ANONYMOUSGRADING integer, AUTOSCORING integer, TOGRADEBOOK varchar(255), primary key (ASSESSMENTID));
create table SAM_ASSESSFEEDBACK_T (ASSESSMENTID bigint not null, FEEDBACKDELIVERY integer, FEEDBACKAUTHORING integer, EDITCOMPONENTS integer, SHOWQUESTIONTEXT bit, SHOWSTUDENTRESPONSE bit, SHOWCORRECTRESPONSE bit, SHOWSTUDENTSCORE bit, SHOWSTUDENTQUESTIONSCORE bit, SHOWQUESTIONLEVELFEEDBACK bit, SHOWSELECTIONLEVELFEEDBACK bit, SHOWGRADERCOMMENTS bit, SHOWSTATISTICS bit, primary key (ASSESSMENTID));
create table SAM_ASSESSMENTBASE_T (ID bigint not null auto_increment, isTemplate varchar(255) not null, PARENTID bigint, TITLE varchar(255), DESCRIPTION text, COMMENTS text, TYPEID bigint, INSTRUCTORNOTIFICATION integer, TESTEENOTIFICATION integer, MULTIPARTALLOWED integer, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, ASSESSMENTTEMPLATEID bigint, primary key (ID));
create table SAM_ASSESSMENTGRADING_T (ASSESSMENTGRADINGID bigint not null auto_increment, PUBLISHEDASSESSMENTID bigint not null, AGENTID varchar(255) not null, SUBMITTEDDATE datetime, ISLATE bit not null, FORGRADE bit not null, TOTALAUTOSCORE float, TOTALOVERRIDESCORE float, FINALSCORE float, COMMENTS text, GRADEDBY varchar(255), GRADEDDATE datetime, STATUS integer not null, ATTEMPTDATE datetime, TIMEELAPSED integer, primary key (ASSESSMENTGRADINGID));
create table SAM_ASSESSMETADATA_T (ASSESSMENTMETADATAID bigint not null auto_increment, ASSESSMENTID bigint not null, LABEL varchar(255) not null, ENTRY varchar(255), primary key (ASSESSMENTMETADATAID));
create table SAM_ATTACHMENT_T (ATTACHMENTID bigint not null auto_increment, ATTACHMENTTYPE varchar(255) not null, RESOURCEID varchar(255), FILENAME varchar(255), MIMETYPE varchar(80), FILESIZE bigint, DESCRIPTION text, LOCATION text, ISLINK bit, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, ASSESSMENTID bigint, SECTIONID bigint, ITEMID bigint, primary key (ATTACHMENTID));
create table SAM_AUTHZDATA_T (ID bigint not null auto_increment, lockId integer not null, AGENTID varchar(255) not null, FUNCTIONID varchar(36) not null, QUALIFIERID varchar(36) not null, EFFECTIVEDATE date, EXPIRATIONDATE date, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE date not null, ISEXPLICIT bit, primary key (ID), unique (AGENTID, FUNCTIONID, QUALIFIERID));
create table SAM_FUNCTIONDATA_T (FUNCTIONID bigint not null auto_increment, REFERENCENAME varchar(255) not null, DISPLAYNAME varchar(255), DESCRIPTION text, FUNCTIONTYPEID text, primary key (FUNCTIONID));
create table SAM_GRADINGSUMMARY_T (ASSESSMENTGRADINGSUMMARYID bigint not null auto_increment, PUBLISHEDASSESSMENTID bigint not null, AGENTID varchar(255) not null, TOTALSUBMITTED integer, TOTALSUBMITTEDFORGRADE integer, LASTSUBMITTEDDATE datetime, LASTSUBMITTEDASSESSMENTISLATE bit not null, SUMOF_AUTOSCOREFORGRADE float, AVERAGE_AUTOSCOREFORGRADE float, HIGHEST_AUTOSCOREFORGRADE float, LOWEST_AUTOSCOREFORGRADE float, LAST_AUTOSCOREFORGRADE float, SUMOF_OVERRIDESCOREFORGRADE float, AVERAGE_OVERRIDESCOREFORGRADE float, HIGHEST_OVERRIDESCOREFORGRADE float, LOWEST_OVERRIDESCOREFORGRADE float, LAST_OVERRIDESCOREFORGRADE float, SCORINGTYPE integer, ACCEPTEDASSESSMENTISLATE bit, FINALASSESSMENTSCORE float, FEEDTOGRADEBOOK bit, primary key (ASSESSMENTGRADINGSUMMARYID));
create table SAM_ITEMFEEDBACK_T (ITEMFEEDBACKID bigint not null auto_increment, ITEMID bigint not null, TYPEID varchar(255) not null, TEXT text, primary key (ITEMFEEDBACKID));
create table SAM_ITEMGRADING_T (ITEMGRADINGID bigint not null auto_increment, ASSESSMENTGRADINGID bigint not null, PUBLISHEDITEMID bigint not null, PUBLISHEDITEMTEXTID bigint not null, AGENTID varchar(255) not null, SUBMITTEDDATE datetime, PUBLISHEDANSWERID bigint, RATIONALE text, ANSWERTEXT text, AUTOSCORE float, OVERRIDESCORE float, COMMENTS text, GRADEDBY varchar(255), GRADEDDATE datetime, REVIEW bit, ATTEMPTSREMAINING integer, LASTDURATION varchar(36), primary key (ITEMGRADINGID));
create table SAM_ITEMMETADATA_T (ITEMMETADATAID bigint not null auto_increment, ITEMID bigint not null, LABEL varchar(255) not null, ENTRY varchar(255), primary key (ITEMMETADATAID));
create table SAM_ITEMTEXT_T (ITEMTEXTID bigint not null auto_increment, ITEMID bigint not null, SEQUENCE bigint not null, TEXT text, primary key (ITEMTEXTID));
create table SAM_ITEM_T (ITEMID bigint not null auto_increment, SECTIONID bigint, ITEMIDSTRING varchar(255), SEQUENCE integer, DURATION integer, TRIESALLOWED integer, INSTRUCTION text, DESCRIPTION text, TYPEID bigint not null, GRADE varchar(80), SCORE float, HINT text, HASRATIONALE bit, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, primary key (ITEMID));
create table SAM_MEDIA_T (MEDIAID bigint not null auto_increment, ITEMGRADINGID bigint, MEDIA longblob, FILESIZE bigint, MIMETYPE varchar(80), DESCRIPTION text, LOCATION varchar(255), FILENAME varchar(255), ISLINK bit, ISHTMLINLINE bit, STATUS integer, CREATEDBY varchar(255), CREATEDDATE datetime, LASTMODIFIEDBY varchar(255), LASTMODIFIEDDATE datetime, DURATION varchar(36), primary key (MEDIAID));
create table SAM_PUBLISHEDACCESSCONTROL_T (ASSESSMENTID bigint not null, UNLIMITEDSUBMISSIONS bit, SUBMISSIONSALLOWED integer, SUBMISSIONSSAVED integer, ASSESSMENTFORMAT integer, BOOKMARKINGITEM integer, TIMELIMIT integer, TIMEDASSESSMENT integer, RETRYALLOWED integer, LATEHANDLING integer, STARTDATE datetime, DUEDATE datetime, SCOREDATE datetime, FEEDBACKDATE datetime, RETRACTDATE datetime, AUTOSUBMIT integer, ITEMNAVIGATION integer, ITEMNUMBERING integer, SUBMISSIONMESSAGE text, RELEASETO varchar(255), USERNAME varchar(255), PASSWORD varchar(255), FINALPAGEURL text, primary key (ASSESSMENTID));
create table SAM_PUBLISHEDANSWERFEEDBACK_T (ANSWERFEEDBACKID bigint not null auto_increment, ANSWERID bigint not null, TYPEID varchar(255), TEXT text, primary key (ANSWERFEEDBACKID));
create table SAM_PUBLISHEDANSWER_T (ANSWERID bigint not null auto_increment, ITEMTEXTID bigint not null, ITEMID bigint not null, TEXT text, SEQUENCE bigint not null, LABEL varchar(20), ISCORRECT bit, GRADE varchar(80), SCORE float, primary key (ANSWERID));
create table SAM_PUBLISHEDASSESSMENT_T (ID bigint not null auto_increment, TITLE varchar(255), ASSESSMENTID bigint, DESCRIPTION text, COMMENTS varchar(255), TYPEID bigint, INSTRUCTORNOTIFICATION integer, TESTEENOTIFICATION integer, MULTIPARTALLOWED integer, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, primary key (ID));
create table SAM_PUBLISHEDATTACHMENT_T (ATTACHMENTID bigint not null auto_increment, ATTACHMENTTYPE varchar(255) not null, RESOURCEID varchar(255), FILENAME varchar(255), MIMETYPE varchar(80), FILESIZE bigint, DESCRIPTION text, LOCATION text, ISLINK bit, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, ASSESSMENTID bigint, SECTIONID bigint, ITEMID bigint, primary key (ATTACHMENTID));
create table SAM_PUBLISHEDEVALUATION_T (ASSESSMENTID bigint not null, EVALUATIONCOMPONENTS varchar(255), SCORINGTYPE integer, NUMERICMODELID varchar(255), FIXEDTOTALSCORE integer, GRADEAVAILABLE integer, ISSTUDENTIDPUBLIC integer, ANONYMOUSGRADING integer, AUTOSCORING integer, TOGRADEBOOK varchar(255), primary key (ASSESSMENTID));
create table SAM_PUBLISHEDFEEDBACK_T (ASSESSMENTID bigint not null, FEEDBACKDELIVERY integer, FEEDBACKAUTHORING integer, EDITCOMPONENTS integer, SHOWQUESTIONTEXT bit, SHOWSTUDENTRESPONSE bit, SHOWCORRECTRESPONSE bit, SHOWSTUDENTSCORE bit, SHOWSTUDENTQUESTIONSCORE bit, SHOWQUESTIONLEVELFEEDBACK bit, SHOWSELECTIONLEVELFEEDBACK bit, SHOWGRADERCOMMENTS bit, SHOWSTATISTICS bit, primary key (ASSESSMENTID));
create table SAM_PUBLISHEDITEMFEEDBACK_T (ITEMFEEDBACKID bigint not null auto_increment, ITEMID bigint not null, TYPEID varchar(255) not null, TEXT text, primary key (ITEMFEEDBACKID));
create table SAM_PUBLISHEDITEMMETADATA_T (ITEMMETADATAID bigint not null auto_increment, ITEMID bigint not null, LABEL varchar(255) not null, ENTRY varchar(255), primary key (ITEMMETADATAID));
create table SAM_PUBLISHEDITEMTEXT_T (ITEMTEXTID bigint not null auto_increment, ITEMID bigint not null, SEQUENCE bigint not null, TEXT text, primary key (ITEMTEXTID));
create table SAM_PUBLISHEDITEM_T (ITEMID bigint not null auto_increment, SECTIONID bigint not null, ITEMIDSTRING varchar(255), SEQUENCE integer, DURATION integer, TRIESALLOWED integer, INSTRUCTION text, DESCRIPTION text, TYPEID bigint not null, GRADE varchar(80), SCORE float, HINT text, HASRATIONALE bit, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, primary key (ITEMID));
create table SAM_PUBLISHEDMETADATA_T (ASSESSMENTMETADATAID bigint not null auto_increment, ASSESSMENTID bigint not null, LABEL varchar(255) not null, ENTRY varchar(255), primary key (ASSESSMENTMETADATAID));
create table SAM_PUBLISHEDSECTIONMETADATA_T (PUBLISHEDSECTIONMETADATAID bigint not null auto_increment, SECTIONID bigint not null, LABEL varchar(255) not null, ENTRY varchar(255), primary key (PUBLISHEDSECTIONMETADATAID));
create table SAM_PUBLISHEDSECTION_T (SECTIONID bigint not null auto_increment, ASSESSMENTID bigint not null, DURATION integer, SEQUENCE integer, TITLE varchar(255), DESCRIPTION text, TYPEID bigint not null, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, primary key (SECTIONID));
create table SAM_PUBLISHEDSECUREDIP_T (IPADDRESSID bigint not null auto_increment, ASSESSMENTID bigint not null, HOSTNAME varchar(255), IPADDRESS varchar(255), primary key (IPADDRESSID));
create table SAM_QUALIFIERDATA_T (QUALIFIERID bigint not null, REFERENCENAME varchar(255) not null, DISPLAYNAME varchar(255), DESCRIPTION text, QUALIFIERTYPEID text, primary key (QUALIFIERID));
create table SAM_QUESTIONPOOLACCESS_T (QUESTIONPOOLID bigint not null, AGENTID varchar(255) not null, ACCESSTYPEID bigint not null, primary key (QUESTIONPOOLID, AGENTID, ACCESSTYPEID));
create table SAM_QUESTIONPOOLITEM_T (QUESTIONPOOLID bigint not null, ITEMID varchar(255) not null, primary key (QUESTIONPOOLID, ITEMID));
create table SAM_QUESTIONPOOL_T (QUESTIONPOOLID bigint not null auto_increment, TITLE varchar(255), DESCRIPTION varchar(255), PARENTPOOLID bigint, OWNERID varchar(255), ORGANIZATIONNAME varchar(255), DATECREATED datetime, LASTMODIFIEDDATE datetime, LASTMODIFIEDBY varchar(255), DEFAULTACCESSTYPEID bigint, OBJECTIVE varchar(255), KEYWORDS varchar(255), RUBRIC text, TYPEID bigint, INTELLECTUALPROPERTYID bigint, primary key (QUESTIONPOOLID));
create table SAM_SECTIONMETADATA_T (SECTIONMETADATAID bigint not null auto_increment, SECTIONID bigint not null, LABEL varchar(255) not null, ENTRY varchar(255), primary key (SECTIONMETADATAID));
create table SAM_SECTION_T (SECTIONID bigint not null auto_increment, ASSESSMENTID bigint not null, DURATION integer, SEQUENCE integer, TITLE varchar(255), DESCRIPTION text, TYPEID bigint, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, primary key (SECTIONID));
create table SAM_SECUREDIP_T (IPADDRESSID bigint not null auto_increment, ASSESSMENTID bigint not null, HOSTNAME varchar(255), IPADDRESS varchar(255), primary key (IPADDRESSID));
create table SAM_STUDENTGRADINGSUMMARY_T (STUDENTGRADINGSUMMARYID bigint not null auto_increment, PUBLISHEDASSESSMENTID bigint not null, AGENTID varchar(255) not null, NUMBERRETAKE integer, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, primary key (STUDENTGRADINGSUMMARYID));
create table SAM_TYPE_T (TYPEID bigint not null auto_increment, AUTHORITY varchar(255), DOMAIN varchar(255), KEYWORD varchar(255), DESCRIPTION text, STATUS integer not null, CREATEDBY varchar(255) not null, CREATEDDATE datetime not null, LASTMODIFIEDBY varchar(255) not null, LASTMODIFIEDDATE datetime not null, primary key (TYPEID));
alter table SAM_ANSWERFEEDBACK_T add index FK58CEF0D8DEC85889 (ANSWERID), add constraint FK58CEF0D8DEC85889 foreign key (ANSWERID) references SAM_ANSWER_T (ANSWERID);
alter table SAM_ANSWER_T add index FKDD0580933288DBBD (ITEMID), add constraint FKDD0580933288DBBD foreign key (ITEMID) references SAM_ITEM_T (ITEMID);
alter table SAM_ANSWER_T add index FKDD058093278A7DAD (ITEMTEXTID), add constraint FKDD058093278A7DAD foreign key (ITEMTEXTID) references SAM_ITEMTEXT_T (ITEMTEXTID);
alter table SAM_ASSESSACCESSCONTROL_T add index FKC945448A694216CC (ASSESSMENTID), add constraint FKC945448A694216CC foreign key (ASSESSMENTID) references SAM_ASSESSMENTBASE_T (ID);
alter table SAM_ASSESSEVALUATION_T add index FK6A6F29F5694216CC (ASSESSMENTID), add constraint FK6A6F29F5694216CC foreign key (ASSESSMENTID) references SAM_ASSESSMENTBASE_T (ID);
alter table SAM_ASSESSFEEDBACK_T add index FK557D4CFE694216CC (ASSESSMENTID), add constraint FK557D4CFE694216CC foreign key (ASSESSMENTID) references SAM_ASSESSMENTBASE_T (ID);
create index SAM_PUBLISHEDASSESSMENT_I on SAM_ASSESSMENTGRADING_T (PUBLISHEDASSESSMENTID);
alter table SAM_ASSESSMETADATA_T add index FK7E6F9A28694216CC (ASSESSMENTID), add constraint FK7E6F9A28694216CC foreign key (ASSESSMENTID) references SAM_ASSESSMENTBASE_T (ID);
alter table SAM_ATTACHMENT_T add index FK99FA8CB8CAC2365B (ASSESSMENTID), add constraint FK99FA8CB8CAC2365B foreign key (ASSESSMENTID) references SAM_ASSESSMENTBASE_T (ID);
alter table SAM_ATTACHMENT_T add index FK99FA8CB83288DBBD (ITEMID), add constraint FK99FA8CB83288DBBD foreign key (ITEMID) references SAM_ITEM_T (ITEMID);
alter table SAM_ATTACHMENT_T add index FK99FA8CB870CE2BD (SECTIONID), add constraint FK99FA8CB870CE2BD foreign key (SECTIONID) references SAM_SECTION_T (SECTIONID);
create index sam_authz_functionId_idx on SAM_AUTHZDATA_T (FUNCTIONID);
create index sam_authz_qualifierId_idx on SAM_AUTHZDATA_T (QUALIFIERID);
alter table SAM_GRADINGSUMMARY_T add index FKBC88AA27D02EF633 (PUBLISHEDASSESSMENTID), add constraint FKBC88AA27D02EF633 foreign key (PUBLISHEDASSESSMENTID) references SAM_PUBLISHEDASSESSMENT_T (ID);
alter table SAM_ITEMFEEDBACK_T add index FK3254E9ED3288DBBD (ITEMID), add constraint FK3254E9ED3288DBBD foreign key (ITEMID) references SAM_ITEM_T (ITEMID);
create index SAM_ITEMGRADING_PUBANS_I on SAM_ITEMGRADING_T (PUBLISHEDANSWERID);
create index SAM_ITEMGRADING_ITEM_I on SAM_ITEMGRADING_T (PUBLISHEDITEMID);
create index SAM_ITEMGRADING_ITEMTEXT_I on SAM_ITEMGRADING_T (PUBLISHEDITEMTEXTID);
alter table SAM_ITEMGRADING_T add index FKB68E675667B430D5 (ASSESSMENTGRADINGID), add constraint FKB68E675667B430D5 foreign key (ASSESSMENTGRADINGID) references SAM_ASSESSMENTGRADING_T (ASSESSMENTGRADINGID);
alter table SAM_ITEMMETADATA_T add index FK5B4737173288DBBD (ITEMID), add constraint FK5B4737173288DBBD foreign key (ITEMID) references SAM_ITEM_T (ITEMID);
alter table SAM_ITEMTEXT_T add index FK271D63153288DBBD (ITEMID), add constraint FK271D63153288DBBD foreign key (ITEMID) references SAM_ITEM_T (ITEMID);
alter table SAM_ITEM_T add index FK3AAC5EA870CE2BD (SECTIONID), add constraint FK3AAC5EA870CE2BD foreign key (SECTIONID) references SAM_SECTION_T (SECTIONID);
alter table SAM_MEDIA_T add index FKD4CF5A194D7EA7B3 (ITEMGRADINGID), add constraint FKD4CF5A194D7EA7B3 foreign key (ITEMGRADINGID) references SAM_ITEMGRADING_T (ITEMGRADINGID);
alter table SAM_PUBLISHEDACCESSCONTROL_T add index FK2EDF39E09482C945 (ASSESSMENTID), add constraint FK2EDF39E09482C945 foreign key (ASSESSMENTID) references SAM_PUBLISHEDASSESSMENT_T (ID);
alter table SAM_PUBLISHEDANSWERFEEDBACK_T add index FK6CB765A624D77573 (ANSWERID), add constraint FK6CB765A624D77573 foreign key (ANSWERID) references SAM_PUBLISHEDANSWER_T (ANSWERID);
alter table SAM_PUBLISHEDANSWER_T add index FKB41EA36131446627 (ITEMID), add constraint FKB41EA36131446627 foreign key (ITEMID) references SAM_PUBLISHEDITEM_T (ITEMID);
alter table SAM_PUBLISHEDANSWER_T add index FKB41EA36126460817 (ITEMTEXTID), add constraint FKB41EA36126460817 foreign key (ITEMTEXTID) references SAM_PUBLISHEDITEMTEXT_T (ITEMTEXTID);
create index SAM_PUBA_ASSESSMENT_I on SAM_PUBLISHEDASSESSMENT_T (ASSESSMENTID);
alter table SAM_PUBLISHEDATTACHMENT_T add index FK270998869482C945 (ASSESSMENTID), add constraint FK270998869482C945 foreign key (ASSESSMENTID) references SAM_PUBLISHEDASSESSMENT_T (ID);
alter table SAM_PUBLISHEDATTACHMENT_T add index FK2709988631446627 (ITEMID), add constraint FK2709988631446627 foreign key (ITEMID) references SAM_PUBLISHEDITEM_T (ITEMID);
alter table SAM_PUBLISHEDATTACHMENT_T add index FK27099886895D4813 (SECTIONID), add constraint FK27099886895D4813 foreign key (SECTIONID) references SAM_PUBLISHEDSECTION_T (SECTIONID);
alter table SAM_PUBLISHEDEVALUATION_T add index FK94CB245F9482C945 (ASSESSMENTID), add constraint FK94CB245F9482C945 foreign key (ASSESSMENTID) references SAM_PUBLISHEDASSESSMENT_T (ID);
alter table SAM_PUBLISHEDFEEDBACK_T add index FK1488D9E89482C945 (ASSESSMENTID), add constraint FK1488D9E89482C945 foreign key (ASSESSMENTID) references SAM_PUBLISHEDASSESSMENT_T (ID);
alter table SAM_PUBLISHEDITEMFEEDBACK_T add index FKB7D03A3B31446627 (ITEMID), add constraint FKB7D03A3B31446627 foreign key (ITEMID) references SAM_PUBLISHEDITEM_T (ITEMID);
alter table SAM_PUBLISHEDITEMMETADATA_T add index FKE0C2876531446627 (ITEMID), add constraint FKE0C2876531446627 foreign key (ITEMID) references SAM_PUBLISHEDITEM_T (ITEMID);
alter table SAM_PUBLISHEDITEMTEXT_T add index FK9C790A6331446627 (ITEMID), add constraint FK9C790A6331446627 foreign key (ITEMID) references SAM_PUBLISHEDITEM_T (ITEMID);
alter table SAM_PUBLISHEDITEM_T add index FK53ABDCF6895D4813 (SECTIONID), add constraint FK53ABDCF6895D4813 foreign key (SECTIONID) references SAM_PUBLISHEDSECTION_T (SECTIONID);
alter table SAM_PUBLISHEDMETADATA_T add index FK3D7B27129482C945 (ASSESSMENTID), add constraint FK3D7B27129482C945 foreign key (ASSESSMENTID) references SAM_PUBLISHEDASSESSMENT_T (ID);
alter table SAM_PUBLISHEDSECTIONMETADATA_T add index FKDF50FC3B895D4813 (SECTIONID), add constraint FKDF50FC3B895D4813 foreign key (SECTIONID) references SAM_PUBLISHEDSECTION_T (SECTIONID);
alter table SAM_PUBLISHEDSECTION_T add index FK424F87CC9482C945 (ASSESSMENTID), add constraint FK424F87CC9482C945 foreign key (ASSESSMENTID) references SAM_PUBLISHEDASSESSMENT_T (ID);
alter table SAM_PUBLISHEDSECUREDIP_T add index FK1EDEA25B9482C945 (ASSESSMENTID), add constraint FK1EDEA25B9482C945 foreign key (ASSESSMENTID) references SAM_PUBLISHEDASSESSMENT_T (ID);
alter table SAM_QUESTIONPOOLITEM_T add index FKF0FAAE2A39ED26BB (QUESTIONPOOLID), add constraint FKF0FAAE2A39ED26BB foreign key (QUESTIONPOOLID) references SAM_QUESTIONPOOL_T (QUESTIONPOOLID);
create index SAM_QPOOL_OWNER_I on SAM_QUESTIONPOOL_T (OWNERID);
alter table SAM_SECTIONMETADATA_T add index FK762AD74970CE2BD (SECTIONID), add constraint FK762AD74970CE2BD foreign key (SECTIONID) references SAM_SECTION_T (SECTIONID);
alter table SAM_SECTION_T add index FK364450DACAC2365B (ASSESSMENTID), add constraint FK364450DACAC2365B foreign key (ASSESSMENTID) references SAM_ASSESSMENTBASE_T (ID);
alter table SAM_SECUREDIP_T add index FKE8C55FE9694216CC (ASSESSMENTID), add constraint FKE8C55FE9694216CC foreign key (ASSESSMENTID) references SAM_ASSESSMENTBASE_T (ID);
create index SAM_PUBLISHEDASSESSMENT2_I on SAM_STUDENTGRADINGSUMMARY_T (PUBLISHEDASSESSMENTID);
