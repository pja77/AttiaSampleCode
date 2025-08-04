
options dlcreatedir;
options COMPRESS = yes;
/***** File Name: ALL Dose Import Code v2020Apr05 *****/
/***** Last Update Date/Time: 2021Feb19 - 741PM **********/
/***** Purpose: Importing JSA/SPC/TLC Dosing AND Episode Data into SAS for analysis ****/
/***** Programmer: Peter Attia ****/

%let ImportDate = %sysfunc(today(), yymmdd10.);  /* Enter the Import Date (this should be the name of the folder, and will be the name of any external reports */
%let ImportTime=%sysfunc(compress(%sysfunc(TIME(),timeampm7.),%str( :)));
/** The sysuserid option in the SAS Macro Utility allows for the program to pull the Computer User ID of the 
logged in user on the computer, and will output your NetID. You must have the owncloud client installed on your computer
and designate that the ownCloud Directory be put into C:\users\RU NETID\ownCloud (The default setting) *******/



%LET Directory = C:\Users\&sysuserid.\Rutgers University\SHWeiss Research Group - Data Extraction\ALL SAS Libraries\METHADOS - C16NJ;
%LET Directory2 = C:\Users\&sysuserid.\Methados - Individual Files;

libname METHADOS "&Directory.";
libname TEMPFILE "&Directory2.";



/*** Created this so I can put output into one folder, rather than have it all scattered. ***/
%LET ExportDIr = C:\Users\&sysuserid.\Rutgers University\SHWeiss Research Group - Data Extraction\MDD Output;
libname TEXPORT "&ExportDir.\&ImportDate.";
libname TEXPORT clear;

proc datasets library = METHADOS KILL;
QUIT;


option spool;

/******* Every time you run this program, the main datasets will delete since PROC APPEND is used and will result in 
having duplicate observations ***********/

/*** Adding in the extraction dates so we can ensure that dates are accurate to date of extraction ****/

proc import datafile = "C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\ALL SAS Libraries\METHADOS - C16NJ/Dates to Import v2021Sep30.xlsx" 
	out = METHADOS.datatomerge DBMS = xlsx REPLACE;
run;

proc sort data = METHADOS.datatomerge;
	by ID;
run;


proc sort data = METHADOS.datatomerge;
	by Dose_PATIENTID;
run;

PROC IMPORT OUT=METHADOS.import_TLC_new
   DATAFILE="C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\TLC Data/TLC_ScriptHistory_import.xlsx" 
	DBMS=XLSX REPLACE;
	GETNAMES=YES;
	DATAROW=2;
RUN;


	
data METHADOS.import_TLC;
		set METHADOS.import_TLC_new end = eof;
		FORMAT Dose_StartDate Dose_endDate MMDDYY10.;
		Dose_SEQNUM=INPUT(SEQNUM,20.);
		Dose_PATIENTID=INPUT(PATIENTID,20.);
		Dose_EPISODESEQNUM=INPUT(EPISODESEQNUM,20.);
		Dose_SCRIPTTYPEID=INPUT(SCRIPTTYPEID,$20.);
		Dose_DOCTORID=INPUT(DOCTORID,$20.);
		Dose_ENTEREDBYID=INPUT(ENTEREDBYID,$20.);
		Dose_POSTEDBYID=INPUT(POSTEDBYID,$20.);
		Dose_DOSAGE=INPUT(DOSAGE,20.);
		Dose_TWODAYDOSAGE=INPUT(TWODAYDOSAGE,20.);
		Dose_THREEDAYDOSAGE=INPUT(THREEDAYDOSAGE,20.);
		Dose_FOURDAYDOSAGE=INPUT(FOURDAYDOSAGE,20.);
		If SPLITFIRSTDOSAGE = "null" then Dose_SPLITFIRSTDOSAGE = .N;
			else Dose_SPLITFIRSTDOSAGE=INPUT(SPLITFIRSTDOSAGE,20.);
		Dose_SPLITISTAKEHOMEFLAG=INPUT(SPLITISTAKEHOMEFLAG,$20.);
		Dose_TAKEHOME=INPUT(TAKEHOME,$20.);
		Dose_AWLTYPEID=INPUT(AWLTYPEID,$20.);
		If TAKEHOMESUPPLY  = "null" then Dose_TAKEHOMESUPPLY = .N;
			else Dose_TAKEHOMESUPPLY=INPUT(TAKEHOMESUPPLY,20.);
		Dose_POSTEDFLAG=INPUT(POSTEDFLAG,$20.);
		If DAYSINCYCLE  = "null" then Dose_DAYSINCYCLE = .N;
			else Dose_DAYSINCYCLE=INPUT(DAYSINCYCLE,20.);
		Dose_DETOXFLAG=INPUT(DETOXFLAG,$20.);
		Dose_FINANCIALFLAG=INPUT(FINANCIALFLAG,$20.);
		Dose_STARTAT=INPUT(STARTAT,20.);
		Dose_STARTATPERCENTAGEFLAG=INPUT(STARTATPERCENTAGEFLAG,$20.);
		Dose_STOPAT=INPUT(STOPAT,20.);
		Dose_STOPATPERCENTAGEFLAG=INPUT(STOPATPERCENTAGEFLAG,$20.);
		Dose_BYPERCENTAGESFLAG=INPUT(BYPERCENTAGESFLAG,$20.);
		Dose_INCREMENT1=INPUT(INCREMENT1,20.);
		Dose_INCREMENT2=INPUT(INCREMENT2,20.);
		Dose_INCREMENT3=INPUT(INCREMENT3,20.);
		Dose_INCREMENT4=INPUT(INCREMENT4,20.);
		Dose_INCREMENT5=INPUT(INCREMENT5,20.);
		Dose_INCREMENT6=INPUT(INCREMENT6,20.);
		Dose_INCREMENT7=INPUT(INCREMENT7,20.);
		Dose_INCREMENT8=INPUT(INCREMENT8,20.);
		Dose_INCREMENT9=INPUT(INCREMENT9,20.);
		Dose_INCREMENT10=INPUT(INCREMENT10,20.);
		Dose_INCREMENT11=INPUT(INCREMENT11,20.);
		Dose_INCREMENT12=INPUT(INCREMENT12,20.);
		Dose_INCREMENT13=INPUT(INCREMENT13,20.);
		Dose_INCREMENT14=INPUT(INCREMENT14,20.);
		Dose_INCREMENT15=INPUT(INCREMENT15,20.);
		Dose_INCREMENT16=INPUT(INCREMENT16,20.);
		Dose_INCREMENT17=INPUT(INCREMENT17,20.);
		Dose_INCREMENT18=INPUT(INCREMENT18,20.);
		Dose_INCREMENT19=INPUT(INCREMENT19,20.);
		Dose_INCREMENT20=INPUT(INCREMENT20,20.);
		Dose_INCREMENT21=INPUT(INCREMENT21,20.);
		Dose_INCREMENT22=INPUT(INCREMENT22,20.);
		Dose_INCREMENT23=INPUT(INCREMENT23,20.);
		Dose_INCREMENT24=INPUT(INCREMENT24,20.);
		Dose_INCREMENT25=INPUT(INCREMENT25,20.);
		Dose_INCREMENT26=INPUT(INCREMENT26,20.);
		Dose_INCREMENT27=INPUT(INCREMENT27,20.);
		Dose_INCREMENT28=INPUT(INCREMENT28,20.);
		Dose_INCREMENT29=INPUT(INCREMENT29,20.);
		Dose_INCREMENT30=INPUT(INCREMENT30,20.);
		Dose_NURSESIGNATURESEQNUM=INPUT(NURSESIGNATURESEQNUM,$20.);
		Dose_DOCTORSIGNATURESEQNUM=INPUT(DOCTORSIGNATURESEQNUM,$20.);
		Dose_CANCELLEDBYID=INPUT(CANCELLEDBYID,$20.);
		Dose_MEDICALNOTE=INPUT(MEDICALNOTE,$1000.);
		Dose_AMENDMENT=INPUT(AMENDMENT,$20.);
		Dose_AMENDSIGNATURESEQNUM=INPUT(AMENDSIGNATURESEQNUM,$20.);
		Dose_INCREMENTSCHEDULETYPE=INPUT(INCREMENTSCHEDULETYPE,$20.);
		Dose_INCSCHEDULEREASON=INPUT(INCSCHEDULEREASON,$20.);
		Dose_NUMOFALLOWEDTKHAFTERHOL=INPUT(NUMOFALLOWEDTKHAFTERHOL,$20.);
		Dose_WHENPRINTED=INPUT(WHENPRINTED,$20.);
		Dose_FIRSTORDERFLAG=INPUT(FIRSTORDERFLAG,$20.);
		Dose_DRFIRSTID=INPUT(DRFIRSTID,$20.);
		Dose_ISPICKUPONCLINICCLOSEDFLAG=INPUT(ISPICKUPONCLINICCLOSEDFLAG,$20.);
		Dose_MEDICATIONID=INPUT(MEDICATIONID,$100.);


		/** if ScriptStarts EQ "null" OR ScriptStarts EQ "NULL" then Dose_StartDate=.M;
		else do;
			ScriptStart_temp1 = INT(INPUT(ScriptStarts,10.));
			Dose_StartDate = ScriptStart_temp1 - 21916;
		end; **/

		Dose_StartDate = ScriptStarts;

		if ScriptExpires EQ "null" OR ScriptExpires EQ "NULL" then Dose_EndDate=.M;
		else do;
			ScriptExpires_temp1 = INT(INPUT(ScriptExpires,10.));
			Dose_EndDate = ScriptExpires_temp1 - 21916;
		end;
		/** CORRECTION 3-14-19: Change end dates if missing AND EOF to current date of extraction - assigned to Dec 31 2018 **/

		*if Dose_EndDate = . and eof then Dose_EndDate = "31Dec2018"D;
		
				
		/** When Canelled occurs if before the start of the observation, a physician cancels it and it no longer
		goes into effect **/

		if WHENCANCELLED EQ "null" OR WHENCANCELLED EQ "NULL" then Dose_WhenCancelled=.N;
		else do;
			WHENCANCELLED_temp1 = INT(INPUT(WHENCANCELLED,10.));
			Dose_WhenCancelled = WHENCANCELLED_temp1 - 21916;
		end;
		/*** SAS will import dummy obs sometimes, so just delete that observation because if there isn't
		a Dose_SeqNum there is no record ***/
		if Dose_SeqNum = . THEN DELETE; 

		keep Dose_SEQNUM    
			Dose_PATIENTID    
			Dose_EPISODESEQNUM    
			Dose_SCRIPTTYPEID    
			Dose_DOCTORID    
			Dose_ENTEREDBYID    
			Dose_POSTEDBYID    
			Dose_DOSAGE    
			Dose_TWODAYDOSAGE    
			Dose_THREEDAYDOSAGE    
			Dose_FOURDAYDOSAGE    
			Dose_SPLITFIRSTDOSAGE    
			Dose_SPLITISTAKEHOMEFLAG    
			Dose_TAKEHOME    
			Dose_AWLTYPEID    
			Dose_TAKEHOMESUPPLY    
			Dose_POSTEDFLAG    
			Dose_DAYSINCYCLE    
			Dose_DETOXFLAG    
			Dose_FINANCIALFLAG    
			Dose_STARTAT    
			Dose_STARTATPERCENTAGEFLAG    
			Dose_STOPAT    
			Dose_STOPATPERCENTAGEFLAG    
			Dose_BYPERCENTAGESFLAG    
			Dose_INCREMENT1
			Dose_INCREMENT2    
			Dose_INCREMENT3    
			Dose_INCREMENT4    
			Dose_INCREMENT5    
			Dose_INCREMENT6    
			Dose_INCREMENT7    
			Dose_INCREMENT8    
			Dose_INCREMENT9    
			Dose_INCREMENT10    
			Dose_INCREMENT11    
			Dose_INCREMENT12    
			Dose_INCREMENT13    
			Dose_INCREMENT14    
			Dose_INCREMENT15    
			Dose_INCREMENT16    
			Dose_INCREMENT17    
			Dose_INCREMENT18    
			Dose_INCREMENT19    
			Dose_INCREMENT20    
			Dose_INCREMENT21    
			Dose_INCREMENT22    
			Dose_INCREMENT23    
			Dose_INCREMENT24    
			Dose_INCREMENT25    
			Dose_INCREMENT26    
			Dose_INCREMENT27    
			Dose_INCREMENT28    
			Dose_INCREMENT29    
			Dose_INCREMENT30    
			Dose_NURSESIGNATURESEQNUM    
			Dose_DOCTORSIGNATURESEQNUM    
			Dose_CANCELLEDBYID    
			Dose_MEDICALNOTE                                                          
			Dose_AMENDMENT    
			Dose_AMENDSIGNATURESEQNUM    
			Dose_INCREMENTSCHEDULETYPE    
			Dose_INCSCHEDULEREASON    
			Dose_NUMOFALLOWEDTKHAFTERHOL    
			Dose_WHENPRINTED              
			Dose_FIRSTORDERFLAG    
			Dose_DRFIRSTID    
			Dose_ISPICKUPONCLINICCLOSEDFLAG    
			Dose_MEDICATIONID
			Dose_StartDate
			Dose_EndDate
			Dose_WhenCancelled;
	run; 
	

proc sort data = METHADOS.import_TLC;
		by Dose_PATIENTID;
run;

data METHADOS.datatomerge_tlc;
	set METHADOS.datatomerge;

	if ID =: "TLC" or ID =: "NIA" or ID =: "ESS";
run;

proc sort data = METHADOS.datatomerge_tlc;
	by Dose_PatientID;
run;

data METHADOS.import_TLC_merged;
		merge METHADOS.datatomerge_tlc METHADOS.import_TLC;
		by Dose_PATIENTID;
		
		if ID =: "TLC" and Dose_PatientID = . then do;
			PUTLOG "The following ID number is not in this database: " ID " and there for will be deleted in this database.";
			delete;
		end;
		if ID =: "SPC" OR ID =: "JSA" then DELETE;
run;
		

PROC IMPORT OUT=METHADOS.Episodes_TLC
		DATAFILE="C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\TLC Data/TLC_Episodes_import.xlsx" 
		DBMS=XLSX REPLACE;
		GETNAMES=YES;
RUN;
	
proc contents data = METHADOS.episodes_TLC;
run;
	/** STEP1: Import all the variables into SAS, and account for Datesm **/
data METHADOS.Episodes_TLC;
		FORMAT Episodes_DateAdmit Episodes_DateDischarge MMDDYY10.;
		set METHADOS.Episodes_TLC;
		*Dose_EpisodeSeqNum = INPUT(SEQNUM,6.);
		*Dose_PatientID = INPUT(PATIENTID,5.);
		*Episodes_CURRENTFLAG=INPUT(CURRENTFLAG,$8.);
		*Episodes_TXUNITID=INPUT(TXUNITID,$8.);
		*Episodes_LEVELOFCAREID= INPUT(LEVELOFCAREID, $8.);
		*Episodes_DischargeReason = INPUT(dischargeorreferreason, $300.);
		
		if VTYPE(ADMITPOSTED) = "N" then Episodes_AdmitPosted = ADMITPOSTED;
		else Episodes_AdmitPosted = INPUT(SUBSTR(ADMITPOSTED,1,10), YYMMDD10.);
		
		if VTYPE(ADMITDATE) = "N" then do;
			Episodes_DateAdmit = ADMITDATE;
		end;
		else do;
			if ADMITDATE IN ("00:00.0","null") then do;
				Episodes_DateAdmit = .E;
				putlog "WARNING!: No AdmitDate for Treatment Episode: " Dose_EpisodeSeqNum " in Database for Clinic ID: " Dose_PatientID " Contact Clinic for further information and instructions. Subsequent Analysis will fail!"; 
			end;
			else Episodes_DateAdmit = INPUT(SUBSTR(ADMITDATE,1,10),YYMMDD10.);
		end;
		
		if VTYPE(DischargePosted) = "N" then Episodes_DischargePosted = DischargePOSTED;
		else do;
			if DischargePOSTED IN ("00:00.0","null") then do;
				Episodes_DischargePosted = .C;
			end;
			else do;
				DischargePOSTED_temp = INT(INPUT(DischargePOSTED,10.));
				Episodes_DischargePosted = DischargePOSTED_temp - 21916;
			end;
		end;


		
		if VTYPE(DISCHARGEDATE) = "N" then do;
			Episodes_DateDischarge = DISCHARGEDATE;
		end;
		else do;
			if DISCHARGEDATE IN ("00:00.0","null") then do;
				Episodes_DateDischarge = .C;
				putlog "WARNING!: CURRENT TREATMENT!! No DischargeDate for Treatment Episode : " Dose_EpisodeSeqNum " in Database for Clinic ID: " Dose_PatientID; 
			end;
			else do;
				DISCHARGEDATE_temp = INT(INPUT(DISCHARGEDATE,10.));
				Episodes_DateDischarge = DISCHARGEDATE_temp - 21916;
			end;
		end;
	
		*if Dose_PATIENTID = . THEN DELETE;
		*else if Dose_EpisodeSeqNum = . THEN DELETE;

		RENAME admittypeid = Episodes_AdmitTypeID 
				dischargetypeid = Episodes_DischargeTypeID
				PatientID = Dose_PatientID
				SeqNum = Dose_EpisodeSeqNum
				CURRENTFLAG = Episodes_CURRENTFLAG
				levelofcareid = Episodes_LevelofCareID
				txunitid = Episodes_TxUnitID
				dischargeorreferreason = Episodes_DischargeReason; 
		LABEL Episodes_DateDischarge = " "
			  Episodes_DischargePosted = " "
			  Episodes_DateAdmit = " "
			  Episodes_AdmitPosted = " "
			  Episodes_LEVELOFCAREID = " "
			  Episodes_TXUNITID = " "
			  Episodes_CURRENTFLAG = " "
			  Dose_PatientID = " "
			  Dose_EpisodeSeqNum = " ";
		DROP DischargePosted_temp DischargeDate_temp;
run;

proc contents;
run;

	/*** REDO IMPORT WITH EPISODES AND THEN DO THE WHERE STATEMENTS ****/
proc sort data = METHADOS.Episodes_TLC out = METHADOS.Episodes_TLC_sorted;
		by Dose_PatientID;
run;


proc sort data = METHADOS.Datatomerge;
	by Dose_PatientID;
run;

data METHADOS.Episodes_TLC_merged;
		merge METHADOS.datatomerge_tlc METHADOS.Episodes_TLC_sorted;
		by Dose_PATIENTID;
run;



