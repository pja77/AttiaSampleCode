LIBNAME SNEW "/data/datasets_new";

data SNEW.selectedpatient_EMR2;
	set SNEW.selected_CN (in=inCN)
		SNEW.selectedpatient_EMR
		SNEW.selected_DYSPHAGIA
		SNEW.Cerumen (in=inCerumen);

	CranialNerve = inCN;
	Cerumen_temp = inCerumen;

RUN;

ods excel file = "/data/AllSNOMEDcodes.xlsx";
proc freq data=SNEW.selectedpatient_emr2;
	table condition_concept_id * standard_concept_name * standard_concept_code * standard_vocabulary / LIST MISSING;
	table condition_concept_id * standard_concept_name * standard_concept_code * standard_vocabulary * condition_source_value * source_concept_name * source_concept_code / LIST MISSING;
run;
ods excel close;


ods excel file = "/data/AllSNOMEDcodes_Cerumen.xlsx";
proc freq data=SNEW.selectedpatient_emr2;
	where Cerumen_temp;
	table condition_concept_id * standard_concept_name * standard_concept_code * standard_vocabulary / LIST MISSING;
	table condition_concept_id * standard_concept_name * standard_concept_code * standard_vocabulary * condition_source_value * source_concept_name * source_concept_code / LIST MISSING;
run;
ods excel close;


proc sort data = SNEW.selectedpatient_EMR2;
	by person_id condition_start_datetime;
run;

