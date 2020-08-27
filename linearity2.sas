/*
written by: Jacob Hyman 
Date: 08/26/2020
Objective: determine if the continuous variables 
	for the insurance_t dataset meet the requirments for 
	linearity as a predictor of variable INS (INS describes if a subject 
	purchased an insurance product).
Method: generalized additive model and Box-Tidwell
transformations were used to determine if a non-linear, or exponential 
model would be a better fit for variable respectivly*/

/*Continuous variables to test:
 IRABAL LOCBAL INVBAL ILSBAL MMBAL
 MTGBAL CCBAL CCPURC INCOME LORES 
 HMVAL AGE CRSCORE */


/* creates a data set with transformed variables x * log(x) 
that can be used in the Box-Tidwell test. Also, transforms 
any continuous data that contains 0 so that the the 
Box-Tidwell test can be performed.
*/

data cont_vars;
	set dt.insurance_t;
	
	CCBAL_adj = CCBAL + 1904; *transformed data based on lowest negative CCBAL;
	CCBAL_adj_log_CCBAL_adj = CCBAL_adj * log(CCBAL_adj);
		
	IRABALt = IRABAL + 1; *transformed data;
	IRABAL_log_IRABAL = IRABALt * log(IRABALt);

	LOCBALt = LOCBAL+1; *transformed data;
	LOCBAL_log_LOCBAL = LOCBALt * log(LOCBALt);
	
	INVBALt = INVBAL+1; *transformed data;
	INVBAL_log_INVBAL = INVBALt * log(INVBALt);
	
	ILSBALt = ILSBAL+1; *transformed data;
	ILSBAL_log_ILSBAL = ILSBALt * log(ILSBALt);
	
	MMBALt = MMBAL+1; *transformed data;
	MMBAL_log_MMBAL = MMBALt * log(MMBALt);
	
	MTGBALt = MTGBAL+1; *transformed data;
	MTGBAL_log_MTGBAL = MTGBALt * log(MTGBALt);
	
	CCBAL_pos_log_CCBAL_pos = CCBAL_pos * log(CCBAL_pos);
	
	CCBAL_neg_log_CCBAL_neg = CCBAL_pos * log(CCBAL_neg);
	
	INCOMEt = INCOME+1; *transformed data;
	INCOME_log_INCOME = INCOMEt * log(INCOMEt);
	
	LORES_log_LORES = LORES * log(LORES);
	
	
	HMVAL_log_HMVAL = HMVAL * log(HMVAL);
	
	AGE_log_AGE = AGE * log(AGE);
	
	CRSCORE_log_CRSCORE = CRSCORE * log(CRSCORE);
	
run;

/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: IRABAL
/*_________________________________________________________________________*/

proc freq data=dt.insurance_t;
	where IRABAL <= 0; 
	table IRABAL / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = IRABAL IRABAL_log_IRABAL / clodds=pl clparm=pl;
	title 'IRABAL';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = IRABAL / clodds=pl clparm=pl;
	title 'IRABAL';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(IRABAL, df=4)
	/ dist = binomial link = logit;
run;
/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: LOCBAL
/*_________________________________________________________________________*/


proc freq data=dt.insurance_t;
	where LOCBAL = 0; 
	table LOCBAL / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = LOCBAL LOCBAL_log_LOCBAL / clodds=pl clparm=pl;
	title 'LOCBAL';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = LOCBAL / clodds=pl clparm=pl;
	title 'LOCBAL';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(LOCBAL, df=4)
	/ dist = binomial link = logit;
run;
/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: INVBAL
/*_________________________________________________________________________*/

proc freq data=dt.insurance_t;
	where INVBAL <= 0; 
	table INVBAL / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = INVBAL INVBAL_log_INVBAL / clodds=pl clparm=pl;
	title 'INVBAL';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = INVBAL / clodds=pl clparm=pl;
	title 'INVBAL';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(INVBAL, df=4)
	/ dist = binomial link = logit;
run;
/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: ILSBAL
/*_________________________________________________________________________*/

proc freq data=dt.insurance_t;
	where ILSBAL = 0; 
	table ILSBAL / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = ILSBAL ILSBAL_log_ILSBAL / clodds=pl clparm=pl;
	title 'ILSBAL';
