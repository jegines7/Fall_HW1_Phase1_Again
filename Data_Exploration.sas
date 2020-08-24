/* Thurs., Aug. 20, 2020 */


/* Instructions:  */

/************************************************************/
/* Explore the predictor variables individually with the target variable  */
/* of whether the customer bought the insurance product. */
/************************************************************/

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

proc freq data=hw_data.insurance_t;
	tables ddabal;
run;

proc freq data=hw_data.insurance_t;
	tables dda;
run;

proc freq data=hw_data.insurance_t;
	tables dep;
run;

proc freq data=hw_data.insurance_t;
	tables depamt;
run;


proc freq data=hw_data.insurance_t;
	tables checks;
run;


proc freq data=hw_data.insurance_t;
	tables nsfamt;
run;

proc freq data=hw_data.insurance_t;
	tables cashbk;
run;

/************************************************************/
*Calculating p-values using effects coding;
/************************************************************/

/* DON'T FORGEET ABOUT CHI-SQUARE TESTS */

/* Ins vs. Acctage (logistic regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=acctage/clodds=pl;
	title 'Logistic Model (Effects Coding) with Age of Oldest Account';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is 0.0079;

/* Ins vs. DDA (MH Chi Square Test) */
proc freq data=hw_data.insurance_t;
	tables ins*dda/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;
/* MH p-value <0.0001 */

/* Ins vs. Ddabal (Logistic Regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=ddabal/clodds=pl;
	title 'Logistic Model (Effects Coding) with Checking Account Balance';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is <0.0001;

/* Ins vs. Dep (Logistic Regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=dep/clodds=pl;
	title 'Logistic Model (Effects Coding) with Checking Deposits';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is <0.0001;

/* Ins vs. Depamt (Logistic Regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=depamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with Total Amount Deposited';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is 0.0004;

/* Ins vs. Cashbk (MH Chi Square Test) */
proc freq data=hw_data.insurance_t;
	tables ins*cashbk/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. Cashbk";
run;
/* MH p-value is 0.0007 */

/* Ins vs. Checks (Logistic Regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=checks/clodds=pl;
	title 'Logistic Model (Effects Coding) with Number of Checks WRITTEN';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is <0.0001;

/* Ins vs. Dirdep (MH Chi Square Test) */
proc freq data=hw_data.insurance_t;
	tables ins*dirdep/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. Dirdep";
run;
/* MH p-value is <0.0001 */

/* Ins vs. NSF (MH Chi Square Test) */
proc freq data=hw_data.insurance_t;
	tables ins*nsf/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. Dirdep";
run;

/* Ins vs. Nsfamt (Logistic Regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=nsfamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with Nsfamt';
run;