data SNEW.EMRabstract_2;
	set SNEW.selectedpatient_EMR2;
	by person_id;
	retain Sarcoid Sarcoid_diagnosisdate 
			Dysphonia Dysphonia_diagnosisdate 
			ChronicSinusitis ChronicSinusitis_diagnosisdate
			ChronicRhinitis ChronicRhinitis_diagnosisdate
			VocalCordParalysis VCParalysis_diagnosisdate
			ExtrapulmonarySarcoidosis EPSarcoid_DxDate
			CN_Pathologies CN_DxDate DATE_FIRST_RECORD
			Epistaxis Epistaxis_diagnosisdate
			Polyps Polyps_diagnosisdate
			Dysphagia Dysphagia_diagnosisdate;
	
	if FIRST.person_id then do;
		if INDEX(UPCASE(standard_concept_name), "SARCOID") > 0  then do;
				Sarcoid_diagnosisdate = condition_start_datetime;
				Sarcoid = 1;
		end;
		else do;
		 CALL MISSING(Sarcoid_diagnosisdate);
		 CALL MISSING(Sarcoid);
		end;

		if CONDITION_CONCEPT_ID IN (374375, 760047, 760147, 760186)
		then do;
			Cerumen_diagnosisdate = condition_start_datetime;
			Cerumen = 1;
		end;
		else do;
			CALL MISSING(Cerumen_diagnosisdate);
			CALL MISSING(Cerumen);
		end;

		if CONDITION_CONCEPT_ID IN (26823, 31317, 36716717, 4055360, 4254223, 4278990, 440530, 45757559)
		then do;
			Dysphagia_diagnosisdate = condition_start_datetime;
			Dysphagia = 1;
		end;
		else do;
			CALL MISSING(Dysphagia_diagnosisdate);
			CALL MISSING(Dysphagia);
		end;

		if STANDARD_CONCEPT_CODE IN ("249366005","232357009") THEN DO;
			Epistaxis = 1;
			Epistaxis_diagnosisdate = condition_start_datetime;
		END;
		else do;
			CALL MISSING(Epistaxis);
			CALL MISSING(Epistaxis_diagnosisdate);
		end;

		if STANDARD_CONCEPT_CODE IN ("195847009","9078005") THEN DO;
			Polyps = 1;
			Polyps_diagnosisdate = condition_start_datetime;
		END;
		else do;
			CALL MISSING(Polyps);
			CALL MISSING(Polyps_diagnosisdate);
		end;

		if STANDARD_CONCEPT_CODE IN ("4416007",
		"21787007",
		"37061001",
		"39041004",
		"55941000",
		"64757003",
		"72470008",
		"75403004",
		"80941006",
		"187233002",
		"192673008",
		"193101001",
		"193195000",
		"193251003",
		"195033009",
		"230193008",
		"238676008",
		"361197009",
		"361198004",
		"724780002",
		"735433009",
		"352941000119102",
		"1082551000119100") then do;
			ExtrapulmonarySarcoidosis = 1;
			EPSarcoid_DxDate = condition_start_datetime;
		end;
		else do;
			CALL MISSING(ExtrapulmonarySarcoidosis);
			CALL MISSING(EPSarcoid_DxDate);
		end;

		if standard_concept_code IN ("31681005", "193093009") then do;
			CN_Pathologies = 1;
			CN_DxDate = condition_start_datetime;
		end;
		else do;
			CALL MISSING(CN_Pathologies);
			CALL MISSING(CN_DxDate);
		end;

		if standard_concept_code = "16617009" 
			OR standard_concept_code = "286378009" then do;
			Dysphonia_diagnosisdate = condition_start_datetime;
			Dysphonia = 1;
		end;
		else do;
			CALL MISSING(Dysphonia_diagnosisdate);
			CALL MISSING(Dysphonia);
		end;
	
		if condition_concept_id IN (761761, 132932, 139841, 4051488, 761762, 
		4051487, 4179673, 765276, 257012, 134661) then do;
			ChronicSinusitis_diagnosisdate = condition_start_datetime;
			ChronicSinusitis = 1;
		end;
		else do;
			CALL MISSING(ChronicSinusitis_diagnosisdate);
			CALL MISSING(ChronicSinusitis);
		end;

		if condition_concept_id IN (4101701, 4110489, 259848, 42872416, 4270705, 619760) then do;
			ChronicRhinitis_diagnosisdate = condition_start_datetime;
			ChronicRhinitis = 1;
		end;
		else do;
			CALL MISSING(ChronicRhinitis_diagnosisdate);
			CALL MISSING(ChronicRhinitis);
		end;

		if standard_concept_code = "195844002" OR
		standard_concept_code = "42655007" OR
		standard_concept_code = "787603009" OR
		standard_concept_code = "787604003" OR
		standard_concept_code = "764724007" OR
		standard_concept_code = "764726009" OR
		standard_concept_code = "1052239007" OR
		standard_concept_code = "1052240009" OR
		standard_concept_code = "302912005" then do;
			VocalCordParalysis = 1;
			VCParalysis_diagnosisdate = condition_start_datetime;
		end;
		else do;
			CALL MISSING(VocalCordParalysis);
			CALL MISSING(VCParalysis_diagnosisdate);
		end;


		if STANDARD_CONCEPT_CODE IN ("1082551000119100",
		"10890000",
		"14756005",
		"28826002",
		"42982001",
		"45338009",
		"48128006",
		"69825009",
		"75260002",
		"78948009",
		"87715008",
		"88850006",
		"92205005",
		"92279000",
		"92415001",
		"93883004",
		"94989005",
		"109764005",
		"126788000",
		"189362009",
		"255155005",
		"271613005",
		"271614004",
		"271615003",
		"300257000",
		"300879004",
		"315284009",
		"372004005",
		"15635051000119100") then do;
			SalivaryGlandPathologies = 1;
			Salivary_DxDate = condition_start_datetime;
		end;
		else do;
			CALL MISSING(SalivaryGlandPathologies);
			CALL MISSING(Salivary_StartDate);
		end;
	end;

	if INDEX(UPCASE(standard_concept_name), "SARCOID") > 0 AND MISSING(Sarcoid_diagnosisdate) then do;
			Sarcoid_diagnosisdate = condition_start_datetime;
			Sarcoid = 1;
	end;

	if CONDITION_CONCEPT_ID IN (374375, 760047, 760147, 760186) AND MISSING(Cerumen_diagnosisdate) 
		then do;
			Cerumen_diagnosisdate = condition_start_datetime;
			Cerumen = 1;
		end;
	if STANDARD_CONCEPT_CODE IN ("249366005","232357009") AND MISSING(Epistaxis_diagnosisdate) THEN DO;
		Epistaxis = 1;
		Epistaxis_diagnosisdate = condition_start_datetime;
	END;

	if STANDARD_CONCEPT_CODE IN ("195847009","9078005") AND MISSING(Polyps_diagnosisdate) THEN DO;
		Polyps = 1;
		Polyps_diagnosisdate = condition_start_datetime;
	END;

	if standard_concept_code = "16617009" OR standard_concept_code = "286378009" AND MISSING(Dysphonia_diagnosisdate) then do;
			Dysphonia_diagnosisdate = condition_start_datetime;
			Dysphonia = 1;
	end;

	if condition_concept_id IN (761761, 132932, 139841, 4051488, 761762, 
	4051487, 4179673, 765276, 257012, 134661) AND MISSING(ChronicSinusitis_diagnosisdate) then do;
		ChronicSinusitis_diagnosisdate = condition_start_datetime;
		ChronicSinusitis = 1;
	end;

	if condition_concept_id IN (4101701, 4110489, 259848, 42872416, 4270705, 619760) AND MISSING(ChronicRhinitis_diagnosisdate) then do;
		ChronicRhinitis_diagnosisdate = condition_start_datetime;
		ChronicRhinitis = 1;
	end;

	if standard_concept_code = "195844002" OR
	standard_concept_code = "42655007" OR
	standard_concept_code = "787603009" OR
	standard_concept_code = "787604003" OR
	standard_concept_code = "764724007" OR
	standard_concept_code = "764726009" OR
	standard_concept_code = "1052239007" OR
	standard_concept_code = "1052240009" OR
	standard_concept_code = "302912005" AND MISSING(VCParalysis_diagnosisdate) then do;
			VocalCordParalysis = 1;
			VCParalysis_diagnosisdate = condition_start_datetime;
	end;

	if STANDARD_CONCEPT_CODE IN ("4416007",
	"21787007",
	"37061001",
	"39041004",
	"55941000",
	"64757003",
	"72470008",
	"75403004",
	"80941006",
	"187233002",
	"192673008",
	"193101001",
	"193195000",
	"193251003",
	"195033009",
	"230193008",
	"238676008",
	"361197009",
	"361198004",
	"724780002",
	"735433009",
	"352941000119102") AND MISSING(ExtrapulmonarySarcoidosis) then do;
		ExtrapulmonarySarcoidosis = 1;
		EPSarcoid_DxDate = condition_start_datetime;
	end;

	if standard_concept_code IN ("31681005", "193093009","193101001") AND MISSING(CN_Pathologies)  then do;
		CN_Pathologies = 1;
		CN_DxDate = condition_start_datetime;
	end;


	if STANDARD_CONCEPT_CODE IN ("1082551000119100",
	"10890000",
	"14756005",
	"28826002",
	"42982001",
	"45338009",
	"48128006",
	"69825009",
	"75260002",
	"78948009",
	"87715008",
	"88850006",
	"92205005",
	"92279000",
	"92415001",
	"93883004",
	"94989005",
	"109764005",
	"126788000",
	"189362009",
	"255155005",
	"271613005",
	"271614004",
	"271615003",
	"300257000",
	"300879004",
	"315284009",
	"372004005",
	"15635051000119100") AND MISSING(Salivary_StartDate) then do;
		SalivaryGlandPathologies = 1;
		Salivary_DxDate = condition_start_datetime;
	end;

	if CONDITION_CONCEPT_ID IN (26823, 31317, 36716717, 4055360, 4254223, 4278990, 440530, 45757559)    
	AND MISSING(Dysphagia_diagnosisdate) then do;
		Dysphagia_diagnosisdate = condition_start_datetime;
		Dysphagia = 1;
	end;