run;


proc logistic data=work.cont_vars;
	model INS(event = '1') = ILSBAL / clodds=pl clparm=pl;
	title 'ILSBAL';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(ILSBAL, df=4)
	/ dist = binomial link = logit;
run;
/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: MMBAL
/*_________________________________________________________________________*/


proc freq data=dt.insurance_t;
	where MMBAL = 0; 
	table MMBAL / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = MMBAL MMBAL_log_MMBAL / clodds=pl clparm=pl;
	title 'MMBAL';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = MMBAL / clodds=pl clparm=pl;
	title 'MMBAL';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(MMBAL, df=4)
	/ dist = binomial link = logit;
run;

/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: MTGBAL
/*_________________________________________________________________________*/

proc freq data=dt.insurance_t;
	where MTGBAL <= 0; 
	table MTGBAL / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = MTGBAL MTGBAL_log_MTGBAL / clodds=pl clparm=pl;
	title 'MTGBAL';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = MTGBAL / clodds=pl clparm=pl;
	title 'MTGBAL';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(MTGBAL, df=4)
	/ dist = binomial link = logit;
run;

/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: CCBAL
/*_________________________________________________________________________*/

proc freq data=work.cont_vars; /*1904 is now 0 after adjustment*/
	table CCBAL_adj / plots=freqplot;
run;


proc logistic data=work.cont_vars;
	model INS(event = '1') = CCBAL_adj CCBAL_adj_log_CCBAL_adj / clodds=pl clparm=pl;
	title 'CCBAL';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = CCBAL_adj  / clodds=pl clparm=pl;
	title 'CCBAL';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(CCBAL, df=4)
	/ dist = binomial link = logit;
run;
/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: LORES
/*_________________________________________________________________________*/

proc freq data=dt.insurance_t;
	where LORES <= 0; 
	table LORES / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = LORES LORES_log_LORES / clodds=pl clparm=pl;
	title 'LORES';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = LORES / clodds=pl clparm=pl;
	title 'LORES';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(LORES, df=4)
	/ dist = binomial link = logit;
run;
/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: INCOME
/*_________________________________________________________________________*/


proc freq data=dt.insurance_t;
	where INCOME <= 0; 
	table INCOME / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = INCOME INCOME_log_INCOME / clodds=pl clparm=pl;
	title 'INCOME';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = INCOME / clodds=pl clparm=pl;
	title 'INCOME';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(INCOME, df=4)
	/ dist = binomial link = logit;
run;

/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: HMVAL
/*_________________________________________________________________________*/


proc freq data=dt.insurance_t;
	where HMVAL <= 0; 
	table HMVAL / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = HMVAL HMVAL_log_HMVAL / clodds=pl clparm=pl;
	title 'HMVAL';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = HMVAL / clodds=pl clparm=pl;
	title 'HMVAL';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(HMVAL, df=4)
	/ dist = binomial link = logit;
run;
/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: AGE
/*_________________________________________________________________________*/

proc freq data=dt.insurance_t;
	where AGE <= 0; 
	table AGE / plots=freqplot;
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = AGE AGE_log_AGE / clodds=pl clparm=pl;
	title 'AGE';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = AGE / clodds=pl clparm=pl;
	title 'AGE';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(AGE, df=4)
	/ dist = binomial link = logit;
run;
/*_________________________________________________________________________*/
/* investigation into variable frequency, p-value of box-tidwell
transformation, and p-value for GAM model of variable: CRSCORE
/*_________________________________________________________________________*/

proc freq data=dt.insurance_t;
	where CRSCORE <= 0; 
	table CRSCORE / plots=freqplot;
run;


proc logistic data=work.cont_vars;
	model INS(event = '1') = CRSCORE CRSCORE_log_CRSCORE / clodds=pl clparm=pl;
	title 'CRSCORE';
run;

proc logistic data=work.cont_vars;
	model INS(event = '1') = CRSCORE / clodds=pl clparm=pl;
	title 'CRSCORE';
run;

proc gam data=dt.insurance_t
	plots = components(clm commonaxes);
	model INS(event='1') = spline(CRSCORE, df=4)
	/ dist = binomial link = logit;
run;