%MACRO TLCIMPORT(ID=);

	data TEMPFILE.import_&ID.;
		set METHADOS.import_TLC_merged (where = (ID = "&ID."));
	run;
	
	data TEMPFILE.episodestemp_&ID.;
		set METHADOS.episodes_TLC_merged (where = (ID = "&ID."));
	run;

	proc sort data = TEMPFILE.episodestemp_&id. out = TEMPFILE.episodes2_&id.;
		by Episodes_DateAdmit;
	run;

	/*** Code below is done not to eliminate episodes but to deal with adjacent episodes.
	For example, subjects might have been transferred into different programs (due to funding status or the like)
	and the clinics discharge them from their current program into a new program in the same clinic and they
	receive the same dose. So we look ahead and look backwards to see if there are episodes as such and code
	BOTH episodes for the same admit and discharge.

	The goal for us is to be able to merge the admit/discharge data into the process datasets seen below by the
	EpisodeSeqNum (the unique identifer for an episode) without losing any data ***/
	proc sort data = TEMPFILE.episodestemp_&id.;
		by Episodes_DateAdmit Episodes_DateDischarge;
	run;
		
	/*** The key is to go right to an array first using the standard code that I used before ***/
	data TEMPFILE.episodes1a_&id.;
		set TEMPFILE.episodestemp_&id.;
		retain Number 0;
		if Episodes_DateAdmit = Episodes_DateDischarge THEN DELETE;
		Number + 1;
		ID = symget('ID');
		RENAME Dose_EpisodeSeqNum =  EpisodeSeqNumtemp
			   Episodes_DateAdmit = DateAdmittemp
			   Episodes_DateDischarge = DateDischargetemp
			   Episodes_AdmitTypeID = AdmitTypeIDtemp 
			   Episodes_DischargeTypeID = DischargeTypeIDtemp
			   Episodes_DischargeReason = DischargeReasontemp;
		keep Number Dose_PatientID Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge Episodes_AdmitTypeID Episodes_DischargeTypeID Episodes_DischargeReason;
	run;
	
	/*** The temporary array to check for internal transfers will drop the term Episodes, since Episodes emplies that this is complete. When we use the prefix Episodes
	it implies that the data good to go and merge, in this case not ***/
	
	data TEMPFILE.EpisodesArrayMatch_&ID.;
		set TEMPFILE.episodes1a_&id. end = eof;
		array EpisodeSeqNum[30];
		array DateAdmit[30];
		array DateDischarge[30];
		array AdmitTypeID[30] $ 5;
		array DischargeTypeID[30] $ 5;
		array DischargeReason[30] $ 300;

		FORMAT DateAdmit1-DateAdmit30 DateDischarge1-DateDischarge30 MMDDYY10.;

		retain EpisodeSeqNum1-EpisodeSeqNum30 
			   DateAdmit1-DateAdmit30
			   DateDischarge1-DateDischarge30
			   AdmitTypeID1-AdmitTypeID30
			   DischargeTypeID1-DischargeTypeID30
			   DischargeReason1-DischargeReason30;

		/*** Ascertain why did I do this again?: Makes no sense, I is being incremented, 
			Actually if it ain't broken, don't fix it ***/
			
		do i = 1 to 15;
			EpisodeSeqNum[number] = EpisodeSeqNumtemp;
			DateAdmit[number] = DateAdmittemp;
			DateDischarge[number] = DateDischargetemp;
			AdmitTypeID[number] = AdmitTypeIDtemp;
			DischargeTypeID[number] = DischargeTypeIDtemp;
			DischargeReason[number] = DischargeReasontemp;
		end;
		
		if eof then do;
			ID = symget('ID');
			DROP  DateAdmittemp DateDischargetemp  AdmitTypeIDtemp DischargeTypeIDtemp DischargeReasontemp;
			output TEMPFILE.EpisodesArrayMatch_&ID.;
		end;
	run;
	
	data TEMPFILE.EpisodesArrayMatch2_&ID.;
		set TEMPFILE.EpisodesArrayMatch_&ID.;
		
		array EpisodeSeqNum[30];
		array DateAdmit[30];
		array DateDischarge[30];
		array AdmitTypeID[30] $ 5;
		array DischargeTypeID[30] $ 5;
		array DischargeReason[30] $ 300;
		array EpisodeCounttemp[30];
		
		EpisodeCounttemp[1] = 1;
		/*** Updated the DischargeDates for the latest entry****/
		do i = 1 to Number;	
			if DateDischarge[i] = DateAdmit[i+1] then do;
				/*** Current Admit = NExt ADMIT **/
				DateAdmit[i+1] = DateAdmit[i];
				AdmitTypeID[i+1] = AdmitTypeID[i];
				DateDischarge[i] = DateDischarge[i+1];
				if EpisodeCounttemp[i] = 1 then EpisodeCounttemp[i+1] = 0;
				else if EpisodeCounttemp[i] = . then do;
					EpisodeCounttemp[i] = 0;
					EpisodeCounttemp[i+1] = 0;
				end;
				else if EpisodeCounttemp[i] = 0 then EpisodeCounttemp[i+1] = 0;
			end;
			else if DateDischarge[i] NE DateAdmit[i+1] then do;
				EpisodeCounttemp[i] = 1;
				EpisodeCounttemp[i+1] = 1;
			end;
		end;
		
		/*** Since the admits are all good, we need to backtrack for the discahrges ****/
		do z = Number to 2 by (-1);
			if DateAdmit[z] = DateAdmit[z-1] then do;
				/*** If the dates are the same, then the last discharge = the first discharge ***/
				DateDischarge[z-1] = DateDischarge[z];
				DischargeTypeID[z-1] = DischargeTypeID[z];
				DischargeReason[z-1] = DischargeReason[z];
				EpisodeCounttemp[z] = 0;
			end;
		end;
	run;	

	data TEMPFILE.episodes2_&id.;
		set TEMPFILE.EpisodesArrayMatch2_&ID.;
		
		array EpisodeSeqNum[30];
		array DateAdmit[30];
		array DateDischarge[30];
		array AdmitTypeID[30] $ 5;
		array DischargeTypeID[30] $ 5;
		array DischargeReason[30] $ 300;
		array EpisodeCounttemp[30];

		
		do i = 1 to Number;
			Dose_EpisodeSeqNum = EpisodeSeqNum[i];
			Episodes_DateAdmit = DateAdmit[i];
			Episodes_AdmitTypeID = AdmitTypeID[i];
			Episodes_DateDischarge = DateDischarge[i];
			Episodes_DischargeTypeID = DischargeTypeID[i];
			Episodes_DischargeReason = DischargeReason[i];
			Episode_NumDays = DateDischarge[i] - DateAdmit[i];
			EpisodeCount = EpisodeCounttemp[i];
			output TEMPFILE.episodes2_&id.;
		end;
		 
		KEEP Dose_PATIENTID Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_AdmitTypeID Episodes_DateDischarge Episodes_DischargeTypeID Episodes_DischargeReason EpisodeCount;
	run;
	/*** Code below is done not to eliminate episodes but to deal with adjacent episodes.
	For example, subjects might have been transferred into different programs (due to funding status or the like)
	and the clinics discharge them from their current program into a new program in the same clinic and they
	receive the same dose. So we look ahead and look backwards to see if there are episodes as such and code
	BOTH episodes for the same admit and discharge.
	The goal for us is to be able to merge the admit/discharge data into the process datasets seen below by the
	EpisodeSeqNum (the unique identifer for an episode) without losing any data ***/
	data TEMPFILE.episodes3_&id.;
		set TEMPFILE.episodes2_&id.;
		
		if Episodes_DateAdmit = . then DELETE;
		
		retain Episodes_SumDays;
		retain SumEpisodes 0;
		
		/** We want to be able to figure out the Number of Days in Treatment (in the Analysis Dataset as NumDaysTx) and the
		number of episodes - number of concurrent times in treatment that a subject has stayed */
		if EpisodeCount = 1 AND Episodes_DateDischarge NE .C then Episodes_NumDays = Episodes_DateDischarge - Episodes_DateAdmit;
		else if EpisodeCount = 0 then Episodes_NumDays = 0;
		
		if Episodes_DateDischarge = .C then Episodes_NumDays = "12Mar2021"D - Episodes_DateAdmit;

		if EpisodeCount = 1 then Episodes_SumDays + Episodes_NumDays;
		else if EpisodeCount = 0 then Episodes_SumDays = Episodes_SumDays;

		SumEpisodes + EpisodeCount;	
		
		if eof then do;
				CALL SYMPUTX('FinSumDays',Episodes_SumDays);
				CALL SYMPUTX('FinSumEpi',SumEpisodes);
		end;
		KEEP Dose_PatientID Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_AdmitTypeID Episodes_DateDischarge Episodes_DischargeTypeID Episodes_DischargeReason SumEpisodes EpisodeCount  Episodes_NumDays Episodes_SumDays;
	run;


	%if %symexist(FinSumDays) = 0 %then %let FinSumDays = .;
	%if %symexist(FinSumEpi) = 0 %then %let FinSumEpi = .;
	
	data TEMPFILE.episodesforlong_&id.;
		set TEMPFILE.episodes3_&id.;
		FORMAT Episodes_DateAdmit Episodes_DateDischarge MMDDYY10.;
		ID = symget('ID');
	run;
	
	proc append base = METHADOS.episodeslong data = TEMPFILE.episodesforlong_&id. FORCE;
	run;

	
	data TEMPFILE.EpisodesTEMPArray_&ID.;
		set TEMPFILE.episodes3_&id.;
		if EpisodeCount = 0 then DELETE;
		retain Number 0;
		Number + 1;
		RENAME Dose_EpisodeSeqNum =  Dose_EpisodeSeqNumtemp
			   Episodes_DateAdmit = Episodes_DateAdmittemp
			   Episodes_DateDischarge = Episodes_DateDischargetemp
			   Episodes_NumDays = Episodes_NumDaystemp
			   Episodes_AdmitTypeID = Episodes_AdmitTypeIDtemp 
			   Episodes_DischargeTypeID = Episodes_DischargeTypeIDtemp
			   Episodes_DischargeReason = Episodes_DischargeReasontemp;
		keep Number Dose_PatientID SumEpisodes Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge Episodes_NumDays Episodes_AdmitTypeID Episodes_DischargeTypeID Episodes_DischargeReason;
	run;
	
	/*** Assuming no more than 10 episodes, and you will receive a ARRAY ERROR if it is over 10 and you should
	act accordingly ***/
	data TEMPFILE.Episodes_&ID.;
		set TEMPFILE.EpisodesTEMPArray_&ID. end = eof;
		array Dose_EpisodeSeqNum[15];
		array Episodes_DateAdmit[15];
		array Episodes_DateDischarge[15];
		array Episodes_NumDays[15];
		array Episodes_AdmitTypeID[15] $ 5;
		array Episodes_DischargeTypeID[15] $ 5;
		array Episodes_DischargeReason[15] $ 300;

		FORMAT Episodes_DateAdmit1-Episodes_DateAdmit15 Episodes_DateDischarge1-Episodes_DateDischarge15 MMDDYY10.;

		retain Dose_EpisodeSeqNum1-Dose_EpisodeSeqNum15 
			   Episodes_DateAdmit1-Episodes_DateAdmit15
			   Episodes_DateDischarge1-Episodes_DateDischarge15
			   Episodes_NumDays1-Episodes_NumDays15
			   Episodes_AdmitTypeID1-Episodes_AdmitTypeID15
			   Episodes_DischargeTypeID1-Episodes_DischargeTypeID15
			   Episodes_DischargeReason1-Episodes_DischargeReason15;

		do i = 1 to 15;
			Dose_EpisodeSeqNum[number] = Dose_EpisodeSeqNumtemp;
			Episodes_DateAdmit[number] = Episodes_DateAdmittemp;
			Episodes_DateDischarge[number] = Episodes_DateDischargetemp;
			Episodes_NumDays[number] = Episodes_NumDaystemp;
			Episodes_AdmitTypeID[number] = Episodes_AdmitTypeIDtemp;
			Episodes_DischargeTypeID[number] = Episodes_DischargeTypeIDtemp;
			Episodes_DischargeReason[number] = Episodes_DischargeReasontemp;
		end;

		if eof then do;
			ID = symget('ID');
			DROP Dose_EpisodeSeqNumtemp Number  i Episodes_DateAdmittemp Episodes_DateDischargetemp Episodes_NumDaystemp Episodes_AdmitTypeIDtemp Episodes_DischargeTypeIDtemp Episodes_DischargeReasontemp;
			output TEMPFILE.Episodes_&ID.;
		end;
	run;
	
	/** Recommended Technique by SAS to iteratively appending datasets **/
	
	proc append base = METHADOS.Episodes_all data = TEMPFILE.Episodes_&id. FORCE;
	run;

	
	/*** The following code takes a macro variable that was initialized in Episodes 2 and puts it back into Episodes 4 so EACH observation now
	includes the Total Number of Days in Tx and how many stays in tx */
	data TEMPFILE.episodes4_&id.;
		set TEMPFILE.episodes3_&id. end = last;
		Episodes_NumDays = Episodes_DateDischarge - Episodes_DateAdmit;
	run;
	
	proc sort data = TEMPFILE.episodes4_&id.;
		by Dose_EpisodeSeqNum;
	run;
	
	/************* CHECKING FOR ID NUMBERS **************************/
	data _NULL_;
		merge TEMPFILE.import_&id. TEMPFILE.episodes4_&id. (in = inEpisode);
		by Dose_PatientID;
		if inEpisodes = 0 then do;
				PUTLOG "Episodes File ID num does not match in Import File for &ID. do not have the same ID - REIMPORT";
				Episodes_DateDischarge = .M;
		end;
	run;

	/*** For future purposes: We should find a way to terminate the execution of the macro in the case where
	the ID numbers for both the Import File and Episodes File are not Equal since the file would not be correct
	to use in this situation */

	/* Merging all Import and Episodes Data */
	data TEMPFILE.process_&id.;
		merge TEMPFILE.import_&id. (in = inImport) TEMPFILE.episodes4_&id. (in = inEpisode);
		by Dose_EpisodeSeqNum;

		/*** Modification 3/21/2020: we need to get the Study Subject ID into the database ASAP so we can merge with other databases to help with the processing **/
		ID = symget('ID');			
		/* The reason for this was a trial run in understanding how to check ID numbers between Episodes and ScriptHistory
		files. This initial attempt failed to do so accurately and was done in the above data _NULL_ step */
		/* if inEpisodes = 0 then do;
				PUTLOG "Episodes File ID num does not match in Import File for &ID. do not have the same ID - REIMPORT";
				Episodes_DateDischarge = .M;s
		end; */
	run;
 	
									   
		
	 
	
	data TEMPFILE.process_&id.;
		set TEMPFILE.process_&ID.;
		
								 
		if Dose_EndDate = . AND Episodes_DateDischarge = .C then Dose_EndDate = Extraction_Date;
		if Dose_EndDate > Extraction_Date then Dose_EndDate = Extraction_Date;

	run;

	data TEMPFILE.processa_&id.;
		set TEMPFILE.process_&id.;
		if Dose_EndDate = .M then Dose_EndDate = Extraction_Date;
		format Dose_Increment1-Dose_Increment30 3.;
		array Dose_Increment[*] Dose_Increment1-Dose_Increment30;
		*Required so we can calc incrmental increases or decreases;
		format New_Dosage 10.;
				length Dose_ChangeType $ 40;
		LENGTH Phase $ 2;
		LENGTH PhysicianComments $ 1000;
		FORMAT Dose_StartDate Dose_EndDate PreviousDoseStartDate PreviousDoseEndDate MMDDYY10.;
		retain PreviousDose PreviousDoseStartDate PreviousDoseEndDate;
		retain DoseChangeCount 0;
		*Retained so we can get previous;
		if Dose_whencancelled NE .N then delete;
		/*Not really sure if I need InitialR and InitialT at this point because I already accounted
		for the dates in the "LEAD" function that was generated */
		*************************************** CLASSIFICATION OF CHANGES IN DOSE****************************************;

		/*Using Regimen Dose we need to retain this value for subsequent take home quantity
		measurements, not sure if they do this ALL TIMES, but it seemes consistent from
		what I'm seeing*/

		if Dose_SCRIPTTYPEID="R" then
			do;
				if Dose_EndDate = .M then Dose_EndDate = Extraction_Date;
				if DoseChangeCount = 0 then DoseChangeCount = 1;
				else if DoseChangeCount > 0 then DoseChangeCount + 1;
				Dose_Changetype="Regimen Dose";
				/*** TO ACCOUNT FOR situation like TLC7246, go ahead and delete the record 
				and put a putlog statement out to indicate ***/
				if Dose_Dosage = 0 then do;
					PUTLOG "Observation Number: " _N_ " for ID: " ID " indicates a dose of 0 given, this
							observation has been deleted and disregarded";
					DELETE;
				end;

				New_Dosage=Dose_DOSAGE;
				PreviousDose=Dose_DOSAGE;
				PreviousDoseEndDate = Dose_EndDate;
										 
				PreviousDoseStartDate = Dose_StartDate;
				PhysicianComments = Dose_MedicalNote;				   
				*NumTakeHome=MAX(PreviousTHB, NumTakeHome);
				*if Phase=" " then
					Phase=PreviousPhase;
				output TEMPFILE.processa_&id.;
			end;
		/* We will decipher phase from this step, I think the best logic would be
		to keep this one as the main one for analysis as we do see the change in takehomes
		in time. THe problem is that we have to account when their dose has changed. So what
		we will probably do is retain the end date and make sure that they coencide with each
		other and the dose. */

		if Dose_SCRIPTTYPEID = "T" then output TEMPFILE.processa_&id.;

		if Dose_SCRIPTTYPEID = "W" then output TEMPFILE.processa_&id.;

		if dose_ScriptTypeID="I" then
		do;
				if Dose_EndDate = .M then Dose_EndDate = Extraction_Date;
				Dose_changetype="Incremental Increase";
				EndDate_temp = Dose_EndDate;
				StartDate_temp = Dose_StartDate;
				New_Dosage=Dose_DOSAGE;
				*NumTakeHome = PreviousTHB;
				*if NumTakeHome = . then NumTakeHome = .N;
				FORMAT StartDate_temp EndDate_temp MMDDYY10.;
				PhysicianComments = Dose_MedicalNote;
				Diff_Dose= Dose_StopAt - Dose_StartAt;
										 
				
				/** Checked with Christie Hanvey @ SPC, she explained that they would not increment in the system w/ a Dose_DaysinCycle being equal to 0
				the result is we delete the record completely. May need a PUTLOG statement for the coder to see this **/	
				if Dose_DaysinCycle = 0 then Delete;

				c = 0;
				
				array dayofincrement[30];
				array incrementin[30];
				array incrementby[30];
				
				do i = 1 by 1 to dim(Dose_Increment);
					if Dose_Increment[i] NE 0 then c = c + 1;
				end;
				/*** This occurs during Buildup ***/
				if c = 1 AND dose_increment[dose_daysincycle] NE 0 then do;
					if Dose_StopAt - Dose_StartAt > 0 then DO;
						do WHILE ((New_Dosage <= Dose_StopAt) AND (Dose_StartDate + Dose_daysincycle <= EndDate_temp));
							dose_startdate = StartDate_temp;
							dose_endDate = dose_startdate + dose_daysincycle - 1;
							if New_Dosage = Dose_StopAt then Dose_EndDate = EndDate_temp;
							PUTLOG "i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp; 
							DoseChangeCount + 1;
							output TEMPFILE.processa_&id.;
							PreviousDose = New_Dosage;
							new_dosage = new_Dosage + dose_increment[dose_daysincycle];
							StartDate_temp = dose_enddate + 1;
							/* Need to add new condition for if the cycle restarts - would need to look at SPC4747 code to determine procedure */
						end;
						PUTLOG "FINAL i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate;
					end;
					else if Dose_StopAt - Dose_StartAt < 0 then do;
						do WHILE ((New_Dosage >= Dose_StopAt) AND (Dose_StartDate + Dose_daysincycle <= EndDate_temp));
							dose_startdate = StartDate_temp;
							dose_endDate = dose_startdate + dose_daysincycle - 1;
							if New_Dosage = Dose_StopAt then Dose_EndDate = EndDate_temp;
							PUTLOG "i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp; 
							DoseChangeCount + 1;
							output TEMPFILE.processa_&id.;
							PreviousDose = New_Dosage;
							new_dosage = new_Dosage - dose_increment[dose_daysincycle];
							StartDate_temp = dose_enddate + 1;
							/* Need to add new condition for if the cycle restarts - would need to look at SPC4747 code to determine procedure */
						end;
						PUTLOG "FINAL i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate;
					end;
				end;	
				/*** This occurs during detox/decrease of dose***/
					
				z = 0;
				
				/*** We start to deal with subjects who have more than 1 dose_increment values and need to be looked at seperately ***/
				do i =1 by 1 to dim(Dose_Increment);		
					if Dose_Increment[i] NE 0 then do;
						z = z + 1;
						dayofincrement[z] = i;
						if Dose_StopAt - Dose_StartAt < 0 then incrementby[z+1] = (-1) * Dose_Increment[i];
						else incrementby[z+1] = Dose_Increment[i];
						putlog "Z: " z "IncrementBy[z]: " incrementby[z] " IncrementBy[z+1]: " incrementby[z+1];
					end;
				end;
				
				PUTLOG "z= " Z " C = " c;

				if z NE c then PUTLOG "Number of Days that Dose is Incremented does not equate to array size, data step will fail! Z = " z " AND c = " c;

				/* NEED TO ADD CONDITIONS WHERE IF z = 1 then we can proceed normally and just grab the days in cycle like before */

				
				/* Calculate the Number of Days unitl the next increment so we can easily be able to derive the number of days in a between increments */

				/** *Incrementby = The amount of dose to add to existing doses. Within a single record, we may have more than 1 days by which we increment and that have different
				doses to increment. Example: we increment by 5, and then by 10, and then by 5 again 

				Incrementin = THe number of days between increments, so we may have to increment once by 5 days, and then in another 10 days do another increment, etc. ***/
				
				if z > 1 OR dose_increment[dose_daysincycle] = 0 then do;
				incrementby[1] = 0;
					do i=1 to (c+1) by 1;
						if i = 1 then incrementin[1] = dayofincrement[1];
						else if dayofincrement[i] NE . then incrementin[i] = dayofincrement[i] - dayofincrement[i-1];

						if i = c + 1 AND dayofincrement[i-1] < dose_daysincycle then do;
							incrementin[i] = (dose_daysincycle - dayofincrement[i-1]);
						end;
						PUTLOG "Incrementin: " incrementin[i]  "IncrementBy[i]: " incrementby[i] " IncrementBy[z+1]: " incrementby[i+1];
					end;
					PUTLOG "i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp "IncrementBy: " incrementby[i]; 
					/*** READ THE DO DOCUMENTATION ****/
					
					i = .;
					PUTLOG "Counter C: " c " New_Dosage: " New_Dosage " Dose_StopAt: " Dose_StopAt " Dose_StartDate: " Dose_StartDate " dose_DaysinCycle: " dose_DaysinCycle " EndDate_temp: " EndDate_temp;
					if Dose_StopAt - Dose_StartAt > 0 then do;
						IncrementCycle = 1;
						do i=1 to (c+1) by 1 WHILE ((New_Dosage <= Dose_StopAt) AND (dose_startdate + incrementin[i] < EndDate_temp));
								dose_startdate = StartDate_temp;
								new_dosage = new_Dosage + incrementby[i];
								if New_Dosage < Dose_StopAt then do;
										if dose_startdate + incrementin[i] < EndDate_temp then dose_endDate = dose_startdate + incrementin[i] - 1;
										else if dose_startdate + incrementin[i] > EndDate_temp then dose_endDate = EndDate_temp;
								end;								
								else if New_Dosage = Dose_StopAt then Dose_EndDate = EndDate_temp;
								PUTLOG "i: " i " IncrementCycle: " IncrementCycle "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp "IncrementBy: " incrementby[i]; 
								DoseChangeCount + 1;
								output TEMPFILE.processa_&id.;
								if i = (c + 1) AND New_Dosage < Dose_StopAt then do;
									i = 1;
									IncrementCycle = IncrementCycle + 1;
								end;
								PreviousDose = New_Dosage;
								StartDate_temp = dose_enddate + 1;
								/* Need to add new condition for if the cycle restarts - would need to look at SPC4747 code to determine procedure */
						end;
						PUTLOG "FINAL i: " i " IncrementCycle: " IncrementCycle " New_Dosage: " New_Dosage " Dose_StartDate: " Dose_StartDate " Dose_EndDate: " Dose_EndDate;
					end;
					else if Dose_StopAt - Dose_StartAt < 0 then do;
						IncrementCycle = 1;
						do i=1 to (c+1) by 1 WHILE ((New_Dosage >= Dose_StopAt) AND (dose_startdate < EndDate_temp));
								dose_startdate = StartDate_temp;
								new_dosage = new_Dosage + incrementby[i];
								if New_Dosage > Dose_StopAt then do;
										if dose_startdate + incrementin[i] < EndDate_temp then dose_endDate = dose_startdate + incrementin[i] - 1;
										else if dose_startdate + incrementin[i] > EndDate_temp then dose_endDate = EndDate_temp;
								end;
								else if New_Dosage = Dose_StopAt then Dose_EndDate = EndDate_temp;
								PUTLOG "i: " i " IncrementCycle: " IncrementCycle "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp "IncrementBy: " incrementby[i]; 
								DoseChangeCount + 1;
								output TEMPFILE.processa_&id.;
								if i = (c + 1) AND New_Dosage > Dose_StopAt then do;
									i = 1;
									IncrementCycle = IncrementCycle + 1;
								end;								
								PreviousDose = New_Dosage;
								StartDate_temp = dose_enddate + 1;
								/* Need to add new condition for if the cycle restarts - would need to look at SPC4747 code to determine procedure */
						end;
						PUTLOG "FINAL i: " i " IncrementCycle: " IncrementCycle "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate;
				end;
			end;
		end;
	run;
	
	proc sort data = TEMPFILE.processa_&id.;
		by Dose_StartDate;
	run;

	data TEMPFILE.processb_&id.;
							 
		RETAIN PreviousDose_THB;
		set TEMPFILE.processa_&id.;	
		if Dose_SCRIPTTYPEID = "I" OR Dose_SCRIPTTYPEID ="R" then PreviousDose_THB = New_Dosage;
		PUTLOG "Dose ScriptType: " Dose_ScripttypeID " New_Dosage from previous dataset: " New_Dosage " Newly Created PreviousDose_THB: " PreviousDose_THB;
	run;

	data TEMPFILE.process1a_&ID.;
		set TEMPFILE.processb_&id.;
				FORMAT PreviousTHBStartDate PreviousTHBEndDate MMDDYY10.;
		retain SHWPhase ClinicPhase PreviousPhase PreviousTHB PreviousTHBStartDate PreviousTHBEndDate;
  
				
		
		/* We will decipher phase from this step, I think the best logic would be
		to keep this one as the main one for analysis as we do see the change in takehomes
		in time. THe problem is that we have to account when their dose has changed. So what
		we will probably do is retain the end date and make sure that they coencide with each
		other and the dose. */
	if Dose_SCRIPTTYPEID="T" then do;
				if Dose_EndDate = .M then Dose_EndDate = Extraction_Date;
				Dose_Changetype="Take Home Quantity Change";
				NumTakeHome=Dose_takehomesupply;
				if New_Dosage = . then New_Dosage = PreviousDose_THB;
				else PUTLOG "You messed up somewhere with this new PreviousDose_THB code!";
				PreviousTHB=NumTakeHome;

				/* Declaraing Phases - will be using IRB GRANT DATA */
				if dose_takehomesupply IN (0, 1) then SHWPhase="1";
				else if dose_takehomesupply=2 then	SHWPhase="2";
				else if dose_takehomesupply=3 then	SHWPhase="3";
				else if dose_takehomesupply=4 then	SHWPhase="4";
				else if Dose_takehomesupply=5 then	SHWPhase="5";
				else if dose_takehomesupply=6 then	SHWPhase="6";
				else if dose_takehomesupply=13 then	SHWPhase="6a";
				else if dose_takehomesupply=27 then	SHWPhase="6b";
				
				/****** SPC *********************************/
				/**** Declaring Phases using Clinic System ****/
				if dose_takehomesupply IN (0, 1) then ClinicPhase="1";
				else if dose_takehomesupply IN (2,3) then	ClinicPhase="2";
				else if dose_takehomesupply=4 then	ClinicPhase="3";
				else if dose_takehomesupply=5 then	ClinicPhase="4";
				else if Dose_takehomesupply=6 then	ClinicPhase="5";
				else if dose_takehomesupply=13 then	ClinicPhase="6a";
				else if dose_takehomesupply=27 then	ClinicPhase="6b";
				
				PreviousPhase=ClinicPhase;
				PreviousTHBStartDate =Dose_StartDate;
				PreviousTHBEndDate=Dose_EndDate;
				PhysicianComments=Dose_MEDICALNOTE;
		end;
			
		if Dose_ScripttypeID="W" then do;
				Dose_Changetype="Special Take Home Supply";
				NumTakeHome=Dose_takehomesupply;
				if ClinicPhase = " " then ClinicPhase = PreviousPhase;
				if New_Dosage = . then New_Dosage = PreviousDose_THB;
				else PUTLOG "You messed up somewhere with this new PreviousDose_THB code!";
				PreviousTHBStartDate =Dose_StartDate;
				PreviousTHBEndDate=Dose_EndDate;
				PhysicianComments=Dose_MEDICALNOTE;
		end;
		
		/*** The first condition is never needed since in theory the NumTakeHome for an I/R record will ALWAYS
		be missing since they do not consider that in this type of record ***/
		if Dose_SCRIPTTYPEID IN ("I","R") then do;
			if PreviousTHB NE . AND NumTakeHome NE . then NumTakeHome=MAX(PreviousTHB, NumTakeHome);
			else if PreviousTHB NE . AND NumTakeHome EQ . then NumTakeHome = PreviousTHB;
			else if PreviousTHB EQ . AND NumTakeHOME EQ . then NumTakeHome = .;
			if ClinicPhase=" " then
				ClinicPhase=PreviousPhase;
			PhysicianComments= Dose_MEDICALNOTE;
		end;

	run;
	
	/*** Here we look at previous and look ahead records to make sure that there are no disrepncies between the final dosing records and sequence
	This is strictly to deal with discharges ***/
  	data TEMPFILE.process2_&id.;
		format Previous_StartDate Previous_EndDate MMDDYY10.;
		merge TEMPFILE.process1a_&id. end = eof TEMPFILE.process1a_&id. (KEEP= Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge
			FirstOBs=2 Rename=(Dose_EpisodeSeqNum = Next_EpisodeSeqNum Episodes_DateAdmit = NextAdmit Episodes_DateDischarge = NextDischarge));
		Previous_StartDate=lag1(Dose_StartDate);
		Previous_EndDate=lag1(Dose_EndDate);
		length CURRENT $ 5 ID $ 7;

		if Dose_StartDate = . then DELETE;

				
		/* The data is bad and should not be used since the discharge and admit date is blank ***/
		if Dose_endDate > Episodes_DateDischarge AND (Episodes_DateDischarge NE .C OR Episodes_DateDischarge = .M) 
		AND Dose_PatientID NE 6154 /*TLC____ */ AND Dose_PatientID NE 13253 /*TLC____ */  then do;
				Dose_EndDate = Episodes_DateDischarge;
				PUTLOG "End of Dose Entry is Later than the Date of Discharge for episode, end date of dose has been changed to reflect.";
		end;
		
		/*** ACCOUNTING FOR SITUATIONS LIKE TLC9002 where there last record is I and the end date of dose does not reflect ***/
		*if Dose_EndDate < Episodes_DateDischarge AND EOF AND Dose_ScriptTypeID NE "W" then Dose_EndDate = Episodes_DateDischarge;
		if Dose_EndDate = .M then Dose_EndDate = Extraction_date;

		if Episodes_DateDischarge = .C then CURRENT = "TRUE";
		else CURRENT = "FALSE";
		/*Correction 12/21/2018 - Revamped the determination of NumDays to account for duplicate entries, the situation in TLC where Dose_StartDate for
		TakeHome changes are earlier than the StartDate for regimen dose */
		if dose_episodeseqnum NE Next_EpisodeSeqNum AND (Next_EpisodeSeqNum NE . ) then do;
			output TEMPFILE.process2_&id;
			Dose_SEQNUM = .D;
			Dose_EpisodeSeqNum = .D;
			Dose_ScriptTypeId = "Z";
			ClinicPhase = "Z";
			SHWPhase = "Z";
			Dose_StartDate = Episodes_DateDischarge + 1;
			Dose_EndDate = NextAdmit - 1; 
			New_Dosage = .D;
			NumTakeHome = .D; 
		end;
		output TEMPFILE.process2_&id;
		DROP NextAdmit NextDischarge Next_EpisodeSeqNum;
	run;


		