run;

proc sort data = SNEW.EMRabstract_2;
	by person_id condition_start_datetime;
run;

data SNEW.EMR_onepersubject_2;
	set SNEW.EMRabstract_2 
		(RENAME = (Dysphonia_diagnosisdate = Dysphonia_dt_temp
					Sarcoid_diagnosisdate = Sarcoid_dt_temp
					ChronicSinusitis_diagnosisdate = ChronicSinusitis_dt_temp
					ChronicRhinitis_diagnosisdate = ChronicRhinitis_dt_temp
					VCParalysis_diagnosisdate = VCParalysis_dt_temp
					EPSarcoid_DxDate = EPSarcoid_dt_temp
					Salivary_DxDate = Salivary_dt_temp
					CN_DxDate = CN_dt_temp
					Polyps_diagnosisdate = Polyps_dt_temp
					Epistaxis_diagnosisdate = Epistaxis_dt_temp
					Dysphagia_diagnosisdate = Dysphagia_dt_temp
					Cerumen_DiagnosisDate = Cerumen_dt_temp));
	by PERSON_ID;

	ATTRIB Dysphonia_diagnosisdate 
			FORMAT=MMDDYY10.
			LABEL= "Earliest Date of Dysphonia Diagnosis"
		  Sarcoid_diagnosisdate 
			FORMAT=MMDDYY10.
			LABEL= "Earliest Date of Sarcoidosis Diagnosis"
		  ChronicRhinitis_diagnosisdate
			FORMAT=MMDDYY10.
			LABEL = "Earliest Date of Chronic Rhinitis Dx"
		  ChronicSinusitis_diagnosisdate
			FORMAT=MMDDYY10.
			LABEL = "Earliest Date of Chronic Sinusitis Dx"
		  EPSarcoid_DxDate
			FORMAT = MMDDYY10.
			LABEL = "Earliest Date of Extrapulm Sarcoidosis"
		  VCParalysis_diagnosisdate
			FORMAT = MMDDYY10.
			LABEL = "Earliest Date of VC Paralysis"
		  Sarcoid 
			LABEL = "Does the patient have a diagnosis of Sarcoidosis"
		  Dysphonia
			LABEL = "Does the patient have a diagnosis of Dysphonia"
		  ChronicRhinitis
			LABEL = "Does the patient have a diagnosis of Chronic Rhinitis"
		  ChronicSinusitis
			LABEL = "Does the patient have a diagnosis of Chronic Sinusitis"
		  SalivaryGlandPathologies
			LABEL = "Does the patient have any salivary gland pathologies?"
		  ExtrapulmonarySarcoidosis
			LABEL = "Does the patient have any extrapulm sarcoidosis"
		  Salivary_DxDate
			FORMAT = MMDDYY10.
			LABEL = "Earliest Date of Salivary Pathologies"
		  CN_Pathologies
			LABEL = "Does the patient have any Cranial Nerve Pathologies"
		  Epistaxis
			LABEL = "Does the patient have any Epistaxis"
		  Epistaxis_diagnosisdate
			FORMAT = MMDDYY10.
			LABEL = "Epistaxis diagnosis date"
		  Polyps 
			LABEL = "Polyps of Larynx, Vocal Cords"
		  Polyps_diagnosisdate
			FORMAT = MMDDYY10.
			LABEL = "Diagnosis date of Polyps of Larynx and Vocal Cords"
		  Dysphagia
			LABEL = "Does the patient have a dx of Dysphagia"
		  Dysphagia_diagnosisdate 
			FORMAT=MMDDYY10.
			LABEL= "Earliest Date of Dysphagia Diagnosis"
		  Cerumen
			LABEL = "Does the patiennet have a Cerumen Diagnosis"
		  Cerumen_DiagnosisDate
			FORMAT = MMDDYY10.
			LABEL = "Cerumen Dx Date";

	Dysphonia_diagnosisdate = DATEPART(Dysphonia_dt_temp);
	Sarcoid_diagnosisdate = DATEPART(Sarcoid_dt_temp);	
	ChronicSinusitis_diagnosisdate = DATEPART(ChronicSinusitis_dt_temp);
	ChronicRhinitis_diagnosisdate = DATEPART(ChronicRhinitis_dt_temp);
	VCParalysis_diagnosisdate = DATEPART(VCParalysis_dt_temp);
	EPSarcoid_DxDate = DATEPART(EPSarcoid_dt_temp);
	CN_DxDate = DATEPART(CN_dt_temp);
	Salivary_DxDate = DATEPART(Salivary_dt_temp);
	Epistaxis_diagnosisdate = DATEPART(Epistaxis_dt_temp);
	Polyps_diagnosisdate = DATEPART(Polyps_dt_temp);
	Dysphagia_DiagnosisDate = DATEPART(Dysphagia_dt_temp);
	Cerumen_DiagnosisDate = DATEPART(Cerumen_dt_temp);


	IF SARCOID = 1 then do;
		if NOT(MISSING(Dysphonia_diagnosisdate)) then do;
			if Dysphonia_diagnosisdate > Sarcoid_diagnosisdate then do;
				Dysphonia_RelativeTime = 1;
				TimefromDxtoDysphonia = Dysphonia_diagnosisdate - Sarcoid_diagnosisdate;
			end;
			else if Dysphonia_diagnosisdate < Sarcoid_diagnosisdate then do;
				Dysphonia_RelativeTime = -1;
				TimefromDxtoDysphonia = Dysphonia_diagnosisdate - Sarcoid_diagnosisdate;
			end;
			else if Dysphonia_diagnosisdate = Sarcoid_diagnosisdate then do;
				Dysphonia_RelativeTime = 0;
				TimefromDxtoDysphonia = Dysphonia_diagnosisdate - Sarcoid_diagnosisdate;
			end;
		end;
	
		if NOT(MISSING(ChronicSinusitis_diagnosisdate)) then do;
			if ChronicSinusitis_diagnosisdate > Sarcoid_diagnosisdate then do;
				Sinusitis_RelativeTime = 1;
				TimefromDxtoSinusitis = ChronicSinusitis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
			else if ChronicSinusitis_diagnosisdate < Sarcoid_diagnosisdate then do;
				Sinusitis_RelativeTime = -1;
				TimefromDxtoSinusitis = ChronicSinusitis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
			else if ChronicSinusitis_diagnosisdate = Sarcoid_diagnosisdate then do;
				Sinusitis_RelativeTime = 0;
				TimefromDxtoSinusitis = ChronicSinusitis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
		end;
		
		if NOT(MISSING(ChronicRhinitis_diagnosisdate)) then do;
			if ChronicRhinitis_diagnosisdate > Sarcoid_diagnosisdate then do;
				Rhinitis_RelativeTime = 1;
				TimefromDxtoRhinitis = ChronicRhinitis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
			else if ChronicRhinitis_diagnosisdate < Sarcoid_diagnosisdate then do;
				Rhinitis_RelativeTime = -1;
				TimefromDxtoRhinitis = ChronicRhinitis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
			else if ChronicRhinitis_diagnosisdate = Sarcoid_diagnosisdate then do;
				Rhinitis_RelativeTime = 0;
				TimefromDxtoRhinitis = ChronicRhinitis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
		end;
	
		if NOT(MISSING(VCParalysis_diagnosisdate)) then do;
			if VCParalysis_diagnosisdate > Sarcoid_diagnosisdate then do;
				VCParalysis_RelativeTime = 1;
				TimefromDxtoVCParalysis = VCParalysis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
			else if VCParalysis_diagnosisdate < Sarcoid_diagnosisdate then do;
				VCParalysis_RelativeTime = -1;
				TimefromDxtoVCParalysis = VCParalysis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
			else if VCParalysis_diagnosisdate = Sarcoid_diagnosisdate then do;
				VCParalysis_RelativeTime = 0;
				TimefromDxtoVCParalysis = VCParalysis_diagnosisdate - Sarcoid_diagnosisdate;
			end;
		end;	
	
		IF NOT(MISSING(EPSarcoid_DxDate)) THEN DO;
		    IF EPSarcoid_DxDate > Sarcoid_diagnosisdate THEN DO;
		        EPSarcoid_RelativeTime = 1;
		        TimefromDxtoEPSarcoid = EPSarcoid_DxDate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF EPSarcoid_DxDate < Sarcoid_diagnosisdate THEN DO;
		        EPSarcoid_RelativeTime = -1;
		        TimefromDxtoEPSarcoid = EPSarcoid_DxDate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF EPSarcoid_DxDate = Sarcoid_diagnosisdate THEN DO;
		        EPSarcoid_RelativeTime = 0;
		        TimefromDxtoEPSarcoid = EPSarcoid_DxDate - Sarcoid_diagnosisdate;
		    END;
		END;
		
		IF NOT(MISSING(CN_DxDate)) THEN DO;
		    IF CN_DxDate > Sarcoid_diagnosisdate THEN DO;
		        CN_RelativeTime = 1;
		        TimefromDxtoCN = CN_DxDate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF CN_DxDate < Sarcoid_diagnosisdate THEN DO;
		        CN_RelativeTime = -1;
		        TimefromDxtoCN = CN_DxDate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF CN_DxDate = Sarcoid_diagnosisdate THEN DO;
		        CN_RelativeTime = 0;
		        TimefromDxtoCN = CN_DxDate - Sarcoid_diagnosisdate;
		    END;
		END;
		
		IF NOT(MISSING(Salivary_DxDate)) THEN DO;
		    IF Salivary_DxDate > Sarcoid_diagnosisdate THEN DO;
		        Salivary_RelativeTime = 1;
		        TimefromDxtoSalivary = Salivary_DxDate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF Salivary_DxDate < Sarcoid_diagnosisdate THEN DO;
		        Salivary_RelativeTime = -1;
		        TimefromDxtoSalivary = Salivary_DxDate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF Salivary_DxDate = Sarcoid_diagnosisdate THEN DO;
		        Salivary_RelativeTime = 0;
		        TimefromDxtoSalivary = Salivary_DxDate - Sarcoid_diagnosisdate;
		    END;
		END;
		
		IF NOT(MISSING(Epistaxis_diagnosisdate)) THEN DO;
		    IF Epistaxis_diagnosisdate > Sarcoid_diagnosisdate THEN DO;
		        Epistaxis_RelativeTime = 1;
		        TimefromDxtoEpistaxis = Epistaxis_diagnosisdate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF Epistaxis_diagnosisdate < Sarcoid_diagnosisdate THEN DO;
		        Epistaxis_RelativeTime = -1;
		        TimefromDxtoEpistaxis = Epistaxis_diagnosisdate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF Epistaxis_diagnosisdate = Sarcoid_diagnosisdate THEN DO;
		        Epistaxis_RelativeTime = 0;
		        TimefromDxtoEpistaxis = Epistaxis_diagnosisdate - Sarcoid_diagnosisdate;
		    END;
		END;
		
		IF NOT(MISSING(Polyps_diagnosisdate)) THEN DO;
		    IF Polyps_diagnosisdate > Sarcoid_diagnosisdate THEN DO;
		        Polyps_RelativeTime = 1;
		        TimefromDxtoPolyps = Polyps_diagnosisdate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF Polyps_diagnosisdate < Sarcoid_diagnosisdate THEN DO;
		        Polyps_RelativeTime = -1;
		        TimefromDxtoPolyps = Polyps_diagnosisdate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF Polyps_diagnosisdate = Sarcoid_diagnosisdate THEN DO;
		        Polyps_RelativeTime = 0;
		        TimefromDxtoPolyps = Polyps_diagnosisdate - Sarcoid_diagnosisdate;
		    END;
		END;
		
		IF NOT(MISSING(Dysphagia_DiagnosisDate)) THEN DO;
		    IF Dysphagia_DiagnosisDate > Sarcoid_diagnosisdate THEN DO;
		        Dysphagia_RelativeTime = 1;
		        TimefromDxtoDysphagia = Dysphagia_DiagnosisDate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF Dysphagia_DiagnosisDate < Sarcoid_diagnosisdate THEN DO;
		        Dysphagia_RelativeTime = -1;
		        TimefromDxtoDysphagia = Dysphagia_DiagnosisDate - Sarcoid_diagnosisdate;
		    END;
		    ELSE IF Dysphagia_DiagnosisDate = Sarcoid_diagnosisdate THEN DO;
		        Dysphagia_RelativeTime = 0;
		        TimefromDxtoDysphagia = Dysphagia_DiagnosisDate - Sarcoid_diagnosisdate;
		    END;
		END;
	END;

	if LAST.PERSON_ID THEN do;
		if MISSING(Dysphonia) then Dysphonia = 0;
		if MISSING(Sarcoid) then Sarcoid = 0;
		if MISSING(ChronicRhinitis) then ChronicRhinitis = 0;
		if MISSING(ChronicSinusitis) then ChronicSinusitis = 0;
		if MISSING(VocalCordParalysis) then VocalCordParalysis = 0;
		IF MISSING(ExtrapulmonarySarcoidosis) AND SARCOID = 1 then ExtrapulmonarySarcoidosis = 0;
		IF MISSING(SalivaryGlandPathologies) then SalivaryGlandPathologies = 0;
		IF MISSING(CN_Pathologies) then CN_Pathologies = 0;
		IF MISSING(Epistaxis) then Epistaxis= 0;
		IF MISSING(Polyps) THEN Polyps = 0;
		IF MISSING(Dysphagia) THEN Dysphagia = 0;
		IF MISSING(Cerumen) then Cerumen = 0;
	   OUTPUT;
	end;
