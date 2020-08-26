/* Thurs., Aug. 20, 2020 */
/* Last Update Monday, Aug. 24 at 4:30 PM */

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
/* mmcred = ordinal */

proc freq data=hw_data.insurance_t;
	tables branch;
run;
/* branch = nominal  */

proc freq data=hw_data.insurance_t;
	tables res;
run;
/* res = nominal */

proc freq data=hw_data.insurance_t;
	tables ccpurc;
run;

/************************************************************/
*Exploring Potential Redundancies;
/************************************************************/

/* ATM, ATMAMT */
proc reg data=hw_data.insurance_t;
	model ins= atm atmamt/vif collin collinoint;
run;
quit; 
/* VIF < 2 */
/* Collin/collinoint okay too */

/* CC, CCBAL, CCPURC */
proc reg data=hw_data.insurance_t;
	model ins= cc ccbal ccpurc/vif collin collinoint;
run;
quit; 
/* VIF < 2 */
/* Collin/collinoint okay too */

/* CD, CDBAL */
proc reg data=hw_data.insurance_t;
	model ins= cd cdbal/vif collin collinoint;
run;
quit; 
/* VIF < 2 */
/* Collin/collinoint okay too */

/* DDA, DDABAL */
proc reg data=hw_data.insurance_t;
	model ins= dda ddabal/vif collin collinoint;
run;
quit; 
/* VIF < 2 */
/* Collin/collinoint okay too */

/* LOC, LOCBAL */
proc reg data=hw_data.insurance_t;
	model ins= loc locbal/vif collin collinoint;
run;
quit; 
/* VIF < 2 */
/* Collin/collinoint okay too */

/* INV, INVBAL */
proc reg data=hw_data.insurance_t;
	model ins= inv invbal/vif collin collinoint;
run;
quit; 
/* VIF < 2 */
/* Collin/collinoint okay too */

/**********HIGHLY CORRELATED**********/
/* ILS, ILSBAL */
proc reg data=hw_data.insurance_t;
	model ins= ils ilsbal/vif collin collinoint;
run;
quit; 
/* VIF = 37 */
/****************************************/

/* IRA, IRABAL  */
proc reg data=hw_data.insurance_t;
	model ins= ira irabal/vif collin collinoint;
run;
quit;
/* VIF < 2 */

/* LOC, LOCBAL */
proc reg data=hw_data.insurance_t;
	model ins= loc locbal/vif collin collinoint;
run;
quit;
/* VIF < 2 */

/**********POSSIBLY CORRELATED**********/

/* MM, MMBAL, MMCRED */
proc reg data=hw_data.insurance_t;
	model ins= mm mmbal mmcred/vif collin collinoint;
run;
quit;
/* VIF = 8, 7 */

/* Attempting to center mm */
proc stdize data=hw_data.insurance_t method=mean	
	out=insurance_t_center(rename=(mm=mm_center));
	var mm;
run;
/* nothing changed */

/* MM, MMBAL */
proc reg data=hw_data.insurance_t;
	model ins= mm mmbal/vif collin collinoint;
run;
quit;
/* VIF still high */

/* MM, MMCRED */
proc reg data=hw_data.insurance_t;
	model ins= mm mmcred/vif collin collinoint;
run;
quit;
/* This brings all VIF < 2 */

/****************************************/

/* MTG, MTGBAL */
proc reg data=hw_data.insurance_t;
	model ins= mtg mtgbal/vif collin collinoint;
run;
quit;
/* VIF < 2 */

/* NSF, NSFAMT */
proc reg data=hw_data.insurance_t;
	model ins= nsf nsfamt/vif collin collinoint;
run;
quit;
/* VIF < 2 */

/* SAV, SAVBAL */
proc reg data=hw_data.insurance_t;
	model ins= sav savbal/vif collin collinoint;
run;
quit;
/* VIF < 2 */

/* POS, POSAMT */
proc reg data=hw_data.insurance_t;
	model ins= pos posamt/vif collin collinoint;
run;
quit;
/* VIF = 3.5 */





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