/*** Code to address W records so it can be ouputted in DS **/

/*** NOte: AN output statement just outputs, the PDV remains active with the last 
observation **/

	data TEMPFILE.process25_&id.;
		merge TEMPFILE.process2_&id. end = eof TEMPFILE.process2_&id.
			(KEEP= Dose_StartDate Dose_EndDate New_Dosage PhysicianComments NumTakeHome
					ClinicPhase SHWPhase Dose_ScriptTypeID Dose_ChangeType
			FirstObs=2 
			Rename=(Dose_StartDate=Next_StartDate 
						Dose_EndDate=Next_EndDate 
						Dose_ScriptTypeID = Next_ChangeTypeID
						New_Dosage = Next_Dosage
						PhysicianComments = Next_PhysicianComments
						NumTakeHome = Next_NumTakeHome
						ClinicPhase = Next_ClinicPhase
						SHWPhase = Next_SHWPhase
						Dose_ChangeType = Next_ChangeType));
			
		* In this situation, the first plan is to deal if the next record is W, ;
		* change the end date to be the start of the W record;
		/*** we are storing the needed values to  a Wrec prefix variable that will be retained
		throughout so we can pull it for the new observatio ***/
		
		retain Wrec_StartDate Wrec_EndDate 
			Wrec_Dosage Wrec_THB Wrec_PhysComments Wrec_TypeID Wrec_ChangeType Wrec_SHWPhase Wrec_ClinicPhase;


		if Next_ChangeTypeID = "W" then do;
			Wrec_StartDate = Dose_StartDate;
			Wrec_EndDate = Dose_EndDate;
			Wrec_Dosage = New_Dosage;
			Wrec_THB = NumTakeHome;
			Wrec_TypeID = Dose_ScriptTypeID;
			Wrec_ChangeType = Dose_ChangeType;
			Wrec_PhysComments = PhysicianComments;
			Wrec_SHWPhase = SHWPhase;
			Wrec_ClinicPhase = ClinicPhase;
			Dose_EndDate = Next_StartDate - 1;
			OUTPUT;
		end;		
		else if Dose_ScriptTypeID = "W" and EOF = 0 then do;
			OUTPUT;
			Dose_StartDate = Dose_EndDate + 1;
			Dose_EndDate = Wrec_EndDate;
			New_Dosage = Wrec_Dosage;
			NumTakeHome = Wrec_THB;
			Dose_ScriptTypeID = Wrec_TypeID;
			Dose_ChangeType = Wrec_ChangeType;
			SHWPhase = Wrc_SHWPhase;
			ClinicPhase = Wrc_ClinicPhase;
			PhysicianComments = Wrec_PhysComments;
			Phase = Wrec_Phase;
			OUTPUT;
		end;
		else if Dose_ScriptTypeID = "W" then do;
			OUTPUT;
			Dose_StartDate = Dose_EndDate + 1;
			Dose_EndDate = Wrec_EndDate;
			New_Dosage = Wrec_Dosage;
			NumTakeHome = Wrec_THB;
			Dose_ScriptTypeID = Wrec_TypeID;
			Dose_ChangeType = Wrec_ChangeType;
			SHWPhase = Wrc_SHWPhase;
			ClinicPhase = Wrc_ClinicPhase;
			PhysicianComments = Wrec_PhysComments;
			Phase = Wrec_Phase;
			OUTPUT;
		end;
		else OUTPUT;
	run;

 
	/*** WE now check for individual dosing record disrepencies and calculate the number of days of each dose ***/
	
	
	data TEMPFILE.process3_&id.;
		merge TEMPFILE.process25_&id.  end = eof TEMPFILE.process25_&id. (KEEP=Dose_StartDate Dose_EndDate Dose_ChangeType Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge
				FirstOBs=2 Rename=(Dose_StartDate=Next_StartDate Dose_EndDate=Next_EndDate Dose_ChangeType = Next_ChangeType Dose_EpisodeSeqNum = Next_EpisodeSeqNum Episodes_DateAdmit = NextAdmit Episodes_DateDischarge = NextDischarge));
			retain SumDays 0  Previous_SumDays Drug_Name;
			
		LENGTH Drug_Name $ 100;
		
		retain Drug_Name;
								
		if Dose_MedicationID = "0b5ef14726f449aea2cc3ba9ac3b7885" then Drug_Name = "Methadone";
		else if Dose_MedicationID = "a751918ff3464d34b8c1060f9e2c991e" then Drug_Name = "Suboxone";
		else if Dose_MedicationID = "5a14e2bae155478bb89d63e54d737d3d" then Drug_Name = "Suboxone";
		else if FIND(PhysicianComments, "methadone","i") > 0 then Drug_Name = "Methadone";
		else if FIND(PhysicianComments, 'suboxone', 'i') > 0 then Drug_Name = "Suboxone";

		if NumTakeHome = .D then NumTakeHome = .D;
		else if Dose_TakeHomeSupply = .N and NumTakeHome = . then NumTakeHome = 0;

		if _N_ = 1 AND Dose_StartDate < Next_StartDate AND Dose_ChangeType = "Take Home Quantity Change" AND Next_ChangeType = "Regimen Dose" then do;
			PUTLOG "ERROR!!: TLC data entry error with Regimen vs TAKE HOME for " Dose_PatientID " Take Home
			Start has been modified to the start of the regimen date."; 
			delete;
		end;

		if Dose_StartDate = Next_StartDate AND Dose_ChangeType = "Take Home Quantity Change" AND Next_ChangeType = "Regimen Dose" then do;
			PUTLOG "ERROR!!: Likely a TLC data entry error for " Dose_PatientID " This entry has been deleted and will not be considered purposes of generation of a sequence due to the lack of dose corresponding to number of takehomes."; 
			delete;
		end;
		
		if Dose_StartDate = Next_StartDate then do;
			PUTLOG "ERROR!!: Likely a data entry error for " Dose_PatientID " This entry has been deleted and will not be considered purposes of generation of a sequence due to the likelihood that the record is a duplicate errorneous entry."; 
			delete;
		end;

		if Dose_StartDate = Next_StartDate AND Dose_ChangeType =: "R" AND Next_ChangeType =: "T" then delete;

		if eof then do;
			if Episodes_DateDischarge = .C then NumDays = ABS(Extraction_Date - Dose_StartDate);
			else NumDays = (Dose_EndDate - Dose_StartDate);
		end;
		else NumDays= (Next_StartDate - Dose_StartDate);

		SumDays = SumDays + NumDays;
		Previous_NumDays=Lag1(NumDays);

		Previous_SumDays + Previous_NumDays;
	run;

	*********************************** BEGINNING DATE GENERATION SERIES*********************************************;
	/* Will be used to calcualte the Max and Min Doses, Num Days in MD */

	data TEMPFILE.SEQUENCE_&id.;
		set TEMPFILE.process3_&id. end = eof;
		************************* BEGINNING TIMESERIES DATE GENERATION ****************;
		array Days[*] Days1-Days5000;
		array Dose[*] Dose1-Dose5000;
		array THB[*] THB1-THB5000;
		array SHWP[*] $ SHWP1-SHWP5000;
		array ClinicP[*] $ ClinicP1-ClinicP5000;
		array EpiCount[*] EpiCount1-EpiCount5000;
		array Comment[*] $ 200 Comment1-Comment5000; 
		array Drug[*] $ 100 Drug1-Drug5000;

		retain Days1-Days5000 Dose1-Dose5000 Drug1-Drug5000 THB1-THB5000 ClinicP1-ClinicP5000 SHWP1-SHWP5000 EpiCount1-EpiCount5000 Comment1-Comment5000;

		if _N_ = 1 then Previous_SumDays = 0;
	
		do i=1 by 1 while (i <=NumDays);
			Days[Previous_SumDays + i]=Dose_StartDate + (i -1);
			Dose[Previous_SumDays + i]=New_Dosage;
			THB[Previous_SumDays + i]=NumTakeHome;
			SHWP[Previous_SumDays + i] = SHWPhase;
			ClinicP[Previous_SumDays + i] = ClinicPhase;
			EpiCount[Previous_SumDays + i] = SumEpisodes;
			Comment[Previous_SumDays + i] = PhysicianComments;
			Drug[Previous_SumDays + i] = Drug_Name;
		end;
		
		format Days1-Days5000 MMDDYY10.;

		if eof then do;
			RENAME SumDays = NumDaysDoseObserved Episodes_SumDays = NumDaysTx;
			keep ID DOSE_PatientID CURRENT Extraction_Date Consent_Date Episodes_SumDays 
			SumDays SumEpisodes Days1-Days5000 Dose1-Dose5000 THB1-THB5000 
			ClinicP1-ClinicP5000 SHWP1-SHWP5000 EpiCount1-EpiCount5000 Comment1-Comment5000
			Drug1-Drug5000; 
			output TEMPFILE.SEQUENCE_&id.;
		end;
	run;
	
	proc append base = METHADOS.master_spctlc data = TEMPFILE.sequence_&id. FORCE;
	run;

	proc append base = METHADOS.master_all data = TEMPFILE.sequence_&id. FORCE;
	run;


%MEND TLCIMPORT;



	/**** Since we are able to use a Macro that has a keyword parameter for ID, and the standerdize approach of **/
PROC IMPORT OUT=METHADOS.import_SPC_new
   DATAFILE="C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\SPC Extracts v2021Jun14/SPC_ScriptHistory_v2021Sep30.xlsx" 
	DBMS=XLSX REPLACE;
	GETNAMES=YES;
	DATAROW=2;