run;


proc sort data = SNEW.EMR_onepersubject_2 NODUPKEY dupout=dups;
	by PERSON_ID;
run;

proc sort data = SNEW.PTSelection;
	by PERSON_ID;
run;

proc sort data = SNEW.covariates;
	by PERSON_ID;
run;

proc sort data = SNEW.CCI_AOU_2;
	by PERSON_ID;
run;


data SNEW.ANALYTICDATASET_NEW;
	merge SNEW.EMR_onepersubject_2 (in = EMR)
		  SNEW.PTSelection (in = PtSelection
							RENAME = (date_of_birth=DOB_temp))
		  SNEW.EMR_FINALDATE
		  SNEW.CONSENTDATES
		  SNEW.FINALDATE
		  SNEW.CCI_AOU_2
		  SNEW.covariates
	  	  SNEW.HealthInsurnace_merge;
	by PERSON_ID;


	ATTRIB date_of_birth 
			FORMAT=MMDDYY10.
			LABEL= "Date of Birth";
	
	overall = 1;
	
	if PtSelection;

	date_of_birth = DATEPART(DOB_temp);

	EMR_FOLLOWUPTIME = intck('year',EMR_STARTDATE,EMR_FINALDATE);
	OBSERVE_FOLLOWUPTIME = intck('year',OBSERVE_STARTDATE,OBSERVE_FINALDATE);
	
	IF NOT(MISSING(Dysphonia_diagnosisdate)) THEN 
	    Dysphonia_AgeDx = INTCK("YEAR", date_of_birth, Dysphonia_diagnosisdate);
	
	IF NOT(MISSING(Sarcoid_diagnosisdate)) THEN 
	    Sarcoid_AgeDx = INTCK("YEAR", date_of_birth, Sarcoid_diagnosisdate);
	
	IF NOT(MISSING(ChronicSinusitis_diagnosisdate)) THEN 
	    ChronicSinusitis_AgeDx = INTCK("YEAR", date_of_birth, ChronicSinusitis_diagnosisdate);
	
	IF NOT(MISSING(ChronicRhinitis_diagnosisdate)) THEN 
	    ChronicRhinitis_AgeDx = INTCK("YEAR", date_of_birth, ChronicRhinitis_diagnosisdate);
	
	IF NOT(MISSING(VCParalysis_diagnosisdate)) THEN 
	    VCParalysis_AgeDx = INTCK("YEAR", date_of_birth, VCParalysis_diagnosisdate);
	
	IF NOT(MISSING(EPSarcoid_DxDate)) THEN 
	    EPSarcoid_AgeDx = INTCK("YEAR", date_of_birth, EPSarcoid_DxDate);
	
	IF NOT(MISSING(CN_DxDate)) THEN 
	    CN_AgeDx = INTCK("YEAR", date_of_birth, CN_DxDate);
	
	IF NOT(MISSING(Salivary_DxDate)) THEN 
	    Salivary_AgeDx = INTCK("YEAR", date_of_birth, Salivary_DxDate);
	
	IF NOT(MISSING(Epistaxis_diagnosisdate)) THEN 
	    Epistaxis_AgeDx = INTCK("YEAR", date_of_birth, Epistaxis_diagnosisdate);
	
	IF NOT(MISSING(Polyps_diagnosisdate)) THEN 
	    Polyps_AgeDx = INTCK("YEAR", date_of_birth, Polyps_diagnosisdate);
	
	IF NOT(MISSING(Dysphagia_DiagnosisDate)) THEN 
	    Dysphagia_AgeDx = INTCK("YEAR", date_of_birth, Dysphagia_DiagnosisDate);

	
	if primary_consent_date < 50 then CCI_Age_Score = 0;
	else if primary_consent_date >= 50 AND primary_consent_date <= 59 then CCI_Age_Score = 1;
	else if primary_consent_date >= 60 AND primary_consent_date <= 69 then CCI_Age_Score = 2;
	else if primary_consent_date >= 70 AND primary_consent_date <= 79 then CCI_Age_Score = 3;
	else if primary_consent_date >= 80 then CCI_Age_Score = 4;


	if CCI_CHF = 1 then do;
		 CCI_NEW_CHF_SCORE = 2;
		 CCI_CHF_SCORE = 1;
	end;
	else do;
		 CCI_NEW_CHF_SCORE = 0;
		 CCI_CHF_SCORE = 0;
	end;

	if CCI_MI = 1 then CCI_MI_Score = 1;
	else CCI_MI_Score = 0;
	
	if CCI_PVD = 1 then CCI_PVD_Score = 1;
	else CCI_PVD_Score = 0;
	
	if CCI_CVD = 1 then CCI_CVD_Score = 1;
	else CCI_CVD_Score = 0;
	
	if CCI_Dementia = 1 then do;
		 CCI_NEW_Dementia_Score = 2;
		 CCI_Dementia_Score = 1;
	end;
	else do;
		CCI_Dementia_Score  = 0;
		CCI_NEW_Dementia_Score = 0;
	end;

	if CCI_Pulmonary = 1 then CCI_Pulm_Score = 1;
	else CCI_Pulm_Score = 0;

	if CCI_RheumDx = 1 then CCI_RheumDx_Score = 1;
	else CCI_RheumDx_Score = 0;
	
	if CCI_PUD = 1 then CCI_PUD_Score = 1;
	else CCI_PUD_Score = 0;

	if CCI_DM_w_Comp = 1 then do;
		CCI_DM_Score = 2;
		CCI_NEW_DM_SCORE = 1;
	end;
	else if CCI_DM_wo_Comp = 1 then do;
		CCI_DM_Score = 1;
		CCI_NEW_DM_SCORE = 0;
	end;
	else do;
		CCI_DM_Score = 0;
		CCI_NEW_DM_SCORE = 0;
	end;

	if CCI_Hemiplegia = 1 then CCI_Hemiplegia_Score = 2;
	else CCI_Hemiplegia_Score = 0;

	if CCI_Renal = 1 then do;
		CCI_RenalDx_Score = 2;
		CCI_NEW_RenalDx_Score = 1;
	end;
	else do;
		CCI_RenalDx_Score = 0;
		CCI_NEW_RenalDx_Score = 0;
	end;

	if CCI_MetastaticTumor = 1 then CCI_Tumor_Score =  6;
	else if CCI_Malignancy = 1 then CCI_Tumor_Score = 2;
	else CCI_Tumor_Score = 0;

	if CCI_HIVAIDS = 1 then do;
		CCI_AIDS_SCORE = 6;
		CCI_NEW_AIDS_SCORE = 4;
	end;
	else do;
	   CCI_AIDS_SCORE = 0;
	   CCI_NEW_AIDS_SCORE = 0;
	end;

	if CCI_MildLiverDx_New then do;
		CCI_NEW_LIVER_SCORE = 2;
	end;
	else if CCI_ModSevereLiverDx_New then do;
		CCI_NEW_LIVER_SCORE = 4;
	end;
	else CCI_NEW_LIVER_SCORE = 0;



	CCI_SCORE = SUM(CCI_AIDS_SCORE,
	CCI_Age_Score,
	CCI_CVD_Score,
	CCI_RheumDx_Score,
	CCI_DM_Score,
	CCI_Dementia_Score,
	CCI_Hemiplegia_Score,
	CCI_MI_Score,
	CCI_PUD_Score,
	CCI_PVD_Score,
	CCI_Pulm_Score,
	CCI_RenalDx_Score,
	CCI_Tumor_Score);

	CCI_NEW_SCORE = SUM(CCI_NEW_CHF_SCORE, 
	CCI_NEW_Dementia_Score, 
	CCI_Pulm_Score,
	CCI_RheumDx_Score,
	CCI_NEW_DM_SCORE,
	CCI_NEW_LIVER_SCORE,
	CCI_Hemiplegia_Score,
	CCI_NEW_RenalDx_Score, CCI_NEW_AIDS_SCORE, CCI_Tumor_Score);

	/*** NEW INSURANCE ***/

	if INSURANCE = "Uninsured" then Uninsured = 1;
	else Uninsured = 0;

	if INSURANCE IN ("State or Federaly Sponsored","Private - Employer-Based, Individual, or Other") then Insured = 1;
	else Insured = 0;


	if PtSelection AND NOT(EMR) then do;
		if MISSING(Dysphonia) then Dysphonia = 0;
		if MISSING(Sarcoid) then Sarcoid = 0;
		if MISSING(ChronicRhinitis) then ChronicRhinitis = 0;
		if MISSING(ChronicSinusitis) then ChronicSinusitis = 0;
		if MISSING(VocalCordParalysis) then VocalCordParalysis = 0;
		IF MISSING(ExtrapulmonarySarcoidosis) AND SARCOID = 1 then ExtrapulmonarySarcoidosis = 0;
		IF MISSING(SalivaryGlandPathologies) then SalivaryGlandPathologies = 0;
		IF MISSING(CN_Pathologies) then CN_Pathologies = 0;
		IF MISSING(Epistaxis) then Epistaxis= 0;
		IF MISSING(Polyps) THEN Polyps = 0;
		IF MISSING(Dysphagia) THEN Dysphagia = 0;
		IF MISSING(Cerumen) then Cerumen = 0;
	end;
