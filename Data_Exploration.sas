/* Thurs., Aug. 20, 2020 */


/* Instructions:  */

/************************************************************/
/* Explore the predictor variables individually with the target variable  */
/* of whether the customer bought the insurance product. */
/************************************************************/
libname hw_data '/opt/sas/home/eacasey/sasuser.viya/Logistic_Reg_Labarr/HW1_Phase1';

proc contents data=hw_Data.insurance_t;
run;

*target variable is ins;
proc print data=hw_data.insurance_T(obs=100);
run;

/************************************************************/
*Determining variable types;
/************************************************************/
proc freq data=hw_data.insurance_t;
	tables acctage;
run;
/* acctage = continuous */

proc freq data=hw_data.insurance_t;
	tables dda;
run;
/* dda = binary */

proc freq data=hw_data.insurance_t;
	tables ddabal;
run;
/* ddabal = continuous */

proc freq data=hw_data.insurance_t;
	tables dep;
run;
/* dep = continuous */

proc freq data=hw_data.insurance_t;
	tables depamt;
run;
/* depamt = continuous */

proc freq data=hw_data.insurance_t;
	tables cashbk;
run;
/* cashbk = ordinal  */

proc freq data=hw_data.insurance_t;
	tables checks;
run;
/* checks = continuous */

proc freq data=hw_data.insurance_t;
	tables dirdep;
run;
/* dirdep = binary */

proc freq data=hw_data.insurance_t;
	tables nsf;
run;
/* nsf = binary  */

proc freq data=hw_data.insurance_t;
	tables nsfamt;
run;
/* nsfamt = continuous */

proc freq data=hw_data.insurance_t;
	tables mmcred;
run;

/************************************************************/
*Calculating p-values using effects coding;
/************************************************************/

/* For tests of assoc. do ins second to make output more interpretable*/
/* Maybe show extended p-value in appendix? */

/* Ins vs. Acctage (logistic regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=acctage/clodds=pl;
	title 'Logistic Model (Effects Coding) with Age of Oldest Account';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is 0.0079;


/* Ins vs. Ddabal (Logistic Regression) */
ods output parameterestimates=ddabal;
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=ddabal/clodds=pl;
	title 'Logistic Model (Effects Coding) with Checking Account Balance';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is <0.0001;

data mycoefficients1;
	set mycoefficients;
	format probchisq dollar30.29;
run;

/* Ins vs. Dep (Logistic Regression) */
ods output parameterestimates=dep;
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=dep/clodds=pl;
	title 'Logistic Model (Effects Coding) with Checking Deposits';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is <0.0001;

data dep1;
	set dep;
	format probchisq dollar30.29;
run;

/* Ins vs. Depamt (Logistic Regression) */
proc logistic data=hw_data.insurance_t alpha=0.002 outest=ins_depamt_reg;
	model ins(event='1')=depamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with Total Amount Deposited';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is 0.0004;

/* Ins vs. Checks (Logistic Regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=checks/clodds=pl;
	title 'Logistic Model (Effects Coding) with Number of Checks WRITTEN';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is <0.0001;


/* Ins vs. Nsfamt (Logistic Regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=nsfamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with Nsfamt';
run;
/* p-value for Analysis of Max Likelihood Estimates coefficieent is = 0.0001 */
/* DF = 1 */

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=phone/clodds=pl;
	title 'Logistic Model (Effects Coding) with Phone';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=savbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with Savbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=atmamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with Atmamt';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=pos/clodds=pl;
	title 'Logistic Model (Effects Coding) with pos';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=cdbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with cdbal';
run;


proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=irabal/clodds=pl;
	title 'Logistic Model (Effects Coding) with irabal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=mmbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with mmbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=hmval/clodds=pl;
	title 'Logistic Model (Effects Coding) with hmval';
run;


/* Ins vs. Dirdep (MH Chi Square Test) */
proc freq data=hw_data.insurance_t;
	tables dirdep*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. Dirdep";
run;
/* MH p-value is <0.0001 */

/* Ins vs. NSF (MH Chi Square Test) */
proc freq data=hw_data.insurance_t;
	tables nsf*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. Nsf.";
run;
/* MH p-value is <0.0001 */
/* DF = 1 */
/* Test statistic = 43.2028 */

/* Ins vs. Cashbk - Binary vs. Ordinal (MH Chi Square Test) */
proc freq data=hw_data.insurance_t;
	tables cashbk*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. Cashbk";
run;
/* MH p-value is 0.0007 */

/* Ins vs. Mmcred (MH Chi Square Test) */
proc freq data=hw_data.insurance_t;
	tables MMCRED*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. MMCRED";
run;

/* Ins vs. DDA (MH Chi Square Test) */
ods output parameterestimates=dda;
proc freq data=hw_data.insurance_t;
	tables dda*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

data dda1;
	set dda;
	format ;
run;
/* MH p-value <0.0001 */

/************************************************************/
/* Provide a table of odds ratios for only binary predictor variables  */
/* in relation to the target variable. */
/************************************************************/

/************************************************************/
/* Provide a summary of results around the linearity assumption of continuous variables. */
/************************************************************/


/************************************************************/
/* Provide a summary of important data considerations */
/************************************************************/