RUN;

	

	
data METHADOS.import_SPC;
		set METHADOS.import_SPC_new end = eof;
		FORMAT Dose_StartDate Dose_endDate MMDDYY10.;
		Dose_SEQNUM=INPUT(SEQNUM,20.);
		Dose_PATIENTID=INPUT(PATIENTID,20.);
		Dose_EPISODESEQNUM=INPUT(EPISODESEQNUM,20.);
		Dose_SCRIPTTYPEID=INPUT(SCRIPTTYPEID,$20.);
		Dose_DOCTORID=INPUT(DOCTORID,$20.);
		Dose_ENTEREDBYID=INPUT(ENTEREDBYID,$20.);
		Dose_POSTEDBYID=INPUT(POSTEDBYID,$20.);
		Dose_DOSAGE=INPUT(DOSAGE,20.);
		Dose_TWODAYDOSAGE=INPUT(TWODAYDOSAGE,20.);
		Dose_THREEDAYDOSAGE=INPUT(THREEDAYDOSAGE,20.);
		Dose_FOURDAYDOSAGE=INPUT(FOURDAYDOSAGE,20.);
		If SPLITFIRSTDOSAGE = "null" then Dose_SPLITFIRSTDOSAGE = .N;
			else Dose_SPLITFIRSTDOSAGE=INPUT(SPLITFIRSTDOSAGE,20.);
		Dose_SPLITISTAKEHOMEFLAG=INPUT(SPLITISTAKEHOMEFLAG,$20.);
		Dose_TAKEHOME=INPUT(TAKEHOME,$20.);
		Dose_AWLTYPEID=INPUT(AWLTYPEID,$20.);
		If TAKEHOMESUPPLY  = "null" then Dose_TAKEHOMESUPPLY = .N;
			else Dose_TAKEHOMESUPPLY=INPUT(TAKEHOMESUPPLY,20.);
		Dose_POSTEDFLAG=INPUT(POSTEDFLAG,$20.);
		If DAYSINCYCLE  = "null" then Dose_DAYSINCYCLE = .N;
			else Dose_DAYSINCYCLE=INPUT(DAYSINCYCLE,20.);
		Dose_DETOXFLAG=INPUT(DETOXFLAG,$20.);
		Dose_FINANCIALFLAG=INPUT(FINANCIALFLAG,$20.);
		Dose_STARTAT=INPUT(STARTAT,20.);
		Dose_STARTATPERCENTAGEFLAG=INPUT(STARTATPERCENTAGEFLAG,$20.);
		Dose_STOPAT=INPUT(STOPAT,20.);
		Dose_STOPATPERCENTAGEFLAG=INPUT(STOPATPERCENTAGEFLAG,$20.);
		Dose_BYPERCENTAGESFLAG=INPUT(BYPERCENTAGESFLAG,$20.);
		Dose_INCREMENT1=INPUT(INCREMENT1,20.);
		Dose_INCREMENT2=INPUT(INCREMENT2,20.);
		Dose_INCREMENT3=INPUT(INCREMENT3,20.);
		Dose_INCREMENT4=INPUT(INCREMENT4,20.);
		Dose_INCREMENT5=INPUT(INCREMENT5,20.);
		Dose_INCREMENT6=INPUT(INCREMENT6,20.);
		Dose_INCREMENT7=INPUT(INCREMENT7,20.);
		Dose_INCREMENT8=INPUT(INCREMENT8,20.);
		Dose_INCREMENT9=INPUT(INCREMENT9,20.);
		Dose_INCREMENT10=INPUT(INCREMENT10,20.);
		Dose_INCREMENT11=INPUT(INCREMENT11,20.);
		Dose_INCREMENT12=INPUT(INCREMENT12,20.);
		Dose_INCREMENT13=INPUT(INCREMENT13,20.);
		Dose_INCREMENT14=INPUT(INCREMENT14,20.);
		Dose_INCREMENT15=INPUT(INCREMENT15,20.);
		Dose_INCREMENT16=INPUT(INCREMENT16,20.);
		Dose_INCREMENT17=INPUT(INCREMENT17,20.);
		Dose_INCREMENT18=INPUT(INCREMENT18,20.);
		Dose_INCREMENT19=INPUT(INCREMENT19,20.);
		Dose_INCREMENT20=INPUT(INCREMENT20,20.);
		Dose_INCREMENT21=INPUT(INCREMENT21,20.);
		Dose_INCREMENT22=INPUT(INCREMENT22,20.);
		Dose_INCREMENT23=INPUT(INCREMENT23,20.);
		Dose_INCREMENT24=INPUT(INCREMENT24,20.);
		Dose_INCREMENT25=INPUT(INCREMENT25,20.);
		Dose_INCREMENT26=INPUT(INCREMENT26,20.);
		Dose_INCREMENT27=INPUT(INCREMENT27,20.);
		Dose_INCREMENT28=INPUT(INCREMENT28,20.);
		Dose_INCREMENT29=INPUT(INCREMENT29,20.);
		Dose_INCREMENT30=INPUT(INCREMENT30,20.);
		Dose_NURSESIGNATURESEQNUM=INPUT(NURSESIGNATURESEQNUM,$20.);
		Dose_DOCTORSIGNATURESEQNUM=INPUT(DOCTORSIGNATURESEQNUM,$20.);
		Dose_CANCELLEDBYID=INPUT(CANCELLEDBYID,$20.);
		Dose_MEDICALNOTE=INPUT(MEDICALNOTE,$1000.);
		Dose_AMENDMENT=INPUT(AMENDMENT,$20.);
		Dose_AMENDSIGNATURESEQNUM=INPUT(AMENDSIGNATURESEQNUM,$20.);
		Dose_INCREMENTSCHEDULETYPE=INPUT(INCREMENTSCHEDULETYPE,$20.);
		Dose_INCSCHEDULEREASON=INPUT(INCSCHEDULEREASON,$20.);
		Dose_NUMOFALLOWEDTKHAFTERHOL=INPUT(NUMOFALLOWEDTKHAFTERHOL,$20.);
		Dose_WHENPRINTED=INPUT(WHENPRINTED,$20.);
		Dose_FIRSTORDERFLAG=INPUT(FIRSTORDERFLAG,$20.);
		Dose_DRFIRSTID=INPUT(DRFIRSTID,$20.);
		Dose_ISPICKUPONCLINICCLOSEDFLAG=INPUT(ISPICKUPONCLINICCLOSEDFLAG,$20.);
		Dose_MEDICATIONID=INPUT(MEDICATIONID,$100.);


		/** if ScriptStarts EQ "null" OR ScriptStarts EQ "NULL" then Dose_StartDate=.M;
		else do;
			ScriptStart_temp1 = INT(INPUT(ScriptStarts,10.));
			Dose_StartDate = ScriptStart_temp1 - 21916;
		end; **/

		Dose_StartDate = ScriptStarts;

		if ScriptExpires EQ "null" OR ScriptExpires EQ "NULL" then Dose_EndDate=.M;
		else do;
			ScriptExpires_temp1 = INT(INPUT(ScriptExpires,10.));
			Dose_EndDate = ScriptExpires_temp1 - 21916;
		end;
		/** CORRECTION 3-14-19: Change end dates if missing AND EOF to current date of extraction - assigned to Dec 31 2018 **/

		*if Dose_EndDate = . and eof then Dose_EndDate = "31Dec2018"D;
		
				
		/** When Canelled occurs if before the start of the observation, a physician cancels it and it no longer
		goes into effect **/

		if WHENCANCELLED EQ "null" OR WHENCANCELLED EQ "NULL" then Dose_WhenCancelled=.N;
		else do;
			WHENCANCELLED_temp1 = INT(INPUT(WHENCANCELLED,10.));
			Dose_WhenCancelled = WHENCANCELLED_temp1 - 21916;
		end;
		/*** SAS will import dummy obs sometimes, so just delete that observation because if there isn't
		a Dose_SeqNum there is no record ***/
		if Dose_SeqNum = . THEN DELETE; 

		keep Dose_SEQNUM    
			Dose_PATIENTID    
			Dose_EPISODESEQNUM    
			Dose_SCRIPTTYPEID    
			Dose_DOCTORID    
			Dose_ENTEREDBYID    
			Dose_POSTEDBYID    
			Dose_DOSAGE    
			Dose_TWODAYDOSAGE    
			Dose_THREEDAYDOSAGE    
			Dose_FOURDAYDOSAGE    
			Dose_SPLITFIRSTDOSAGE    
			Dose_SPLITISTAKEHOMEFLAG    
			Dose_TAKEHOME    
			Dose_AWLTYPEID    
			Dose_TAKEHOMESUPPLY    
			Dose_POSTEDFLAG    
			Dose_DAYSINCYCLE    
			Dose_DETOXFLAG    
			Dose_FINANCIALFLAG    
			Dose_STARTAT    
			Dose_STARTATPERCENTAGEFLAG    
			Dose_STOPAT    
			Dose_STOPATPERCENTAGEFLAG    
			Dose_BYPERCENTAGESFLAG    
			Dose_INCREMENT1
			Dose_INCREMENT2    
			Dose_INCREMENT3    
			Dose_INCREMENT4    
			Dose_INCREMENT5    
			Dose_INCREMENT6    
			Dose_INCREMENT7    
			Dose_INCREMENT8    
			Dose_INCREMENT9    
			Dose_INCREMENT10    
			Dose_INCREMENT11    
			Dose_INCREMENT12    
			Dose_INCREMENT13    
			Dose_INCREMENT14    
			Dose_INCREMENT15    
			Dose_INCREMENT16    
			Dose_INCREMENT17    
			Dose_INCREMENT18    
			Dose_INCREMENT19    
			Dose_INCREMENT20    
			Dose_INCREMENT21    
			Dose_INCREMENT22    
			Dose_INCREMENT23    
			Dose_INCREMENT24    
			Dose_INCREMENT25    
			Dose_INCREMENT26    
			Dose_INCREMENT27    
			Dose_INCREMENT28    
			Dose_INCREMENT29    
			Dose_INCREMENT30    
			Dose_NURSESIGNATURESEQNUM    
			Dose_DOCTORSIGNATURESEQNUM    
			Dose_CANCELLEDBYID    
			Dose_MEDICALNOTE                                                          
			Dose_AMENDMENT    
			Dose_AMENDSIGNATURESEQNUM    
			Dose_INCREMENTSCHEDULETYPE    
			Dose_INCSCHEDULEREASON    
			Dose_NUMOFALLOWEDTKHAFTERHOL    
			Dose_WHENPRINTED              
			Dose_FIRSTORDERFLAG    
			Dose_DRFIRSTID    
			Dose_ISPICKUPONCLINICCLOSEDFLAG    
			Dose_MEDICATIONID
			Dose_StartDate
			Dose_EndDate
			Dose_WhenCancelled;
	run; 
	

	
proc sort data = METHADOS.import_SPC;
		by Dose_PATIENTID;
run;

data METHADOS.datatomerge_spc;
	set METHADOS.datatomerge;

	if ID =: "SPC";
run;

proc sort data = METHADOS.datatomerge_spc;
	by Dose_PatientID;
run;

data METHADOS.import_SPC_merged;
		merge METHADOS.datatomerge_spc METHADOS.import_SPC;
		by Dose_PATIENTID;
		
		if ID =: "SPC" and Dose_PatientID = . then do;
			PUTLOG "The following ID number is not in this database: " ID " and there for will be deleted in this database."
			DELETE;
		end;
		if ID =: "TLC" OR ID =: "JSA" then DELETE;
	run;
		

PROC IMPORT OUT=METHADOS.Episodes_SPC
		DATAFILE="C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\SPC Extracts v2021Jun14/SPC_Episodes_v2021Sep30.xlsx" 
		DBMS=XLSX REPLACE;
		GETNAMES=YES;
RUN;
	
proc contents data = METHADOS.episodes_SPC;
run;
	/** STEP1: Import all the variables into SAS, and account for Datesm **/
data METHADOS.Episodes_SPC;
		FORMAT Episodes_DateAdmit Episodes_DateDischarge MMDDYY10.;
		set METHADOS.Episodes_SPC;
		*Dose_EpisodeSeqNum = INPUT(SEQNUM,6.);
		*Dose_PatientID = INPUT(PATIENTID,5.);
		*Episodes_CURRENTFLAG=INPUT(CURRENTFLAG,$8.);
		*Episodes_TXUNITID=INPUT(TXUNITID,$8.);
		*Episodes_LEVELOFCAREID= INPUT(LEVELOFCAREID, $8.);
		*Episodes_DischargeReason = INPUT(dischargeorreferreason, $300.);
		
		if VTYPE(ADMITPOSTED) = "N" then Episodes_AdmitPosted = ADMITPOSTED;
		else Episodes_AdmitPosted = INPUT(SUBSTR(ADMITPOSTED,1,10), YYMMDD10.);
		
		if VTYPE(ADMITDATE) = "N" then do;
			Episodes_DateAdmit = ADMITDATE;
		end;
		else do;
			if ADMITDATE IN ("00:00.0","null") then do;
				Episodes_DateAdmit = .E;
				putlog "WARNING!: No AdmitDate for Treatment Episode: " Dose_EpisodeSeqNum " in Database for Clinic ID: " Dose_PatientID " Contact Clinic for further information and instructions. Subsequent Analysis will fail!"; 
			end;
			else do;
				DischargePOSTED_temp = INT(INPUT(DischargePOSTED,10.));
				Episodes_DischargePosted = DischargePOSTED_temp - 21916;
			end;
		end;
		
		if VTYPE(DischargePosted) = "N" then Episodes_DischargePosted = DischargePOSTED;
		else do;
			if DischargePOSTED IN ("00:00.0","null") then do;
				Episodes_DischargePosted = .C;
			end;
			else do;
				DischargePOSTED_temp = INT(INPUT(DischargePOSTED,10.));
				Episodes_DischargePosted = DischargePOSTED_temp - 21916;
			end;
		end;


		
		if VTYPE(DISCHARGEDATE) = "N" then do;
			Episodes_DateDischarge = DISCHARGEDATE;
		end;
		else do;
			if DISCHARGEDATE IN ("00:00.0","null") then do;
				Episodes_DateDischarge = .C;
				putlog "WARNING!: CURRENT TREATMENT!! No DischargeDate for Treatment Episode : " Dose_EpisodeSeqNum " in Database for Clinic ID: " Dose_PatientID; 
			end;
			else do;
				DISCHARGEDATE_temp = INT(INPUT(DISCHARGEDATE,10.));
				Episodes_DateDischarge = DISCHARGEDATE_temp - 21916;
			end;
		end;
	
		*if Dose_PATIENTID = . THEN DELETE;
		*else if Dose_EpisodeSeqNum = . THEN DELETE;

		RENAME admittypeid = Episodes_AdmitTypeID 
				dischargetypeid = Episodes_DischargeTypeID
				PatientID = Dose_PatientID
				SeqNum = Dose_EpisodeSeqNum
				CURRENTFLAG = Episodes_CURRENTFLAG
				levelofcareid = Episodes_LevelofCareID
				txunitid = Episodes_TxUnitID
				dischargeorreferreason = Episodes_DischargeReason; 
		LABEL Episodes_DateDischarge = " "
			  Episodes_DischargePosted = " "
			  Episodes_DateAdmit = " "
			  Episodes_AdmitPosted = " "
			  Episodes_LEVELOFCAREID = " "
			  Episodes_TXUNITID = " "
			  Episodes_CURRENTFLAG = " "
			  Dose_PatientID = " "
			  Dose_EpisodeSeqNum = " ";
		DROP DischargePosted_temp DischargeDate_temp;
run;

	/*** REDO IMPORT WITH EPISODES AND THEN DO THE WHERE STATEMENTS ****/
proc sort data = METHADOS.Episodes_SPC out = METHADOS.Episodes_SPC_sorted;
		by Dose_PatientID;
run;

data METHADOS.Episodes_SPC_merged;
		merge METHADOS.datatomerge_spc METHADOS.Episodes_SPC_sorted;
		by Dose_PATIENTID;
run;