RUN;

%macro getORAdjust(varlist);
    %let n = %sysfunc(countw(&varlist));

    /* Create an empty dataset to store results */
    data OddsRatios_Adjust;
        length Variable $50. OddsRatioEst LowerCL UpperCL p_value 8.;
        stop;
    run;

    /* Loop through each variable */
    %do i=1 %to &n;
        %let var = %scan(&varlist, &i);

        proc logistic data=SNEW.ANALYTICDATASET_NEW;
            class &var (ref='0') OtherInflammatoryConditions AutoimmuneConditions SMOKING; /* Use if categorical */
            model SARCOIDOSIS(event='1') = &var OtherInflammatoryConditions AutoimmuneConditions SMOKING;
            ods output OddsRatios=&var.A ParameterEstimates=PE_&var.A;
        run;

        /* Extract only the relevant p-value */
        data PE_&varA;
            set PE_&var.A;
            if variable = "&var"; /* Filter for the correct variable */
            keep variable ProbChiSq;
            rename ProbChiSq = p_value;
        run;

        /* Merge Odds Ratios with p-value */
        data &var.;
            merge &var.A PE_&var.A;
            Variable = "&var"; /* Ensure variable name is included */
        run;

        /* Append results */
        proc append base=SNEW.OddsRatios_Adjust data=&var force;
        run;

    %end;