%MACRO SPCIMPORT(ID=);

	data import_&ID.;
		set METHADOS.import_SPC_merged (where = (ID = "&ID."));
	run;
	
	data episodestemp_&ID.;
		set METHADOS.episodes_SPC_merged (where = (ID = "&ID."));
	run;

	proc sort data = episodestemp_&id. out = episodes2_&id.;
		by Episodes_DateAdmit;
	run;

	/*** Code below is done not to eliminate episodes but to deal with adjacent episodes.
	For example, subjects might have been transferred into different programs (due to funding status or the like)
	and the clinics discharge them from their current program into a new program in the same clinic and they
	receive the same dose. So we look ahead and look backwards to see if there are episodes as such and code
	BOTH episodes for the same admit and discharge.

	The goal for us is to be able to merge the admit/discharge data into the process datasets seen below by the
	EpisodeSeqNum (the unique identifer for an episode) without losing any data ***/
	proc sort data = episodestemp_&id.;
		by Episodes_DateAdmit Episodes_DateDischarge;
	run;
		
	/*** The key is to go right to an array first using the standard code that I used before ***/
	data episodes1a_&id.;
		set episodestemp_&id.;
		retain Number 0;
		if Episodes_DateAdmit = Episodes_DateDischarge THEN DELETE;
		Number + 1;
		ID = symget('ID');
		RENAME Dose_EpisodeSeqNum =  EpisodeSeqNumtemp
			   Episodes_DateAdmit = DateAdmittemp
			   Episodes_DateDischarge = DateDischargetemp
			   Episodes_AdmitTypeID = AdmitTypeIDtemp 
			   Episodes_DischargeTypeID = DischargeTypeIDtemp
			   Episodes_DischargeReason = DischargeReasontemp;
		keep Number Dose_PatientID Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge Episodes_AdmitTypeID Episodes_DischargeTypeID Episodes_DischargeReason;
	run;
	
	/*** The temporary array to check for internal transfers will drop the term Episodes, since Episodes emplies that this is complete. When we use the prefix Episodes
	it implies that the data good to go and merge, in this case not ***/
	
	data EpisodesArrayMatch_&ID.;
		set episodes1a_&id. end = eof;
		array EpisodeSeqNum[30];
		array DateAdmit[30];
		array DateDischarge[30];
		array AdmitTypeID[30] $ 5;
		array DischargeTypeID[30] $ 5;
		array DischargeReason[30] $ 300;

		FORMAT DateAdmit1-DateAdmit30 DateDischarge1-DateDischarge30 MMDDYY10.;

		retain EpisodeSeqNum1-EpisodeSeqNum30 
			   DateAdmit1-DateAdmit30
			   DateDischarge1-DateDischarge30
			   AdmitTypeID1-AdmitTypeID30
			   DischargeTypeID1-DischargeTypeID30
			   DischargeReason1-DischargeReason30;

		/*** Ascertain why did I do this again?: Makes no sense, I is being incremented, 
			Actually if it ain't broken, don't fix it ***/
			
		do i = 1 to 15;
			EpisodeSeqNum[number] = EpisodeSeqNumtemp;
			DateAdmit[number] = DateAdmittemp;
			DateDischarge[number] = DateDischargetemp;
			AdmitTypeID[number] = AdmitTypeIDtemp;
			DischargeTypeID[number] = DischargeTypeIDtemp;
			DischargeReason[number] = DischargeReasontemp;
		end;
		
		if eof then do;
			ID = symget('ID');
			DROP  DateAdmittemp DateDischargetemp  AdmitTypeIDtemp DischargeTypeIDtemp DischargeReasontemp;
			output EpisodesArrayMatch_&ID.;
		end;
	run;
	
	data EpisodesArrayMatch2_&ID.;
		set EpisodesArrayMatch_&ID.;
		
		array EpisodeSeqNum[30];
		array DateAdmit[30];
		array DateDischarge[30];
		array AdmitTypeID[30] $ 5;
		array DischargeTypeID[30] $ 5;
		array DischargeReason[30] $ 300;
		array EpisodeCounttemp[30];
		
		EpisodeCounttemp[1] = 1;
		/*** Updated the DischargeDates for the latest entry****/
		do i = 1 to Number;	
			if DateDischarge[i] = DateAdmit[i+1] then do;
				/*** Current Admit = NExt ADMIT **/
				DateAdmit[i+1] = DateAdmit[i];
				AdmitTypeID[i+1] = AdmitTypeID[i];
				DateDischarge[i] = DateDischarge[i+1];
				if EpisodeCounttemp[i] = 1 then EpisodeCounttemp[i+1] = 0;
				else if EpisodeCounttemp[i] = . then do;
					EpisodeCounttemp[i] = 0;
					EpisodeCounttemp[i+1] = 0;
				end;
				else if EpisodeCounttemp[i] = 0 then EpisodeCounttemp[i+1] = 0;
			end;
			else if DateDischarge[i] NE DateAdmit[i+1] then do;
				EpisodeCounttemp[i] = 1;
				EpisodeCounttemp[i+1] = 1;
			end;
		end;
		
		/*** Since the admits are all good, we need to backtrack for the discahrges ****/
		do z = Number to 2 by (-1);
			if DateAdmit[z] = DateAdmit[z-1] then do;
				/*** If the dates are the same, then the last discharge = the first discharge ***/
				DateDischarge[z-1] = DateDischarge[z];
				DischargeTypeID[z-1] = DischargeTypeID[z];
				DischargeReason[z-1] = DischargeReason[z];
				EpisodeCounttemp[z] = 0;
			end;
		end;
	run;	

	data episodes2_&id.;
		set EpisodesArrayMatch2_&ID.;
		
		array EpisodeSeqNum[30];
		array DateAdmit[30];
		array DateDischarge[30];
		array AdmitTypeID[30] $ 5;
		array DischargeTypeID[30] $ 5;
		array DischargeReason[30] $ 300;
		array EpisodeCounttemp[30];

		
		do i = 1 to Number;
			Dose_EpisodeSeqNum = EpisodeSeqNum[i];
			Episodes_DateAdmit = DateAdmit[i];
			Episodes_AdmitTypeID = AdmitTypeID[i];
			Episodes_DateDischarge = DateDischarge[i];
			Episodes_DischargeTypeID = DischargeTypeID[i];
			Episodes_DischargeReason = DischargeReason[i];
			Episode_NumDays = DateDischarge[i] - DateAdmit[i];
			EpisodeCount = EpisodeCounttemp[i];
			output episodes2_&id.;
		end;
		 
		KEEP Dose_PATIENTID Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_AdmitTypeID Episodes_DateDischarge Episodes_DischargeTypeID Episodes_DischargeReason EpisodeCount;
	run;
	/*** Code below is done not to eliminate episodes but to deal with adjacent episodes.
	For example, subjects might have been transferred into different programs (due to funding status or the like)
	and the clinics discharge them from their current program into a new program in the same clinic and they
	receive the same dose. So we look ahead and look backwards to see if there are episodes as such and code
	BOTH episodes for the same admit and discharge.
	The goal for us is to be able to merge the admit/discharge data into the process datasets seen below by the
	EpisodeSeqNum (the unique identifer for an episode) without losing any data ***/
	data episodes3_&id.;
		set episodes2_&id.;
		
		if Episodes_DateAdmit = . then DELETE;
		
		retain Episodes_SumDays;
		retain SumEpisodes 0;
		
		/** We want to be able to figure out the Number of Days in Treatment (in the Analysis Dataset as NumDaysTx) and the
		number of episodes - number of concurrent times in treatment that a subject has stayed */
		if EpisodeCount = 1 AND Episodes_DateDischarge NE .C then Episodes_NumDays = Episodes_DateDischarge - Episodes_DateAdmit;
		else if EpisodeCount = 0 then Episodes_NumDays = 0;
		
		if Episodes_DateDischarge = .C then Episodes_NumDays = "05Apr2021"D - Episodes_DateAdmit;

		if EpisodeCount = 1 then Episodes_SumDays + Episodes_NumDays;
		else if EpisodeCount = 0 then Episodes_SumDays = Episodes_SumDays;

		SumEpisodes + EpisodeCount;	
		
		if eof then do;
				CALL SYMPUTX('FinSumDays',Episodes_SumDays);
				CALL SYMPUTX('FinSumEpi',SumEpisodes);
		end;
		KEEP Dose_PatientID Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_AdmitTypeID Episodes_DateDischarge Episodes_DischargeTypeID Episodes_DischargeReason SumEpisodes EpisodeCount  Episodes_NumDays Episodes_SumDays;
	run;


	%if %symexist(FinSumDays) = 0 %then %let FinSumDays = .;
	%if %symexist(FinSumEpi) = 0 %then %let FinSumEpi = .;
	
	data episodesforlong_&id.;
		set episodes3_&id.;
		FORMAT Episodes_DateAdmit Episodes_DateDischarge MMDDYY10.;
		ID = symget('ID');
	run;
	
	proc append base = METHADOS.episodeslong data = episodesforlong_&id. FORCE;
	run;

	
	data EpisodesTEMPArray_&ID.;
		set episodes3_&id.;
		if EpisodeCount = 0 then DELETE;
		retain Number 0;
		Number + 1;
		RENAME Dose_EpisodeSeqNum =  Dose_EpisodeSeqNumtemp
			   Episodes_DateAdmit = Episodes_DateAdmittemp
			   Episodes_DateDischarge = Episodes_DateDischargetemp
			   Episodes_NumDays = Episodes_NumDaystemp
			   Episodes_AdmitTypeID = Episodes_AdmitTypeIDtemp 
			   Episodes_DischargeTypeID = Episodes_DischargeTypeIDtemp
			   Episodes_DischargeReason = Episodes_DischargeReasontemp;
		keep Number Dose_PatientID SumEpisodes Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge Episodes_NumDays Episodes_AdmitTypeID Episodes_DischargeTypeID Episodes_DischargeReason;
	run;
	
	/*** Assuming no more than 10 episodes, and you will receive a ARRAY ERROR if it is over 10 and you should
	act accordingly ***/
	data METHADOS.Episodes_&ID.;
		set EpisodesTEMPArray_&ID. end = eof;
		array Dose_EpisodeSeqNum[15];
		array Episodes_DateAdmit[15];
		array Episodes_DateDischarge[15];
		array Episodes_NumDays[15];
		array Episodes_AdmitTypeID[15] $ 5;
		array Episodes_DischargeTypeID[15] $ 5;
		array Episodes_DischargeReason[15] $ 300;

		FORMAT Episodes_DateAdmit1-Episodes_DateAdmit15 Episodes_DateDischarge1-Episodes_DateDischarge15 MMDDYY10.;

		retain Dose_EpisodeSeqNum1-Dose_EpisodeSeqNum15 
			   Episodes_DateAdmit1-Episodes_DateAdmit15
			   Episodes_DateDischarge1-Episodes_DateDischarge15
			   Episodes_NumDays1-Episodes_NumDays15
			   Episodes_AdmitTypeID1-Episodes_AdmitTypeID15
			   Episodes_DischargeTypeID1-Episodes_DischargeTypeID15
			   Episodes_DischargeReason1-Episodes_DischargeReason15;

		do i = 1 to 15;
			Dose_EpisodeSeqNum[number] = Dose_EpisodeSeqNumtemp;
			Episodes_DateAdmit[number] = Episodes_DateAdmittemp;
			Episodes_DateDischarge[number] = Episodes_DateDischargetemp;
			Episodes_NumDays[number] = Episodes_NumDaystemp;
			Episodes_AdmitTypeID[number] = Episodes_AdmitTypeIDtemp;
			Episodes_DischargeTypeID[number] = Episodes_DischargeTypeIDtemp;
			Episodes_DischargeReason[number] = Episodes_DischargeReasontemp;
		end;

		if eof then do;
			ID = symget('ID');
			DROP Dose_EpisodeSeqNumtemp Number  i Episodes_DateAdmittemp Episodes_DateDischargetemp Episodes_NumDaystemp Episodes_AdmitTypeIDtemp Episodes_DischargeTypeIDtemp Episodes_DischargeReasontemp;
			output METHADOS.Episodes_&ID.;
		end;
	run;
	
	/** Recommended Technique by SAS to iteratively appending datasets **/
	
	proc append base = METHADOS.Episodes_all data = METHADOS.Episodes_&id. FORCE;
	run;

	
	/*** The following code takes a macro variable that was initialized in Episodes 2 and puts it back into Episodes 4 so EACH observation now
	includes the Total Number of Days in Tx and how many stays in tx */
	data episodes4_&id.;
		set episodes3_&id. end = last;
		Episodes_NumDays = Episodes_DateDischarge - Episodes_DateAdmit;
	run;
	
	proc sort data = episodes4_&id.;
		by Dose_EpisodeSeqNum;
	run;
	
	/************* CHECKING FOR ID NUMBERS **************************/
	data _NULL_;
		merge import_&id. episodes4_&id. (in = inEpisode);
		by Dose_PatientID;
		if inEpisodes = 0 then do;
				PUTLOG "Episodes File ID num does not match in Import File for &ID. do not have the same ID - REIMPORT";
				Episodes_DateDischarge = .M;
		end;
	run;

	/*** For future purposes: We should find a way to terminate the execution of the macro in the case where
	the ID numbers for both the Import File and Episodes File are not Equal since the file would not be correct
	to use in this situation */

	/* Merging all Import and Episodes Data */
	data process_&id.;
		merge import_&id. (in = inImport) episodes4_&id. (in = inEpisode);
		by Dose_EpisodeSeqNum;

		/*** Modification 3/21/2020: we need to get the Study Subject ID into the database ASAP so we can merge with other databases to help with the processing **/
		ID = symget('ID');			
		/* The reason for this was a trial run in understanding how to check ID numbers between Episodes and ScriptHistory
		files. This initial attempt failed to do so accurately and was done in the above data _NULL_ step */
		/* if inEpisodes = 0 then do;
				PUTLOG "Episodes File ID num does not match in Import File for &ID. do not have the same ID - REIMPORT";
				Episodes_DateDischarge = .M;s
		end; */
	run;
 	
									   
		
	 
	
	data process_&id.;
		set process_&ID.;
		
								 
		if Dose_EndDate = . AND Episodes_DateDischarge = .C then Dose_EndDate = Extraction_Date;
		if Dose_EndDate > Extraction_Date then Dose_EndDate = Extraction_Date;

	run;

	data processa_&id.;
		set process_&id.;
		if Dose_EndDate = .M then Dose_EndDate = Extraction_Date;
		format Dose_Increment1-Dose_Increment30 3.;
		array Dose_Increment[*] Dose_Increment1-Dose_Increment30;
		*Required so we can calc incrmental increases or decreases;
		format New_Dosage 10.;
				length Dose_ChangeType $ 40;
		LENGTH Phase $ 2;
		LENGTH PhysicianComments $ 1000;
		FORMAT Dose_StartDate Dose_EndDate PreviousDoseStartDate PreviousDoseEndDate MMDDYY10.;
		retain PreviousDose PreviousDoseStartDate PreviousDoseEndDate;
		retain DoseChangeCount 0;
		*Retained so we can get previous;
		if Dose_whencancelled NE .N then delete;
		/*Not really sure if I need InitialR and InitialT at this point because I already accounted
		for the dates in the "LEAD" function that was generated */
		*************************************** CLASSIFICATION OF CHANGES IN DOSE****************************************;

		/*Using Regimen Dose we need to retain this value for subsequent take home quantity
		measurements, not sure if they do this ALL TIMES, but it seemes consistent from
		what I'm seeing*/

		if Dose_SCRIPTTYPEID="R" then
			do;
				if Dose_EndDate = .M then Dose_EndDate = Extraction_Date;
				if DoseChangeCount = 0 then DoseChangeCount = 1;
				else if DoseChangeCount > 0 then DoseChangeCount + 1;
				Dose_Changetype="Regimen Dose";
				/*** TO ACCOUNT FOR situation like TLC7246, go ahead and delete the record 
				and put a putlog statement out to indicate ***/
				if Dose_Dosage = 0 then do;
					PUTLOG "Observation Number: " _N_ " for ID: " ID " indicates a dose of 0 given, this
							observation has been deleted and disregarded";
					DELETE;
				end;

				New_Dosage=Dose_DOSAGE;
				PreviousDose=Dose_DOSAGE;
				PreviousDoseEndDate = Dose_EndDate;
										 
				PreviousDoseStartDate = Dose_StartDate;
				PhysicianComments = Dose_MedicalNote;				   
				*NumTakeHome=MAX(PreviousTHB, NumTakeHome);
				*if Phase=" " then
					Phase=PreviousPhase;
				output processa_&id.;
			end;
		/* We will decipher phase from this step, I think the best logic would be
		to keep this one as the main one for analysis as we do see the change in takehomes
		in time. THe problem is that we have to account when their dose has changed. So what
		we will probably do is retain the end date and make sure that they coencide with each
		other and the dose. */

		if Dose_SCRIPTTYPEID = "T" then output processa_&id.;

		if Dose_SCRIPTTYPEID = "W" then output processa_&id.;

		if dose_ScriptTypeID="I" then
		do;
				if Dose_EndDate = .M then Dose_EndDate = Extraction_Date;
				Dose_changetype="Incremental Increase";
				EndDate_temp = Dose_EndDate;
				StartDate_temp = Dose_StartDate;
				New_Dosage=Dose_DOSAGE;
				*NumTakeHome = PreviousTHB;
				*if NumTakeHome = . then NumTakeHome = .N;
				FORMAT StartDate_temp EndDate_temp MMDDYY10.;
				PhysicianComments = Dose_MedicalNote;
				Diff_Dose= Dose_StopAt - Dose_StartAt;
										 
				
				/** Checked with Christie Hanvey @ SPC, she explained that they would not increment in the system w/ a Dose_DaysinCycle being equal to 0
				the result is we delete the record completely. May need a PUTLOG statement for the coder to see this **/	
				if Dose_DaysinCycle = 0 then Delete;

				c = 0;
				
				array dayofincrement[30];
				array incrementin[30];
				array incrementby[30];
				
				do i = 1 by 1 to dim(Dose_Increment);
					if Dose_Increment[i] NE 0 then c = c + 1;
				end;
				/*** This occurs during Buildup ***/
				if c = 1 AND dose_increment[dose_daysincycle] NE 0 then do;
					if Dose_StopAt - Dose_StartAt > 0 then DO;
						do WHILE ((New_Dosage <= Dose_StopAt) AND (Dose_StartDate + Dose_daysincycle <= EndDate_temp));
							dose_startdate = StartDate_temp;
							dose_endDate = dose_startdate + dose_daysincycle - 1;
							if New_Dosage = Dose_StopAt then Dose_EndDate = EndDate_temp;
							PUTLOG "i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp; 
							DoseChangeCount + 1;
							output processa_&id.;
							PreviousDose = New_Dosage;
							new_dosage = new_Dosage + dose_increment[dose_daysincycle];
							StartDate_temp = dose_enddate + 1;
							/* Need to add new condition for if the cycle restarts - would need to look at SPC4747 code to determine procedure */
						end;
						PUTLOG "FINAL i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate;
					end;
					else if Dose_StopAt - Dose_StartAt < 0 then do;
						do WHILE ((New_Dosage >= Dose_StopAt) AND (Dose_StartDate + Dose_daysincycle <= EndDate_temp));
							dose_startdate = StartDate_temp;
							dose_endDate = dose_startdate + dose_daysincycle - 1;
							if New_Dosage = Dose_StopAt then Dose_EndDate = EndDate_temp;
							PUTLOG "i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp; 
							DoseChangeCount + 1;
							output processa_&id.;
							PreviousDose = New_Dosage;
							new_dosage = new_Dosage - dose_increment[dose_daysincycle];
							StartDate_temp = dose_enddate + 1;
							/* Need to add new condition for if the cycle restarts - would need to look at SPC4747 code to determine procedure */
						end;
						PUTLOG "FINAL i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate;
					end;
				end;	
				/*** This occurs during detox/decrease of dose***/
					
				z = 0;
				
				/*** We start to deal with subjects who have more than 1 dose_increment values and need to be looked at seperately ***/
				do i =1 by 1 to dim(Dose_Increment);		
					if Dose_Increment[i] NE 0 then do;
						z = z + 1;
						dayofincrement[z] = i;
						if Dose_StopAt - Dose_StartAt < 0 then incrementby[z+1] = (-1) * Dose_Increment[i];
						else incrementby[z+1] = Dose_Increment[i];
						putlog "Z: " z "IncrementBy[z]: " incrementby[z] " IncrementBy[z+1]: " incrementby[z+1];
					end;
				end;
				
				PUTLOG "z= " Z " C = " c;

				if z NE c then PUTLOG "Number of Days that Dose is Incremented does not equate to array size, data step will fail! Z = " z " AND c = " c;

				/* NEED TO ADD CONDITIONS WHERE IF z = 1 then we can proceed normally and just grab the days in cycle like before */

				
				/* Calculate the Number of Days unitl the next increment so we can easily be able to derive the number of days in a between increments */

				/** *Incrementby = The amount of dose to add to existing doses. Within a single record, we may have more than 1 days by which we increment and that have different
				doses to increment. Example: we increment by 5, and then by 10, and then by 5 again 

				Incrementin = THe number of days between increments, so we may have to increment once by 5 days, and then in another 10 days do another increment, etc. ***/
				
				if z > 1 OR dose_increment[dose_daysincycle] = 0 then do;
				incrementby[1] = 0;
					do i=1 to (c+1) by 1;
						if i = 1 then incrementin[1] = dayofincrement[1];
						else if dayofincrement[i] NE . then incrementin[i] = dayofincrement[i] - dayofincrement[i-1];

						if i = c + 1 AND dayofincrement[i-1] < dose_daysincycle then do;
							incrementin[i] = (dose_daysincycle - dayofincrement[i-1]);
						end;
						PUTLOG "Incrementin: " incrementin[i]  "IncrementBy[i]: " incrementby[i] " IncrementBy[z+1]: " incrementby[i+1];
					end;
					PUTLOG "i: " i "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp "IncrementBy: " incrementby[i]; 
					/*** READ THE DO DOCUMENTATION ****/
					
					i = .;
					PUTLOG "Counter C: " c " New_Dosage: " New_Dosage " Dose_StopAt: " Dose_StopAt " Dose_StartDate: " Dose_StartDate " dose_DaysinCycle: " dose_DaysinCycle " EndDate_temp: " EndDate_temp;
					if Dose_StopAt - Dose_StartAt > 0 then do;
						IncrementCycle = 1;
						do i=1 to (c+1) by 1 WHILE ((New_Dosage <= Dose_StopAt) AND (dose_startdate + incrementin[i] < EndDate_temp));
								dose_startdate = StartDate_temp;
								new_dosage = new_Dosage + incrementby[i];
								if New_Dosage < Dose_StopAt then do;
										if dose_startdate + incrementin[i] < EndDate_temp then dose_endDate = dose_startdate + incrementin[i] - 1;
										else if dose_startdate + incrementin[i] > EndDate_temp then dose_endDate = EndDate_temp;
								end;								
								else if New_Dosage = Dose_StopAt then Dose_EndDate = EndDate_temp;
								PUTLOG "i: " i " IncrementCycle: " IncrementCycle "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp "IncrementBy: " incrementby[i]; 
								DoseChangeCount + 1;
								output processa_&id.;
								if i = (c + 1) AND New_Dosage < Dose_StopAt then do;
									i = 1;
									IncrementCycle = IncrementCycle + 1;
								end;
								PreviousDose = New_Dosage;
								StartDate_temp = dose_enddate + 1;
								/* Need to add new condition for if the cycle restarts - would need to look at SPC4747 code to determine procedure */
						end;
						PUTLOG "FINAL i: " i " IncrementCycle: " IncrementCycle " New_Dosage: " New_Dosage " Dose_StartDate: " Dose_StartDate " Dose_EndDate: " Dose_EndDate;
					end;
					else if Dose_StopAt - Dose_StartAt < 0 then do;
						IncrementCycle = 1;
						do i=1 to (c+1) by 1 WHILE ((New_Dosage >= Dose_StopAt) AND (dose_startdate < EndDate_temp));
								dose_startdate = StartDate_temp;
								new_dosage = new_Dosage + incrementby[i];
								if New_Dosage > Dose_StopAt then do;
										if dose_startdate + incrementin[i] < EndDate_temp then dose_endDate = dose_startdate + incrementin[i] - 1;
										else if dose_startdate + incrementin[i] > EndDate_temp then dose_endDate = EndDate_temp;
								end;
								else if New_Dosage = Dose_StopAt then Dose_EndDate = EndDate_temp;
								PUTLOG "i: " i " IncrementCycle: " IncrementCycle "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate "EndDate_temp: " EndDate_temp "IncrementBy: " incrementby[i]; 
								DoseChangeCount + 1;
								output processa_&id.;
								if i = (c + 1) AND New_Dosage > Dose_StopAt then do;
									i = 1;
									IncrementCycle = IncrementCycle + 1;
								end;								
								PreviousDose = New_Dosage;
								StartDate_temp = dose_enddate + 1;
								/* Need to add new condition for if the cycle restarts - would need to look at SPC4747 code to determine procedure */
						end;
						PUTLOG "FINAL i: " i " IncrementCycle: " IncrementCycle "New_Dosage: " New_Dosage "Dose_StartDate: " Dose_StartDate "Dose_EndDate: " Dose_EndDate;
				end;
			end;
		end;
	run;
	
	proc sort data = processa_&id.;
		by Dose_StartDate;
	run;

	data processb_&id.;
							 
		RETAIN PreviousDose_THB;
		set processa_&id.;	
		if Dose_SCRIPTTYPEID = "I" OR Dose_SCRIPTTYPEID ="R" then PreviousDose_THB = New_Dosage;
		PUTLOG "Dose ScriptType: " Dose_ScripttypeID " New_Dosage from previous dataset: " New_Dosage " Newly Created PreviousDose_THB: " PreviousDose_THB;
	run;

	data process1a_&ID.;
		set processb_&id.;
				FORMAT PreviousTHBStartDate PreviousTHBEndDate MMDDYY10.;
		retain SHWPhase ClinicPhase PreviousPhase PreviousTHB PreviousTHBStartDate PreviousTHBEndDate;
  
				
		
		/* We will decipher phase from this step, I think the best logic would be
		to keep this one as the main one for analysis as we do see the change in takehomes
		in time. THe problem is that we have to account when their dose has changed. So what
		we will probably do is retain the end date and make sure that they coencide with each
		other and the dose. */
	if Dose_SCRIPTTYPEID="T" then do;
				if Dose_EndDate = .M then Dose_EndDate = Extraction_Date;
				Dose_Changetype="Take Home Quantity Change";
				NumTakeHome=Dose_takehomesupply;
				if New_Dosage = . then New_Dosage = PreviousDose_THB;
				else PUTLOG "You messed up somewhere with this new PreviousDose_THB code!";
				PreviousTHB=NumTakeHome;

				/* Declaraing Phases - will be using IRB GRANT DATA */
				if dose_takehomesupply IN (0, 1) then SHWPhase="1";
				else if dose_takehomesupply=2 then	SHWPhase="2";
				else if dose_takehomesupply=3 then	SHWPhase="3";
				else if dose_takehomesupply=4 then	SHWPhase="4";
				else if Dose_takehomesupply=5 then	SHWPhase="5";
				else if dose_takehomesupply=6 then	SHWPhase="6";
				else if dose_takehomesupply=13 then	SHWPhase="6a";
				else if dose_takehomesupply=27 then	SHWPhase="6b";
				
				/****** SPC *********************************/
				/**** Declaring Phases using Clinic System ****/
				if dose_takehomesupply IN (0, 1) then ClinicPhase="1";
				else if dose_takehomesupply IN (2,3) then	ClinicPhase="2";
				else if dose_takehomesupply=4 then	ClinicPhase="3";
				else if dose_takehomesupply=5 then	ClinicPhase="4";
				else if Dose_takehomesupply=6 then	ClinicPhase="5";
				else if dose_takehomesupply=13 then	ClinicPhase="6a";
				else if dose_takehomesupply=27 then	ClinicPhase="6b";
				
				PreviousPhase=ClinicPhase;
				PreviousTHBStartDate =Dose_StartDate;
				PreviousTHBEndDate=Dose_EndDate;
				PhysicianComments=Dose_MEDICALNOTE;
		end;
			
		if Dose_ScripttypeID="W" then do;
				Dose_Changetype="Special Take Home Supply";
				NumTakeHome=Dose_takehomesupply;
				if ClinicPhase = " " then ClinicPhase = PreviousPhase;
				if New_Dosage = . then New_Dosage = PreviousDose_THB;
				else PUTLOG "You messed up somewhere with this new PreviousDose_THB code!";
				PreviousTHBStartDate =Dose_StartDate;
				PreviousTHBEndDate=Dose_EndDate;
				PhysicianComments=Dose_MEDICALNOTE;
		end;
		
		/*** The first condition is never needed since in theory the NumTakeHome for an I/R record will ALWAYS
		be missing since they do not consider that in this type of record ***/
		if Dose_SCRIPTTYPEID IN ("I","R") then do;
			if PreviousTHB NE . AND NumTakeHome NE . then NumTakeHome=MAX(PreviousTHB, NumTakeHome);
			else if PreviousTHB NE . AND NumTakeHome EQ . then NumTakeHome = PreviousTHB;
			else if PreviousTHB EQ . AND NumTakeHOME EQ . then NumTakeHome = .;
			if ClinicPhase=" " then
				ClinicPhase=PreviousPhase;
			PhysicianComments= Dose_MEDICALNOTE;
		end;

	run;
	
	/*** Here we look at previous and look ahead records to make sure that there are no disrepncies between the final dosing records and sequence
	This is strictly to deal with discharges ***/
  	data process2_&id.;
		format Previous_StartDate Previous_EndDate MMDDYY10.;
		merge process1a_&id. end = eof process1a_&id. (KEEP= Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge
			FirstOBs=2 Rename=(Dose_EpisodeSeqNum = Next_EpisodeSeqNum Episodes_DateAdmit = NextAdmit Episodes_DateDischarge = NextDischarge));
		Previous_StartDate=lag1(Dose_StartDate);
		Previous_EndDate=lag1(Dose_EndDate);
		length CURRENT $ 5 ID $ 7;

		if Dose_StartDate = . then DELETE;

				
		/* The data is bad and should not be used since the discharge and admit date is blank ***/
		if Dose_endDate > Episodes_DateDischarge AND (Episodes_DateDischarge NE .C OR Episodes_DateDischarge = .M) 
		AND Dose_PatientID NE 6154 /*TLC____ */ AND Dose_PatientID NE 13253 /*TLC____ */  then do;
				Dose_EndDate = Episodes_DateDischarge;
				PUTLOG "End of Dose Entry is Later than the Date of Discharge for episode, end date of dose has been changed to reflect.";
		end;
		
		/*** ACCOUNTING FOR SITUATIONS LIKE TLC9002 where there last record is I and the end date of dose does not reflect ***/
		*if Dose_EndDate < Episodes_DateDischarge AND EOF AND Dose_ScriptTypeID NE "W" then Dose_EndDate = Episodes_DateDischarge;
		if Dose_EndDate = .M then Dose_EndDate = Extraction_date;

		if Episodes_DateDischarge = .C then CURRENT = "TRUE";
		else CURRENT = "FALSE";
		/*Correction 12/21/2018 - Revamped the determination of NumDays to account for duplicate entries, the situation in TLC where Dose_StartDate for
		TakeHome changes are earlier than the StartDate for regimen dose */
		if dose_episodeseqnum NE Next_EpisodeSeqNum AND (Next_EpisodeSeqNum NE . ) then do;
			output process2_&id;
			Dose_SEQNUM = .D;
			Dose_EpisodeSeqNum = .D;
			Dose_ScriptTypeId = "Z";
			ClinicPhase = "Z";
			SHWPhase = "Z";
			Dose_StartDate = Episodes_DateDischarge + 1;
			Dose_EndDate = NextAdmit - 1; 
			New_Dosage = .D;
			NumTakeHome = .D; 
		end;
		output process2_&id;
		DROP NextAdmit NextDischarge Next_EpisodeSeqNum;
	run;


		
/*** Code to address W records so it can be ouputted in DS **/

/*** NOte: AN output statement just outputs, the PDV remains active with the last 
observation **/

	data process25_&id.;
		merge process2_&id. end = eof process2_&id.
			(KEEP= Dose_StartDate Dose_EndDate New_Dosage PhysicianComments NumTakeHome
					ClinicPhase SHWPhase Dose_ScriptTypeID Dose_ChangeType
			FirstObs=2 
			Rename=(Dose_StartDate=Next_StartDate 
						Dose_EndDate=Next_EndDate 
						Dose_ScriptTypeID = Next_ChangeTypeID
						New_Dosage = Next_Dosage
						PhysicianComments = Next_PhysicianComments
						NumTakeHome = Next_NumTakeHome
						ClinicPhase = Next_ClinicPhase
						SHWPhase = Next_SHWPhase
						Dose_ChangeType = Next_ChangeType));
			
		* In this situation, the first plan is to deal if the next record is W, ;
		* change the end date to be the start of the W record;
		/*** we are storing the needed values to  a Wrec prefix variable that will be retained
		throughout so we can pull it for the new observatio ***/
		
		retain Wrec_StartDate Wrec_EndDate 
			Wrec_Dosage Wrec_THB Wrec_PhysComments Wrec_TypeID Wrec_ChangeType Wrec_SHWPhase Wrec_ClinicPhase;


		if Next_ChangeTypeID = "W" then do;
			Wrec_StartDate = Dose_StartDate;
			Wrec_EndDate = Dose_EndDate;
			Wrec_Dosage = New_Dosage;
			Wrec_THB = NumTakeHome;
			Wrec_TypeID = Dose_ScriptTypeID;
			Wrec_ChangeType = Dose_ChangeType;
			Wrec_PhysComments = PhysicianComments;
			Wrec_SHWPhase = SHWPhase;
			Wrec_ClinicPhase = ClinicPhase;
			Dose_EndDate = Next_StartDate - 1;
			OUTPUT;
		end;		
		else if Dose_ScriptTypeID = "W" and EOF = 0 then do;
			OUTPUT;
			Dose_StartDate = Dose_EndDate + 1;
			Dose_EndDate = Wrec_EndDate;
			New_Dosage = Wrec_Dosage;
			NumTakeHome = Wrec_THB;
			Dose_ScriptTypeID = Wrec_TypeID;
			Dose_ChangeType = Wrec_ChangeType;
			SHWPhase = Wrc_SHWPhase;
			ClinicPhase = Wrc_ClinicPhase;
			PhysicianComments = Wrec_PhysComments;
			Phase = Wrec_Phase;
			OUTPUT;
		end;
		else OUTPUT;
	run;

 
	/*** WE now check for individual dosing record disrepencies and calculate the number of days of each dose ***/
	
	
	data process3_&id.;
		merge process25_&id.  end = eof process25_&id. (KEEP=Dose_StartDate Dose_EndDate Dose_ChangeType Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge
				FirstOBs=2 Rename=(Dose_StartDate=Next_StartDate Dose_EndDate=Next_EndDate Dose_ChangeType = Next_ChangeType Dose_EpisodeSeqNum = Next_EpisodeSeqNum Episodes_DateAdmit = NextAdmit Episodes_DateDischarge = NextDischarge));
			retain SumDays 0  Previous_SumDays Drug_Name;
			
		LENGTH Drug_Name $ 100;
		
		retain Drug_Name;
								
		if Dose_MedicationID = "0b5ef14726f449aea2cc3ba9ac3b7885" then Drug_Name = "Methadone";
		else if Dose_MedicationID = "a751918ff3464d34b8c1060f9e2c991e" then Drug_Name = "Suboxone";
		else if Dose_MedicationID = "5a14e2bae155478bb89d63e54d737d3d" then Drug_Name = "Suboxone";
		else if FIND(PhysicianComments, "methadone","i") > 0 then Drug_Name = "Methadone";
		else if FIND(PhysicianComments, 'suboxone', 'i') > 0 then Drug_Name = "Suboxone";

		if NumTakeHome = .D then NumTakeHome = .D;
		else if Dose_TakeHomeSupply = .N and NumTakeHome = . then NumTakeHome = 0;

		if _N_ = 1 AND Dose_StartDate < Next_StartDate AND Dose_ChangeType = "Take Home Quantity Change" AND Next_ChangeType = "Regimen Dose" then do;
			PUTLOG "ERROR!!: TLC data entry error with Regimen vs TAKE HOME for " Dose_PatientID " Take Home
			Start has been modified to the start of the regimen date."; 
			delete;
		end;

		if Dose_StartDate = Next_StartDate AND Dose_ChangeType = "Take Home Quantity Change" AND Next_ChangeType = "Regimen Dose" then do;
			PUTLOG "ERROR!!: Likely a TLC data entry error for " Dose_PatientID " This entry has been deleted and will not be considered purposes of generation of a sequence due to the lack of dose corresponding to number of takehomes."; 
			delete;
		end;
		
		if Dose_StartDate = Next_StartDate then do;
			PUTLOG "ERROR!!: Likely a data entry error for " Dose_PatientID " This entry has been deleted and will not be considered purposes of generation of a sequence due to the likelihood that the record is a duplicate errorneous entry."; 
			delete;
		end;

		if Dose_StartDate = Next_StartDate AND Dose_ChangeType =: "R" AND Next_ChangeType =: "T" then delete;

		if eof then do;
			if Episodes_DateDischarge = .C then NumDays = ABS(Extraction_Date - Dose_StartDate);
			else NumDays = (Dose_EndDate - Dose_StartDate);
		end;
		else NumDays= (Next_StartDate - Dose_StartDate);

		SumDays = SumDays + NumDays;
		Previous_NumDays=Lag1(NumDays);

		Previous_SumDays + Previous_NumDays;
	run;

	*********************************** BEGINNING DATE GENERATION SERIES*********************************************;
	/* Will be used to calcualte the Max and Min Doses, Num Days in MD */

	data METHADOS.SEQUENCE_&id.;
		set process3_&id. end = eof;
		************************* BEGINNING TIMESERIES DATE GENERATION ****************;
		array Days[*] Days1-Days5000;
		array Dose[*] Dose1-Dose5000;
		array THB[*] THB1-THB5000;
		array SHWP[*] $ SHWP1-SHWP5000;
		array ClinicP[*] $ ClinicP1-ClinicP5000;
		array EpiCount[*] EpiCount1-EpiCount5000;
		array Comment[*] $ 200 Comment1-Comment5000; 
		array Drug[*] $ 100 Drug1-Drug5000;

		retain Days1-Days5000 Dose1-Dose5000 Drug1-Drug5000 THB1-THB5000 ClinicP1-ClinicP5000 SHWP1-SHWP5000 EpiCount1-EpiCount5000 Comment1-Comment5000;

		if _N_ = 1 then Previous_SumDays = 0;
	
		do i=1 by 1 while (i <=NumDays);
			Days[Previous_SumDays + i]= Dose_StartDate + (i -1);
			Dose[Previous_SumDays + i]=New_Dosage;
			THB[Previous_SumDays + i]=NumTakeHome;
			SHWP[Previous_SumDays + i] = SHWPhase;
			ClinicP[Previous_SumDays + i] = ClinicPhase;
			EpiCount[Previous_SumDays + i] = SumEpisodes;
			Comment[Previous_SumDays + i] = PhysicianComments;
			Drug[Previous_SumDays + i] = Drug_Name;
		end;
		
		format Days1-Days5000 MMDDYY10.;

		if eof then do;
			RENAME SumDays = NumDaysDoseObserved Episodes_SumDays = NumDaysTx;
			keep ID DOSE_PatientID CURRENT Extraction_Date Consent_Date Episodes_SumDays 
			SumDays SumEpisodes Days1-Days5000 Dose1-Dose5000 THB1-THB5000 
			ClinicP1-ClinicP5000 SHWP1-SHWP5000 EpiCount1-EpiCount5000 Comment1-Comment5000
			Drug1-Drug5000; 
			output METHADOS.SEQUENCE_&id.;
		end;
	run;
	
	proc append base = METHADOS.master_spctlc data = METHADOS.sequence_&id. FORCE;
	run;

	proc append base = METHADOS.master_all data = METHADOS.sequence_&id. FORCE;
	run;


%MEND SPCIMPORT;


/************************************** JSAS DOSING PROGRAM ************************************************************************************/
%MACRO JSAFILE(ID=);

	%if %sysfunc(FileEXIST(C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\JSAS - ScriptHistory/2021ScriptHistory_&ID..csv))= 1 %then %LET ScriptHistory = 1;
		%else %do;
			%put WARNING: ***The ScriptHistory for &ID. does not exist!**;
			%let ScriptHistory = 0;
		%end;
	%if %sysfunc(FileEXIST(C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\JSAS - IntakeDischarge/2021IntakeDischarges_&ID..csv))= 1 %then %LET IntakeDischarge = 1;
		%else %do;
			%put WARNING: ***The IntakeDischarge Report for &ID. does not exist!**;
			%let IntakeDischarge = 0;
		%end;
	%if %sysfunc(FileEXIST(C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\JSAS - Discharges/2021Discharges_&ID..csv))= 1 %then %LET Discharge = 1;
		%else %do;
			%put WARNING: ***The Discharge Report for &ID. does not exist!**;
			%let Discharge = 0;
		%end;
	%if %sysfunc(SUM(&ScriptHistory, &IntakeDischarge, &Discharge)) = 3 %then %JSADOSE (ID=&ID.);
		%else %put WARNING: ****EXECUTION OF THE SEQUENCE PROGRAM TERMINIATED DUE TO MISSING FILES: RESOLVE DISREPENCIES AND TRY AGAIN!!!!!!*****;

%MEND JSAFILE;

/******************************************* MACRO EXECUTION **********************************************************************************/




%MACRO JSADOSE(ID=);

/**************** IMPORT Discharge and ADMIT DATA first ********************************************************/
						
proc import datafile = "C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\JSAS - IntakeDischarge/2021IntakeDischarges_&ID..csv"
		out = IntakeDischarges_TEMP_&ID.
		DBMS = csv
		replace;
		datarow = 2;
		getnames = YES;
		GuessingRows = 32627;
run;

data intakedischarges_&ID.;
	set IntakeDischarges_TEMP_&ID.;
	if VAR7 or VAR8 or VAR9 or VAR10 NE " " then delete;
	if textbox4 = " " then delete;
	if textbox9 = " " then delete;
	if textbox4 = "textbox4" then delete;
	
	Admission_date = INPUT(textbox1,MMDDYY10.);
	
	TotalIntakes = SUBSTR(textbox7,16,1);


	call symputx('Clinic_ID2', textbox4);
	call symputx('Patient_Name2',textbox5);
	call symputx('CURRENT2',textbox6);
	
	DROP Textbox7 VAR7 VAR8 VAR9 VAR10 textbox1;

	RENAME textbox4 = Clinic_ID textbox5 = Patient_Name textbox6 = CURRENT  textbox9 = Drug_Type;
run; 


proc import datafile = "C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\JSAS - Discharges/2021Discharges_&ID..csv"
		out = discharges_TEMP_&ID.
		DBMS = csv
		replace;
		datarow = 2;
		getnames = YES;
		GuessingRows = 32627;
run;

data discharges_TEMP2_&id.;
	set discharges_TEMP_&ID. (Rename = (discharge_date = discharge_date_temp admission_date = admission_date_temp));
	
	ATTRIB discharge_date FORMAT = MMDDYY10.;
	ATTRIB admission_date FORMAT = MMDDYY10.; 

	discharge_date = INPUT(discharge_date_temp,MMDDYY10.);
	
	if admission_date_temp > 0 then admission_date = admission_date_temp;
	else if MISSING(admission_date_temp) then admission_date = .;
	else admission_date = INPUT(admission_date_temp, MMDDYY10.);
	

	DROP textbox74 textbox75 textbox76 textbox60 textbox78 textbox82 textbox8 textbox9 notes_1 textbox5 textbox65 textbox66 textbox1 textbox4 textbox13 textbox14 VAR30;
run;

data discharges_&id.;
	merge discharges_TEMP2_&id. discharges_TEMP2_&id. (FIRSTOBS = 2 KEEP = textbox88 RENAME = (textbox88 = DischargeReason));
	ID = symget('ID');
	if admission_date = . then DELETE;
	if discharge_date = . then DELETE;
	drop textbox88;
run;

proc sort data = discharges_&id. NODUPRECS;
	by Admission_date;
run;

proc sort data = intakedischarges_&ID. NODUPRECS;
	by Admission_date;
run;

	data _NULL_;
	 if 0 then set Discharges_&ID. nobs=n;
	 call symputx('Discharge',n);
	 stop;
	run;

	data _NULL_;
	 if 0 then set IntakeDischarges_&ID. nobs=n;
	 call symputx('IntakeDischarges',n);
	 stop;
	run;

	%if &Discharge = 0 %then %do;
		data TEMPFILE.episodesA_&ID.;
			set intakedischarges_&ID. (RENAME = (CURRENT = Status));	

			ID = symget('ID');

			Date = Admission_Date;
			FORMAT admission_date Date Discharge_Date MMDDYY10.;
		run;
	%end;
	%else %if &Discharge > 0 %then %do;
		data TEMPFILE.episodesA_&ID.;
			merge intakedischarges_&ID. (RENAME = (CURRENT = Status)) discharges_&id. ;	
			by admission_date;

			ID = symget('ID');

			Date = Admission_Date;
			FORMAT admission_date discharge_date Date MMDDYY10.;
		run;
	%end;
	
	proc sort data = METHADOS.datatomerge;
		by ID;
	run;
	
	proc sort data = TEMPFILE.episodesA_&id.;
		by ID;
	run;

	data TEMPFILE.episodesB_&id.;
		merge METHADOS.datatomerge TEMPFILE.episodesA_&id. end=eof;
		by ID;
		if admission_date = . then delete;
	run;

	proc sort data = TEMPFILE.episodesB_&id.;
		by admission_date;
	run;

	data TEMPFILE.episodesB_&id.;
		set TEMPFILE.episodesB_&id. end = eof;

		length CURRENT $ 6;
		retain SumDays SumEpisodes;

		numdays = discharge_date - admission_date;
	
					
		if MISSING(Clinic_ID) then Clinic_ID = symget('Clinic_ID2');
		if MISSING(Patient_Name) then Patient_Name = symget('Patient_Name2');
		if MISSING(Status) then Status = symget('CURRENT2');
			
		If Status = "Active" then CURRENT = "TRUE";
		else if Status = "Inactive" then CURRENT = "FALSE";

		if discharge_date = . then do;
			discharge_date = .C;
			numdays = Extraction_Date - Admission_Date;
		end;
					
		SumEpisodes + 1;
		
		Sumdays + NumDays;

		if eof then do;
			call symput('NumDaysTx',Sumdays);
			call symput('CURRENT', CURRENT);
			call symput('SumEpisodes',SumEpisodes);
			putlog Sumdays;
		end;
	run;

	
	data TEMPFILE.episodesforlong_&id.;
		set TEMPFILE.episodesB_&id.;
		FORMAT Episodes_DateAdmit Episodes_DateDischarge MMDDYY10.;
		FORMAT DischargeReason $300.;
		FORMAT Episodes_DischargeTypeID $2.;
		
		/**** Recal in the SAS system: KEEP is executed piror to RENAME, so you need to run KEEP with the
		original VARNAMES and then you can run RENAME ****/

		KEEP ID Clinic_ID  admission_date  discharge_date 
				Episodes_DischargeTypeID DischargeReason SumEpisodes NumDays SumDays;
		RENAME Clinic_ID = Dose_PatientID
				admission_date = Episodes_DateAdmit
				discharge_date = Episodes_DateDischarge
				SumEpisodes = EpisodeCount
				NumDays = Episodes_NumDays
				SumDays = Episodes_SumDays
				DischargeReason = Episodes_DischargeReason;				

	run;

	/**** ADD NEW CODE FOR processing into episodes long *****/

	proc append base = METHADOS.episodeslong data = TEMPFILE.episodesforlong_&id. FORCE;
	run;
	

		
	data TEMPFILE.EpisodesTEMPArray_&ID.;
		set TEMPFILE.episodesB_&id.;
		retain Number 0;
		Number + 1;
		Dose_PatientID = INPUT(Clinic_ID, 8.);
		keep Number Dose_PatientID SumEpisodes Admission_Date Discharge_Date DischargeReason NumDays;
		RENAME Admission_Date = Episodes_DateAdmittemp
			   Discharge_Date = Episodes_DateDischargetemp
			   NumDays = Episodes_NumDaystemp
			   DischargeReason = Episodes_DischargeReasonTemp; 

	run;
	
	/*** Assuming no more than 10 episodes, and you will receive a ARRAY ERROR if it is over 10 and you should
	act accordingly ***/
	data TEMPFILE.Episodes_&ID.;
		set TEMPFILE.EpisodesTEMPArray_&ID. end = eof;
		array Episodes_DateAdmit[15];
		array Episodes_DateDischarge[15];
		array Episodes_NumDays[15];
		array Episodes_DischargeReason[15] $ 300;

		FORMAT Episodes_DateAdmit1-Episodes_DateAdmit15 Episodes_DateDischarge1-Episodes_DateDischarge15 MMDDYY10.;

		retain Episodes_DateAdmit1-Episodes_DateAdmit15
			   Episodes_DateDischarge1-Episodes_DateDischarge15
			   Episodes_NumDays1-Episodes_NumDays15
				Episodes_DischargeReason1-Episodes_DischargeReason15;

		do i = 1 to 15;
			Episodes_DateAdmit[number] = Episodes_DateAdmittemp;
			Episodes_DateDischarge[number] = Episodes_DateDischargetemp;
			Episodes_NumDays[number] = Episodes_NumDaystemp;
			Episodes_DischargeReason[number] = Episodes_DischargeReasontemp;
		end;

		if eof then do;
			ID = symget('ID');
			DROP Number i Episodes_DateAdmittemp Episodes_DateDischargetemp Episodes_NumDaystemp Episodes_DischargeReasontemp;
			output TEMPFILE.Episodes_&ID.;
		end;

	run;
	
/*********************** Initial Import statement to import the ScriptHistory from JSAS Methasoft Database**************/
proc import datafile = "C:\Users\pja77\Rutgers University\SHWeiss Research Group - Data Extraction\All Raw Data\JSAS - ScriptHistory/2021ScriptHistory_&ID..csv"
	out = TEMPFILE.process_&id.
	DBMS = csv replace;
	getnames = yes;
	DATAROW = 2;
	guessingrows=32767;
run;

data TEMPFILE.process_&id.;
	set TEMPFILE.process_&id. (RENAME = (comment = comment_4 phase = temp_phase));
	length ID $ 7;
	*There are several disrepencies where there are some random records for dates prior to 1/1/2009 in older patients database;
	if dosed_date_1 < "01Jan2009"D then DELETE;
	Dose_PATIENTID = INPUT(SUBSTR(patient_id, 13),BEST12.);
	RETAIN phase;

	*When a subject is absent, the take_on_date is intialized to a missing value of sorts, but the take_on_date is the most
	useful as it is the most sequential (xcept in the case noted), the dosed_date_1 is initlized when a dose was issued, so if takehomes
	apply, then the dosed_date_1 is the same for each dose issued during take home period;
	
	if take_on_date EQ "01Jan2001"D then Date = dosed_date_1;
	else Date = take_on_date;
	
	*Using this value since we would like to know what day of the week this was taken, this will allow us to generate Phase data in the future as we imporve dose mapping = 4/5/2019;
	
	ID = SYMGET('ID');
	
	if temp_phase =: "N/A" then phase = "M";
	else if temp_phase =: "Phase 1" then phase = "1";
	else if temp_phase =: "Phase 2" then phase = "2";
	else if temp_phase =: "Phase 3" then phase = "3";
	else if temp_phase =: "Phase 4" then phase = "4";
	else if temp_phase =: "Phase 5" then phase = "5";
	else if temp_phase =: "Phase 6" then phase = "6";	
	

	FORMAT Date MMDDYY10.;
run;

proc sort data = TEMPFILE.process_&id. NODUPKEY;
	by Date dose_num;
run;

data TEMPFILE.process2_&id.;
	set TEMPFILE.process_&id.;
	by Date dose_num;
	if FIRST.date then dose_marker = "First";
	else if LAST.date then dose_marker = "Last";

	Previous_Date = LAG1(Date);
	Previous_Dose_Num = LAG1(Dose_NUM);

	Pointer = _N_ + 1;

	set TEMPFILE.process_&id.  (keep = Date dose_num RENAME = (Date = NextDate dose_num = next_dose_num)) POINT = Pointer;

	
	if TakeHome = . and special_takeouts_1 = "TO" then do;
		if FIND(comment_1,"nursing","i") >= 1 then TakeHome = .U;
		/*** Need to add code about holidays***/
		else TakeHome = 1;
	end;
	else TakeHome = 0;
	
	Previous_Dose = LAG(dosage_mgs);
	Previous_Dose2 = LAG2(dosage_mgs);

run;

data TEMPFILE.process3_&id.;
	set TEMPFILE.process2_&id.;
	
	Year = year(Date);
	Week = week(date);

	THB_Key = INPUT(CAT(Year,".",put(Week,z2.)),10.2);



	if dose_marker = "Last" AND dose_num >= 1 then do;
		if dose_num = 3 then do;
			new_dosage = Previous_Dose2 + Previous_Dose + dosage_mgs;
			TakeHome = 0;
		end;
		if dose_num = 2 then do;
			new_dosage = Previous_Dose + dosage_mgs;
			TakeHome = 0;
		end;
		if dose_num = 1 AND Previous_Date = Date then do;
			dose_num = 2;
			new_dosage = Previous_Dose + dosage_mgs;
			TakeHome = 0;
		end;
		output TEMPFILE.process3_&id.;
	end;
	else if dose_marker = "First" AND Dose_NUM NE 0 then do;
		if Date NE NextDate OR eof then do;
			new_dosage = dosage_mgs;
			output TEMPFILE.process3_&id.;
		end;
		else if Date EQ NextDate then DELETE;
	end;
	else if dose_num = 0 then do;
		new_dosage = .A;
		TakeHome = .A;
		output TEMPFILE.process3_&id.;
	end;

run;

proc sort data = TEMPFILE.process3_&ID.;
	by THB_Key;
run;