%mend;

/* Run the macro for specific variables */
%getORAdjust(Dysphonia ChronicRhinitis ChronicSinusitis VocalCordParalysis SalivaryGlandPathologies CN_Pathologies Epistaxis Polyps Dysphagia);

proc print data = SNEW.OddsRatios_Adjust;
	where INDEX(Effect, "1 vs 0") > 0;
run;

proc export data=SNEW.OddsRatios_All
			outfile="/data/Laryngeal Sarcoidosis/OddsRatios.xls"
			DBMS = xls
			REPLACE;
RUN;

/***** CCI ***/

%macro getCCIORAdjust(varlist);
    %let n = %sysfunc(countw(&varlist));


    /* Loop through each variable */
    %do i=1 %to &n;
        %let var = %scan(&varlist, &i);
		TITLE "Unadjusted Odds ";
        proc logistic data=SNEW.ANALYTICDATASET_NEW;
            class &var (ref='0');  /* Use if categorical */
            model SARCOIDOSIS(event='1') = &var ;
			oddsratio &var.;
        run;
    %end;

    %do i=1 %to &n;
        %let var = %scan(&varlist, &i);
		TITLE "Adjusted Odds - controlling for Autoimmune Diseases and Smoking";
        proc logistic data=SNEW.ANALYTICDATASET_NEW;
            class &var (ref='0') AutoimmuneConditions SMOKING; /* Use if categorical */
            model SARCOIDOSIS(event='1') = &var AutoimmuneConditions SMOKING;
			oddsratio &var.;
        run;
    %end;


    /* Loop through each variable */
    %do i=1 %to &n;
        %let var = %scan(&varlist, &i);
		TITLE "Adjusted Odds - controlling for Autoimmune Diseases, Smoking, and CCI";
        proc logistic data=SNEW.ANALYTICDATASET_NEW;
            class &var (ref='0') AutoimmuneConditions SMOKING; /* Use if categorical */
            model SARCOIDOSIS(event='1') = &var AutoimmuneConditions SMOKING CCI_SCORE;
			oddsratio &var.;
        run;
    %end;

    /* Loop through each variable */
    %do i=1 %to &n;
        %let var = %scan(&varlist, &i);
		TITLE "Adjusted Odds - controlling for Smoking and CCI";
        proc logistic data=SNEW.ANALYTICDATASET_NEW;
            class &var (ref='0') SMOKING; /* Use if categorical */
            model SARCOIDOSIS(event='1') = &var  SMOKING CCI_SCORE;
			oddsratio &var.;
        run;
    %end;
%mend;


ods pdf file = "/data/Laryngeal Sarcoidosis/LogReg_adjusted.pdf";
%getCCIORAdjust(Dysphonia ChronicRhinitis ChronicSinusitis VocalCordParalysis SalivaryGlandPathologies CN_Pathologies Epistaxis Polyps Dysphagia);
ods pdf close;