data TEMPFILE.process4_&ID.;
	set TEMPFILE.process3_&ID.;
	by THB_Key;
	retain RetainWeekTakeHome RetainTHBKey ConsecutiveTakeHome ConsecutiveTHBKey;

	PreviousTakeHome = LAG(TakeHome);

	if TakeHome = 1 then do;
		ConsecutiveTakeHome = ConsecutiveTakeHome + 1;
		if ConsecutiveTakeHome = 1 then ConsecutiveTHBKey = THB_Key;
	end;
	else if TakeHome = 0 then do;
		ConsecutiveTakeHome = 0;
		ConsecutiveTHBKey = .;
	end;


	if FIRST.THB_Key AND TakeHome = 0 then do;
		WeekTakeHome = 0;
		RetainTHBKey = .;
		RetainWeekTakeHome = 0;
	end;
	else if FIRST.THB_Key and TakeHome = 1 then do;
		if ConsecutiveTakeHome > 7 then do;
			WeekTakeHome = .C;
		end;
		else if ConsecutiveTakeHome < 7 then do;
			WeekTakeHome = 1;
		end;
	end;
	else if TakeHome = 1 AND ConsecutiveTakeHome < 7 then WeekTakeHome + 1;
	else if TakeHome = 1 AND ConsecutiveTakeHome >= 7 then WeekTakeHome = .C;
	
	if Last.THB_Key and ConsecutiveTakeHome >= 7 then do;
		if RetainTHBKey = .  then RetainTHBKey = ConsecutiveTHBKey;
		RetainWeekTakeHome = .C;
	end;
	else if Last.THB_key and ConsecutiveTakeHome <= 7 then do;
		RetainTHBKey = .;
		RetainWeekTakeHome = 0;
	end;
run;

proc sort data = TEMPFILE.process4_&ID. out = TEMPFILE.sortmonthly_&ID.;
	by ConsecutiveTHBKEy ConsecutiveTakeHome;
run;

/*** First thing is to get the consecutive THB Keys to account for monthly takehomes ***/
data TEMPFILE.monthlyTHB_&ID.;
	set TEMPFILE.sortmonthly_&ID.;
	by ConsecutiveTHBKey;
	if LAST.ConsecutiveTHBKey  AND ConsecutiveTHBKEy NE .;
	if ConsecutiveTakeHome > 13;
	keep ConsecutiveTHBKey ConsecutiveTakeHome;
	RENAME ConsecutiveTakeHome = MergedTakeHome	
			ConsecutiveTHBKey = RetainTHBKey;
run;

data TEMPFILE.weeklyTHB_&ID.;
	set TEMPFILE.process4_&ID.;
	by THB_Key;
	retain First_WeekTakeHome;
	if FIRST.THB_Key OR LAST.THB_KEY;
	if FIRST.THB_Key and WeekTakeHome = .C then First_WeekTakeHome = .C;
	else First_WeekTakeHome = WeekTakeHome;
	
	if LAST.THB_KEY then do;
			if First_WeekTakeHome = .C AND WeekTakeHome = .C THEN Delete;
	end;

	if WeekTakeHome = .C THEN DELETE;

	if LAST.THB_Key;

	Keep WeekTakeHome THB_Key;
	RENAME WeekTakeHome = MergedTakeHome
			THB_Key = RetainTHBKey;
run;

proc sort data = TEMPFILE.weeklyTHB_&ID.;
	by RetainTHBKey;
run;

proc sort data = TEMPFILE.monthlyTHB_&ID.;
	by RetainTHBKey;
run;

data TEMPFILE.weeklyTHB2_&ID.;
	merge TEMPFILE.weeklyTHB_&ID. TEMPFILE.monthlyTHB_&ID. (rename = (MergedTakeHome = MonthlyTakeHome) in = inMonthly);
	by RetainTHBKey;

	if inMonthly then do;
		PUTLOG "Takehome Key " RetainTHBKey " is deleted since we have a duplicate record!";
		DELETE;
	end;
	
	drop MonthlyTakeHome inMonthly;
run;

data TEMPFILE.TAKEHOMES_&ID.;
	set TEMPFILE.weeklyTHB2_&ID. TEMPFILE.monthlyTHB_&ID.;
run;

proc sort data = TEMPFILE.TAKEHOMES_&ID.;
	by RetainTHBKey;
run;

data TEMPFILE.PROCESS5_&ID.;
	merge TEMPFILE.PROCESS4_&ID. TEMPFILE.takehomes_&ID. (rename = (RetainTHBKey = THB_Key));
	by THB_Key;
	retain FinalTHB;
	
	if not missing(MergedTakeHome) then FinalTHB=MergedTakeHome;

run;

proc sort data = TEMPFILE.process5_&ID.;
	by Date;
run;

proc sort data = TEMPFILE.episodesB_&ID.;
	by Date;
run;


data TEMPFILE.process6_&ID.;
	merge TEMPFILE.process5_&ID. TEMPFILE.episodesB_&ID. (keep = Date admission_date discharge_date SumEpisodes 
			RENAME = (admission_date = admission_datetemp discharge_date = discharge_datetemp SumEpisodes = SumEpisodestemp));
	by Date;

	
	if Date = . THEN DELETE;

	retain admission_date discharge_date SumEpisodes;


	if not missing(admission_datetemp) then do;
		admission_date=admission_datetemp;
		discharge_date=discharge_datetemp;
		SumEpisodes=SumEpisodestemp;
	end;

run;


data TEMPFILE.process7_&id.;
	merge TEMPFILE.process6_&id. TEMPFILE.process6_&id. (KEEP=admission_date discharge_date
				FirstOBs=2 Rename=(admission_date=next_admit discharge_date=next_discharge));
	if dosed_date_1 = . THEN DELETE;
	if (Date > discharge_date) AND (Discharge_Date > 0) then DELETE;
run;

/**************** STEPS need to be done twice as you are not able to do a merge and do an explicit retain

https://support.sas.com/resources/papers/proceedings/proceedings/sugi23/Advtutor/P47.pdf

So the first source of confusion is that one often
forgets that the automatic retain actually exists when a MERGE statement is
used.**************/


/**** Prior to the generation of a time series, we want to make sure that all dates are sorted accoridngly **/

proc sort data = TEMPFILE.process7_&id.;
	by ID;
run;

/***** Also want to merge the data to pull the extraction and consent dates ***/
data TEMPFILE.process7a_&id.;
	merge TEMPFILE.process7_&id. METHADOS.datatomerge;
	by ID;
	if Date = . then DELETE; /*** Pulling out the excess junk from the dataset ***/
run;


data TEMPFILE.process8_&id.;
	set TEMPFILE.process7a_&id.;
	/*** Probem: we need to ensure that discharge and admit dates are being set appropriately to ensure that it can do needed comparisons, but we get a bunch of missing admit discharge ***/ 
	/*** Solution: Temp variable used to get the admit and discharge date, and use retain and variable declaration statemetns to fill the missing gaps **/

	/*** Should be good to ensure that all obs have admit/discharge dates ***/ 
		
	
	if FIND(drug_type_desc, "BUP", "i") > 0 then do;
		NumDaysBupObserved + 1; 
		Drug_Type = Drug_type_desc;
		dosage_mgs = .B;
	end;
	else if FIND(drug_type_desc, "SUB", "i") > 0 then do;
		NumDaysSubObserved + 1;
		Drug_Type = Drug_type_desc;
		dosage_mgs = .S;
	end;
	else if FIND(drug_type_desc, "Vivitrol", "i") > 0 then do;
		NumDaysVivObserved + 1;
		Drug_Type = Drug_type_desc;
		dosage_mgs = .V;
	end;
	else if dosage_mgs > 0 then do;
		NumDaysDoseObserved + 1;
		Drug_Type = Drug_type_desc;
	end;


	if Dose_Num = -1 then do;
		new_dosage = lag1(dosage_mgs);
		PUTLOG "Subject has guest dosed in another facility. Imputing current dose";
	end;

	
	/**** IF phase is not included in this calcuation, since at JSAS, Phase is not included in Dosing
	Records until Feb2013,just impute a missing value. However, in days that the subject is absent, we need to ensure that
	phase is kept, since an absent subject on Phase 5 is still on Phase 5 ***/

	if Phase = "N/A" then Phase = " ";
	if Dosage_mgs = .A and Phase = " " then Phase = lag1(Phase);

	

	if (admission_date NE next_admit) AND (Next_admit - NextDate > 0) then do;
		if new_dosage NE .D then do;
			NumDaysDischarge = next_admit - discharge_date;
				StartDate = Date;
				output TEMPFILE.process8_&id.;
				do i = 1 to NumDaysDischarge;
					new_dosage = .D;
					Phase = .D;
					dosed_date_1 = .D;
					FinalTHB = .D;
					Date = StartDate + i;
					output TEMPFILE.process8_&id.;
				end;
		end;
	end;
	else if admission_date EQ next_admit then do;
		if ((Date + 1) NE NextDate) AND (NextDate NE .) then do;
			NumDaysAbsent = NextDate - Date;
			StartDate = Date;
			output TEMPFILE.process8_&id.;
			do i = 1 to NumDaysAbsent;
				new_dosage = .A;
				FinalTHB = .A;
				Date = StartDate + i;
				output TEMPFILE.process8_&id.;
			end;
		end;
	end;
	else output TEMPFILE.process8_&id.;


	if Date > Discharge_date AND new_dosage = .A then DELETE;
	/**** Checking to see if it is an absence, or if the record is the terminiation of a Dosing Episode -
	In the situation where it is an absence that hasn't been coded, we need to go ahead and just call it a .A record.
	In the situation where it is the termination of an episode - we need to create .D records which is necessary for analysis ***/

	output TEMPFILE.process8_&id.;
run;

/***************** COMPLETE ALL PROCESSING STEPS **************************/

data TEMPFILE.process9_&ID.;
	set TEMPFILE.process8_&ID.;
	
	Num = _N_;
run;

data TEMPFILE.SEQUENCE_&id.;
	set TEMPFILE.process9_&id. end = eof;
	************************* BEGINNING TIMESERIES DATE GENERATION ****************;
	length CURRENT $ 6;
	
	
	array Days[*] Days1-Days5000;
	array Dose[*] Dose1-Dose5000;
	array THB[*] THB1-THB5000;
	array ClinicP[*] $  ClinicP1-ClinicP5000;
	array EpiCount[*] EpiCount1-Epicount5000;
	array Comment[*] $ 200 Comment1-Comment5000;
	array Drug[*] $ 100 Drug1-Drug5000;

	NumDaysTx_temp = symget('NumDaysTx');
	NumDaysTx = INPUT(NumDaysTx_temp, BEST12.);
	CURRENT = symget('CURRENT');

	retain Extraction_Date Consent_Date Days1-Days5000 Dose1-Dose5000 THB1-THB5000 ClinicP1-ClinicP5000 EpiCount1-Epicount5000 Drug1-Drug5000;

	Days[Num]= Date;
	Dose[Num]=new_dosage;
	THB[Num]= FinalTHB;
	ClinicP[Num] = Phase;
	Drug[num] = Drug_type;
	EpiCount[num] = SumEpisodes;
	
	format Days1-Days5000 MMDDYY10.;

	keep ID DOSE_PatientID CURRENT Extraction_Date Consent_Date NumDaysDoseObserved SumEpisodes NumDaysTx Days1-Days5000 Dose1-Dose5000 THB1-THB5000 ClinicP1-ClinicP5000 EpiCount1-EpiCount5000 Comment1-Comment5000 Drug1-Drug5000; 
	if eof then output TEMPFILE.SEQUENCE_&id.;
run;

proc append base = METHADOS.master_all_jsa data = TEMPFILE.sequence_&id. FORCE;
run;

proc append base = METHADOS.master_all data = TEMPFILE.sequence_&id. FORCE;
run;

proc append base = METHADOS.Episodes_all data = TEMPFILE.Episodes_&id. FORCE;
run;
	

%MEND JSADOSE;

proc printto log="C:\Users\&sysuserid.\Rutgers University\SHWeiss Research Group - Data Extraction\All SAS Libraries\Logs\SPC Program Log &ImportDate. &ImportTime..log";
run;

%SPCIMPORT (ID=SPC0385)
%SPCIMPORT (ID=SPC0402)
%SPCIMPORT (ID=SPC0762)
%SPCIMPORT (ID=SPC1029)
%SPCIMPORT (ID=SPC1156)
%SPCIMPORT (ID=SPC1413)
%SPCIMPORT (ID=SPC2569)
%SPCIMPORT (ID=SPC4010)
%SPCIMPORT (ID=SPC4028)
%SPCIMPORT (ID=SPC4036)
%SPCIMPORT (ID=SPC4044)
%SPCIMPORT (ID=SPC4052)
%SPCIMPORT (ID=SPC4060)
%SPCIMPORT (ID=SPC4078)
%SPCIMPORT (ID=SPC4086)
%SPCIMPORT (ID=SPC4094)
%SPCIMPORT (ID=SPC4101)
%SPCIMPORT (ID=SPC4119)
%SPCIMPORT (ID=SPC4127)
%SPCIMPORT (ID=SPC4135)
%SPCIMPORT (ID=SPC4143)
%SPCIMPORT (ID=SPC4151)
%SPCIMPORT (ID=SPC4169)
%SPCIMPORT (ID=SPC4177)
%SPCIMPORT (ID=SPC4185)
%SPCIMPORT (ID=SPC4193)
%SPCIMPORT (ID=SPC4200)
%SPCIMPORT (ID=SPC4218)
%SPCIMPORT (ID=SPC4226)
%SPCIMPORT (ID=SPC4234)
%SPCIMPORT (ID=SPC4242)
%SPCIMPORT (ID=SPC4250)
%SPCIMPORT (ID=SPC4268)
%SPCIMPORT (ID=SPC4276)
%SPCIMPORT (ID=SPC4284)
%SPCIMPORT (ID=SPC4292)
%SPCIMPORT (ID=SPC4309)
%SPCIMPORT (ID=SPC4317)
%SPCIMPORT (ID=SPC4325)
%SPCIMPORT (ID=SPC4333)
%SPCIMPORT (ID=SPC4341)
%SPCIMPORT (ID=SPC4359)
%SPCIMPORT (ID=SPC4367)
%SPCIMPORT (ID=SPC4375)
%SPCIMPORT (ID=SPC4383)
%SPCIMPORT (ID=SPC4416)
%SPCIMPORT (ID=SPC4424)
%SPCIMPORT (ID=SPC4432)
%SPCIMPORT (ID=SPC4440)
%SPCIMPORT (ID=SPC4458)
%SPCIMPORT (ID=SPC4466)
%SPCIMPORT (ID=SPC4474)
%SPCIMPORT (ID=SPC4482)
%SPCIMPORT (ID=SPC4490)
%SPCIMPORT (ID=SPC4507)
%SPCIMPORT (ID=SPC4515)
%SPCIMPORT (ID=SPC4531)
%SPCIMPORT (ID=SPC4557)
%SPCIMPORT (ID=SPC4565)
%SPCIMPORT (ID=SPC4573)
%SPCIMPORT (ID=SPC4581)
%SPCIMPORT (ID=SPC4599)
%SPCIMPORT (ID=SPC4614)
%SPCIMPORT (ID=SPC4622)
%SPCIMPORT (ID=SPC4672)
%SPCIMPORT (ID=SPC4680)
%SPCIMPORT (ID=SPC4698)
%SPCIMPORT (ID=SPC4705)
%SPCIMPORT (ID=SPC4713)
%SPCIMPORT (ID=SPC4721)
%SPCIMPORT (ID=SPC4747);

proc printto;
run;

proc sort data = METHADOS.datatomerge;
	by ID;
run;

proc printto log="C:\Users\&sysuserid.\Rutgers University\SHWeiss Research Group - Data Extraction\All SAS Libraries\Logs\TLC Program Log &ImportDate. &ImportTime..log";
run;


%TLCIMPORT (ID=TLC7014)
%TLCIMPORT (ID=TLC7022)
%TLCIMPORT (ID=TLC7030)
%TLCIMPORT (ID=TLC7048)
%TLCIMPORT (ID=TLC7056)
%TLCIMPORT (ID=TLC7064)
%TLCIMPORT (ID=TLC7072)
%TLCIMPORT (ID=TLC7080)
%TLCIMPORT (ID=TLC7098)
%TLCIMPORT (ID=TLC7105)
%TLCIMPORT (ID=TLC7113)
%TLCIMPORT (ID=TLC7121)
%TLCIMPORT (ID=TLC7139)
%TLCIMPORT (ID=TLC7147)
%TLCIMPORT (ID=TLC7155)
%TLCIMPORT (ID=TLC7163)
%TLCIMPORT (ID=TLC7171)
%TLCIMPORT (ID=TLC7189)
%TLCIMPORT (ID=TLC7197)
%TLCIMPORT (ID=TLC7212)
%TLCIMPORT (ID=TLC7220)
%TLCIMPORT (ID=TLC7238)
%TLCIMPORT (ID=TLC7246)
%TLCIMPORT (ID=TLC7254)
%TLCIMPORT (ID=TLC7262)
%TLCIMPORT (ID=TLC7270)
%TLCIMPORT (ID=TLC7288)
%TLCIMPORT (ID=TLC7296)
%TLCIMPORT (ID=TLC7303)
%TLCIMPORT (ID=TLC7311)
%TLCIMPORT (ID=TLC7329)
%TLCIMPORT (ID=TLC7337)
%TLCIMPORT (ID=TLC7345)
%TLCIMPORT (ID=TLC7353)
%TLCIMPORT (ID=TLC7361)
%TLCIMPORT (ID=TLC7379)
%TLCIMPORT (ID=TLC7387)
%TLCIMPORT (ID=TLC7395)
%TLCIMPORT (ID=TLC7402)
%TLCIMPORT (ID=TLC7410)
%TLCIMPORT (ID=TLC7428)
%TLCIMPORT (ID=TLC7436)
%TLCIMPORT (ID=TLC7444)
%TLCIMPORT (ID=TLC7452)
%TLCIMPORT (ID=TLC7460)
%TLCIMPORT (ID=TLC7478)
%TLCIMPORT (ID=TLC7486)
%TLCIMPORT (ID=TLC7494)
%TLCIMPORT (ID=TLC7501)
%TLCIMPORT (ID=TLC7519)
%TLCIMPORT (ID=TLC7527)
%TLCIMPORT (ID=TLC7535)
%TLCIMPORT (ID=TLC7543)
%TLCIMPORT (ID=TLC7569)
%TLCIMPORT (ID=TLC7577)
%TLCIMPORT (ID=TLC7585)
%TLCIMPORT (ID=TLC7600)
%TLCIMPORT (ID=TLC7618)
%TLCIMPORT (ID=TLC7626)
%TLCIMPORT (ID=TLC7634)
%TLCIMPORT (ID=TLC7642)
%TLCIMPORT (ID=TLC7650)
%TLCIMPORT (ID=TLC7668)
%TLCIMPORT (ID=TLC7676)
%TLCIMPORT (ID=TLC7684)
%TLCIMPORT (ID=TLC7709)
%TLCIMPORT (ID=TLC7717)
%TLCIMPORT (ID=TLC7725)
%TLCIMPORT (ID=TLC7733)
%TLCIMPORT (ID=TLC7741)
%TLCIMPORT (ID=TLC7759)
%TLCIMPORT (ID=TLC7767)
%TLCIMPORT (ID=TLC7775)
%TLCIMPORT (ID=TLC7783)
%TLCIMPORT (ID=TLC7791)
%TLCIMPORT (ID=TLC7808)
%TLCIMPORT (ID=TLC7816)
%TLCIMPORT (ID=TLC7824)
%TLCIMPORT (ID=TLC7832)
%TLCIMPORT (ID=TLC7840)
%TLCIMPORT (ID=TLC7858)
%TLCIMPORT (ID=TLC7866)
%TLCIMPORT (ID=TLC7874)
%TLCIMPORT (ID=TLC7882)
%TLCIMPORT (ID=TLC7890)
%TLCIMPORT (ID=TLC7907)
%TLCIMPORT (ID=TLC7915)
%TLCIMPORT (ID=TLC7923)
%TLCIMPORT (ID=TLC7931)
%TLCIMPORT (ID=TLC7949)
%TLCIMPORT (ID=TLC7957)
%TLCIMPORT (ID=TLC7973)
%TLCIMPORT (ID=TLC7981)
%TLCIMPORT (ID=TLC7999)
%TLCIMPORT (ID=TLC8004)
%TLCIMPORT (ID=TLC8012)
%TLCIMPORT (ID=TLC8020)
%TLCIMPORT (ID=TLC8038)
%TLCIMPORT (ID=TLC8046)
%TLCIMPORT (ID=TLC8054)
%TLCIMPORT (ID=TLC8062)
%TLCIMPORT (ID=TLC8070)
%TLCIMPORT (ID=TLC8088)
%TLCIMPORT (ID=TLC8096)
%TLCIMPORT (ID=TLC8103)
%TLCIMPORT (ID=TLC8111)
%TLCIMPORT (ID=TLC8129)
%TLCIMPORT (ID=TLC8137)
%TLCIMPORT (ID=TLC8145)
%TLCIMPORT (ID=TLC8153)
%TLCIMPORT (ID=TLC8161)
%TLCIMPORT (ID=TLC8179)
%TLCIMPORT (ID=TLC8187)
%TLCIMPORT (ID=TLC8195)
%TLCIMPORT (ID=TLC8202)
%TLCIMPORT (ID=TLC8210)
%TLCIMPORT (ID=TLC8228)
%TLCIMPORT (ID=TLC8236)
%TLCIMPORT (ID=TLC8244)
%TLCIMPORT (ID=TLC8252)
%TLCIMPORT (ID=TLC8260)
%TLCIMPORT (ID=TLC8278)
%TLCIMPORT (ID=TLC8286)
%TLCIMPORT (ID=TLC8294)
%TLCIMPORT (ID=TLC8301)
%TLCIMPORT (ID=TLC8319)
%TLCIMPORT (ID=TLC8327)
%TLCIMPORT (ID=TLC8335)
%TLCIMPORT (ID=TLC8343)
%TLCIMPORT (ID=TLC8377)
%TLCIMPORT (ID=TLC8385)
%TLCIMPORT (ID=TLC8393)
%TLCIMPORT (ID=TLC8400)
%TLCIMPORT (ID=TLC8442)
%TLCIMPORT (ID=TLC8468)
%TLCIMPORT (ID=TLC8476)
%TLCIMPORT (ID=TLC8492)
%TLCIMPORT (ID=TLC8509)
%TLCIMPORT (ID=TLC8517)
%TLCIMPORT (ID=TLC8525)
%TLCIMPORT (ID=TLC8541)
%TLCIMPORT (ID=TLC8559)
%TLCIMPORT (ID=TLC8567)
%TLCIMPORT (ID=TLC8575)
%TLCIMPORT (ID=TLC8583)
%TLCIMPORT (ID=TLC8591)
%TLCIMPORT (ID=TLC8608)
%TLCIMPORT (ID=TLC8632)
%TLCIMPORT (ID=TLC8640)
%TLCIMPORT (ID=TLC8658)
%TLCIMPORT (ID=TLC8666)
%TLCIMPORT (ID=TLC8707)
%TLCIMPORT (ID=TLC8715)
%TLCIMPORT (ID=TLC8723)
%TLCIMPORT (ID=TLC8731)
%TLCIMPORT (ID=TLC8757)
%TLCIMPORT (ID=TLC8765)
%TLCIMPORT (ID=TLC8773)
%TLCIMPORT (ID=TLC8781)
%TLCIMPORT (ID=TLC8799)
%TLCIMPORT (ID=TLC8806)
%TLCIMPORT (ID=TLC8814)
%TLCIMPORT (ID=TLC8822)
%TLCIMPORT (ID=TLC8830)
%TLCIMPORT (ID=TLC8848)
%TLCIMPORT (ID=TLC8856)
%TLCIMPORT (ID=TLC8864)
%TLCIMPORT (ID=TLC8872)
%TLCIMPORT (ID=TLC8880)
%TLCIMPORT (ID=TLC8898)
%TLCIMPORT (ID=TLC8905)
%TLCIMPORT (ID=TLC8913)
%TLCIMPORT (ID=TLC8939)
%TLCIMPORT (ID=TLC8947)
%TLCIMPORT (ID=TLC8963)
%TLCIMPORT (ID=TLC8989)
%TLCIMPORT (ID=TLC8997)
%TLCIMPORT (ID=TLC9002)
%TLCIMPORT (ID=TLC9010)
%TLCIMPORT (ID=TLC9028)
%TLCIMPORT (ID=TLC9036)
%TLCIMPORT (ID=TLC9044)
%TLCIMPORT (ID=TLC9052)
%TLCIMPORT (ID=TLC9060)
%TLCIMPORT (ID=TLC9078)
%TLCIMPORT (ID=TLC9086)
%TLCIMPORT (ID=TLC9094)
%TLCIMPORT (ID=TLC9101)
%TLCIMPORT (ID=TLC9143)
%TLCIMPORT (ID=TLC9151)
%TLCIMPORT (ID=TLC9169)
%TLCIMPORT (ID=TLC9177)
%TLCIMPORT (ID=TLC9185)
%TLCIMPORT (ID=TLC9193)
%TLCIMPORT (ID=ESS0138)
%TLCIMPORT (ID=NIA0145)
%TLCIMPORT (ID=NIA2431)
%TLCIMPORT (ID=TLC7204)
%TLCIMPORT (ID=TLC8674);

/*** ADD NEW MACRO CALL STATEMENTS HERE FORMAT AS FOLLOWS: %SPCTLCFILE(ID=TLC####) OR %SPCTLCFILE(ID=SPC####) ****/

proc printto;
run;


proc printto log="C:\Users\&sysuserid.\Rutgers University\SHWeiss Research Group - Data Extraction\All SAS Libraries\Logs\JSAS Program Log &ImportDate. &ImportTime..log";
run;	

%JSAFILE (ID=JSA1016)
%JSAFILE (ID=JSA1024)
%JSAFILE (ID=JSA1032)
%JSAFILE (ID=JSA1040)
%JSAFILE (ID=JSA1058)
%JSAFILE (ID=JSA1066)
%JSAFILE (ID=JSA1074)
%JSAFILE (ID=JSA1082)
%JSAFILE (ID=JSA1090)
%JSAFILE (ID=JSA1115)
%JSAFILE (ID=JSA1123)
%JSAFILE (ID=JSA1131)
%JSAFILE (ID=JSA1149)
%JSAFILE (ID=JSA1157)
%JSAFILE (ID=JSA1165)
%JSAFILE (ID=JSA1181)
%JSAFILE (ID=JSA1199)
%JSAFILE (ID=JSA1206)
%JSAFILE (ID=JSA1214)
%JSAFILE (ID=JSA1222)
%JSAFILE (ID=JSA1230)
%JSAFILE (ID=JSA1248)
%JSAFILE (ID=JSA1256)
%JSAFILE (ID=JSA1264)
%JSAFILE (ID=JSA1272)
%JSAFILE (ID=JSA1280)
%JSAFILE (ID=JSA1298)
%JSAFILE (ID=JSA1305)
%JSAFILE (ID=JSA1313)
%JSAFILE (ID=JSA1321)
%JSAFILE (ID=JSA1339)
%JSAFILE (ID=JSA1347)
%JSAFILE (ID=JSA1355)
%JSAFILE (ID=JSA1363)
%JSAFILE (ID=JSA1371)
%JSAFILE (ID=JSA1389)
%JSAFILE (ID=JSA1397)
%JSAFILE (ID=JSA1404)
%JSAFILE (ID=JSA1412)
%JSAFILE (ID=JSA1420)
%JSAFILE (ID=JSA1438)
%JSAFILE (ID=JSA1446)
%JSAFILE (ID=JSA1454)
%JSAFILE (ID=JSA1462)
%JSAFILE (ID=JSA1470)
%JSAFILE (ID=JSA1488)
%JSAFILE (ID=JSA1496)
%JSAFILE (ID=JSA1503)
%JSAFILE (ID=JSA1511)
%JSAFILE (ID=JSA1529)
%JSAFILE (ID=JSA1537)
%JSAFILE (ID=JSA1545)
%JSAFILE (ID=JSA1553)
%JSAFILE (ID=JSA1561)
%JSAFILE (ID=JSA1579)
%JSAFILE (ID=JSA1587)
%JSAFILE (ID=JSA1595)
%JSAFILE (ID=JSA1602);

/*** ADD NEW MACRO CALL STATEMENTS HERE FORMAT AS FOLLOWS: %SPCTLCFILE(ID=JSA####) ****/

proc printto;
run;

proc sort data = METHADOS.master_all;
	by ID;
run;

proc sort data = METHADOS.episodes_all;
	by ID;
run;

proc sort data = sasuser.subjectids;
	by ID;
run;

/**** Working with Verification, find out which patients are not in the datasets ***/
data METHADOS.verification;
merge METHADOS.master_all (in = inDose KEEP = ID) sasuser.subjectids (KEEP = Subj_ID in = inMaster RENAME = (Subj_ID = ID));
by ID;
if inMaster = 1 and inDose = 0 then do;
	PUTLOG "Subject ID: " ID " is not in the dosing database";
	Dosing = 0;
end;
if inMaster = 1 and inDose = 1 then Dosing = 1;
run;

/**** Working with Verification, find out which patients are not in the datasets ***/
data METHADOS.verification;
set METHADOS.verification;
merge METHADOS.episodes_all (in = inDose KEEP = ID) sasuser.subjectids (KEEP = Subj_ID in = inMaster RENAME = (Subj_ID = ID));
by ID;
if inMaster = 1 and inDose = 0 then do;
	PUTLOG "Subject ID: " ID " is not in the episodes database";
	Episodes = 0;
end;
if inMaster = 1 and inDose = 1 then Episodes = 1;
run;

data METHADOS.allwithdata_epi;
	merge METHADOS.master_all (in = inDose) METHADOS.episodes_all (in = inEpi);
	by ID;
	if inDose AND NOT inEpi then PUTLOG ID " is in Dosing Database and not Episode Database";
	else if inEpi AND NOT inDose then PUTLOG ID " is in Episode Database and NOT in dosing database";
run;
 /***
data METHADOS.master_all_forexport;
	set METHADOS.master_all;
	drop THB1-THB5000 P1-P5000;
run;
/*** NOTE: In order to preserve all missing values in exported data sets, you must use DBMS = CSV to save to a CSV file and then
go ahead and open in CSV ***/

/***
proc export
data=methados.master_all_forexport
outfile="&ExportDir.\&ImportDate.\Methadone Dose Database Truncated &ImportDate. &ImportTime. .xlsx"
dbms=XLSX REPLACE;
run; ***/

%macro order_vars
			(max=10, 
			 list= Dose_EpisodeSeqNum Episodes_DateAdmit Episodes_DateDischarge Episodes_NumDays);
      %global vars_in_order;
      %let no_of_vars = %sysfunc(countw(&list));
      %put no_of_vars = &no_of_vars ;

      %let vars_in_order = ;
       %do m=1 %to &max;
              %do i=1 %to &no_of_vars;
                    %let vars_in_order = &vars_in_order %scan(&list,&i)&m;
              %end;
      %end;
%mend order_vars;

%order_vars;

data methados.episodes_all_reorder;
	retain ID Dose_PatientID &vars_in_order.;
	set methados.episodes_all;
run;
	

proc export
data=methados.episodes_all_reorder
outfile="&ExportDir.\&ImportDate./Episodes Database &ImportDate. &ImportTime..xlsx"
dbms=XLSX REPLACE;
run;

data METHADOS.episodeslong;
	set METHADOS.episodeslong; 
	if EpisodeCount = 0 then DELETE;
run;

/***** Creating new dataset to look at episode level data rather than subject level data **** /

/***** PJAttia Definition of Episode: A continous placement of treatment (irrespective of internal transfers) AT THE SAME clinic. 
In any transfer situation, a sujbect is being restarted to 30  mg ****/
/***** It would make sense that all subjects start from scratch EVEN IN THE EVENT OF TRANSFER as the Code of Federal Regulations does not add a caveat for transfers (42 CFR 8)

(iii) Buprenorphine and buprenorphine combination products that have been approved for use in the treatment of opioid use disorder.

(3) OTPs shall maintain current procedures that are adequate to ensure that the following dosage form and initial dosing requirements are met:

(i) Methadone shall be administered or dispensed only in oral form and shall be formulated in such a way as to reduce its potential for parenteral abuse.

(ii) For each new patient enrolled in a program, the initial dose of methadone shall not exceed 30 milligrams and the total dose for the first day shall not exceed 40 milligrams, 
	 unless the program physician documents in the patient's record that 40 milligrams did not suppress opioid abstinence symptoms.

THEREFORE: I do think it is reasonable to output the data in this form as it will allow us to complete appropriate data analysis since we need to start looking at things at the Tx Level
rather than the individual level. Since any subject who is started in treatment will start from scratch and will BUILDUP appropriately.

My next step is to go ahead and include this new DOSINGperEPI DS to the Secondary Analysis DS so we can begin identifying how trends are looking for thsoe 

Secondly: Defining dosing pattern characteristics of successful
tapers following methadone maintenance treatment:
results from a population-based retrospective
cohort studyadd_3870

Utilizes the treatment episode rather than the subject

SUCCESS Defined: Currently in treatment for 1 year or more since 
***/


proc export
data=methados.episodeslong
outfile="&ExportDir.\&ImportDate./Episodes one-per-row &ImportDate. &ImportTime..xlsx"
dbms=XLSX REPLACE;
run;


proc sort data = METHADOS.episodeslong;
	by ID;
run;



/*** Titled Dosing PER EPI so one can look at the individual dosing per episode ***/

data METHADOS.DOSINGperEPI (compress = YES);
	merge METHADOS.episodeslong METHADOS.master_all;
	by ID;
	array Days[*] Days1-Days5000;
    array Dose[*] Dose1-Dose5000;
    array ClinicP[*] $ 2 ClinicP1-ClinicP5000;
	array THB[*] THB1-THB5000;
	array EpiCount[*] EpiCount1-EpiCount5000;
	array Comment[*] $ 300 Comment1-Comment5000;
	array Drug[*] $ 100 Drug1-Drug5000;

	array Epi_Days[5000];
	array Epi_Dose[5000];
	array Epi_P[5000] $ 2;
	array Epi_THB[5000];
	array Epi_Comment[5000] $ 300;
	array Epi_Drug[5000] $ 100;

	FORMAT Epi_Days1-Epi_Days5000 MMDDYY10.;
	z = 1;

	do i = 1 to 5000;
		if Days[i] >= Episodes_DateAdmit then do;
			if Episodes_DateDischarge = .C AND Days[i] =< Extraction_Date then do;
				Epi_Days[z] = Days[i];
				Epi_Dose[z] = Dose[i];
				Epi_P[z] =  ClinicP[i];
				Epi_THB[z] = THB[i];
				Epi_Comment[z] = Comment[i];
				Epi_Drug[z] = Drug[i];
				z = z +1;
			end;
			else if Episodes_DateDischarge >= Days[i] then do;
				Epi_Days[z] = Days[i];
				Epi_Dose[z] = Dose[i];
				Epi_P[z] =  ClinicP[i];
				Epi_THB[z] = THB[i];
				Epi_Comment[z] = Comment[i];
				Epi_Drug[z] = Drug[i];
				z = z +1;
			end;
		end;
	end;

	DROP Days1-Days5000 Dose1-Dose5000 ClinicP1-ClinicP5000 THB1-THB5000 EpiCount1-EpiCount5000 Comment1-Comment5000 SHWP1-SHWP5000 ClinicP1-ClinicP5000;

run;

		

/******* Integrating the Summary Data output w/ and w/o comments so it is now ran with all runs of the dataset *********/

proc printto log = "C:\Users\&sysuserid.\Rutgers University\SHWeiss Research Group - Data Extraction\All SAS Libraries\Logs\SummaryData &ImportDate. &ImportTime..log";
run;

data METHADOS.SummaryData;
	set METHADOS.master_all;
	
	array Days[*] Days1-Days5000;
    array Dose[*] Dose1-Dose5000;
    array ClinicP[*] $ ClinicP1-ClinicP5000;
	array THB[*] THB1-THB5000;
	array EpiCount[*] EpiCount1-EpiCount5000;
	array Comment[*] $ 300 Comment1-Comment5000;
	array Drug[*] $ 100 Drug1-Drug5000;

	array SummaryDose[500];
    array SummaryStartDate[500];
    array SummaryEndDate[500];
	array SummaryTHB[500];
	array SummaryP[500] $ 2;
	array SummaryEpiCount[500];
	array SummaryComment[500] $ 300;
	array SummaryDrug[500] $ 100;

	FORMAT SummaryStartDate1-SummaryStartDate500 MMDDYY10. SummaryEndDate1-SummaryEndDate500 MMDDYY10.;
    /************* START TO CREATE ARRAY OF DOSE CHANGES ACROSS SPAN of sequence -
    CONCEPT: immediately initialize the First Date and Dose to *******************/

    SummaryStartDate[1] = Days[1];
    SummaryDose[1] = Dose[1];
	SummaryEpiCount[1] = EpiCount[1];
	SummaryComment[1] = Comment[1];
	SummaryTHB[1] = THB[1];
	SummaryP[1] = ClinicP[1];
	SummaryDrug[1] = Drug[1];
    z = 1;

    /*********** RESOLVE PRIOR TO ANY MORE RUNS ********************/
        /********* CHECKING IF DOSE CHANGES DAY TO DAY ***************/

    do i = 1 to dim(days);
		if Dose[i] EQ .A OR Dose[i] EQ .D OR Dose[i] EQ .Z THEN CONTINUE;

        if (SummaryDose[z] EQ Dose[i]) AND (SummaryTHB[z] EQ THB[i]) then CONTINUE;
        else if (SummaryDose[z] NE Dose[i]) OR (SummaryTHB[z] NE THB[i]) then do;
            SummaryEndDate[z] = Days[i-1];
            z + 1;
            SummaryDose[z] = Dose[i];
            SummaryStartDate[z] = Days[i];
			SummaryEpiCount[z] = Epicount[i];
			SummaryComment[z] = Comment[i];
			SummaryTHB[z] = THB[i];
			SummaryP[z] = ClinicP[i];
			SummaryDrug[z] = Drug[i];
        end;
		else CONTINUE;
	end;
	keep ID NumDaysTx NumDaysDoseObserved CURRENT SummaryStartDate1-SummaryStartDate500 SummaryTHB1-SummaryTHB500
	SummaryEndDate1-SummaryEndDate500 SummaryDose1-SummaryDose500 SummaryEpiCount1-SummaryEpiCount500 SummaryP1-SummaryP500 
	SummaryDrug1-SummaryDrug500 SummaryComment1-SummaryComment500;
run;

%macro order_vars
			(max=500, 
			 list= SummaryStartDate SummaryEndDate SummaryDose SummaryTHB  SummaryP SummaryEpiCount SummaryComment SummaryDose);
      %global vars_in_order;
      %let no_of_vars = %sysfunc(countw(&list));
      %put no_of_vars = &no_of_vars ;

      %let vars_in_order = ;
       %do m=1 %to &max;
              %do i=1 %to &no_of_vars;
                    %let vars_in_order = &vars_in_order %scan(&list,&i)&m;
              %end;
      %end;
%mend order_vars;

%order_vars;

data METHADOS.SummaryData_reorder_w_comments;
	retain ID NumDaysTx NumDaysDoseObserved CURRENT &vars_in_order.;
	set METHADOS.SummaryData;
run;

data METHADOS.SummaryData_reorder_wo_comments;
	set METHADOS.SummaryData;
	DROP SummaryComment1-SummaryComment500;
run;

proc export data = METHADOS.SummaryData_reorder_w_comments outfile = "&ExportDir.\&ImportDate./SummaryData &ImportDate. &ImportTime..csv" DBMS = CSV REPLACE;
run;


proc export data = METHADOS.SummaryData_reorder_wo_comments outfile = "&ExportDir.\&ImportDate./SummaryData_wo_comments &ImportDate. &ImportTime..csv" DBMS = CSV REPLACE;
run;

/**** New summary data to go ahead and go from top to bottom. ****/

data METHADOS.summarydatareordertemp;
	set METHADOS.summarydata;
	array SummaryDose[500];
    array SummaryStartDate[500];
    array SummaryEndDate[500];
	array SummaryP[500] $ 2;
	array SummaryTHB[500];
	array SummaryEpiCount[500];
	array SummaryComment[500] $ 200;
	array SummaryDrug[500] $ 100;

	FORMAT SummaryStartDatetemp SummaryEndDatetemp MMDDYY10.;
	do i = 1 to 500;
		IF SummaryStartDate[i] > 0 and SummaryDose[i] > 0 then do;
			SummaryDosetemp = SummaryDose[i];
			SummaryStartDatetemp = SummaryStartDate[i];
			SummaryEndDatetemp = SummaryEndDate[i];
			SummaryTHBtemp = SummaryTHB[i];
			SummaryEpiCounttemp = SummaryEpiCount[i];
			SummaryCommenttemp = SummaryComment[i];
			SummaryDrugtemp = SummaryDrug[i];
		KEEP ID SummaryEpiCounttemp SummaryStartDatetemp SummaryEndDatetemp SummaryDosetemp SummaryTHBtemp SummaryCommenttemp SummaryDrugtemp;
		OUTPUT;
		END;
	end;
run; 


proc sort data = METHADOS.summarydosereorder;
	by ID SummaryEpiCounttemp SummaryStartDatetemp;
run;

data METHADOS.summarydatareorder;
	set METHADOS.summarydatareordertemp;
	by ID SummaryEpiCounttemp;
	
	LENGTH Subject_Flag Epi_Flag Drug_Flag $ 50;

	if FIRST.ID then Subject_Flag =  "New Subject";
	if LAST.ID then Subject_Flag = "Final Record for Subject";
	
	if First.SummaryEpiCounttemp then Epi_Flag = "New Episode for Subject";
	if Last.SummaryEpiCounttemp then Epi_Flag = "Last Dosing Record in Episode for Subject";

	SummaryDrugLag = LAG(SummaryDrugtemp);
	
	if SummaryDrugLag NE SummaryDrugtemp then do;
		if NOT(FIRST.ID) and NOT(Last.ID) then Drug_Flag = "Change in Drug";
	end;

	NumDays = (SummaryEndDatetemp - SummaryStartDatetemp) + 1;

	RENAME  SummaryDosetemp = SummaryDose
		 SummaryStartDatetemp = SummaryStartDate
		 SummaryEndDatetemp = SummaryEndDate
		 SummaryTHBtemp = SummaryTHB
		 SummaryEpiCounttemp = SummaryEpiCount
		 SummaryCommenttemp = SummaryComment
		 SummaryDrugtemp = SummaryDrug;
run;


proc export data = METHADOS.summarydatareorder outfile = "&ExportDir.\&ImportDate./SummaryDatareorder &ImportDate. &ImportTime..xlsx" DBMS = XLSX REPLACE;
run;

proc freq DATA = METHADOS.summarydatareorder;
	tables ID * SummaryDrug / LIST MISSING;
run;

	
proc printto;
run;


proc sort data = METHADOS.summarydatareorder;
	by ID;
run;

/**** Working with Verification, find out which patients are not in the datasets ***/
data _NULL_;
merge METHADOS.summarydatareorder (in = inDose KEEP = ID) sasuser.subjectids (KEEP = Subj_ID in = inMaster RENAME = (Subj_ID = ID));
by ID;
if inMaster = 1 and inDose = 0 then do;
	PUTLOG "Subject ID: " ID " is not in the summary database";
	Episodes = 0;
end;
if inMaster = 1 and inDose = 1 then Episodes = 1;
run;
