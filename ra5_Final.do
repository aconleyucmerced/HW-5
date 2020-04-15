

clear

set more off

cd "C:\Users\Amanada Conley\Documents\Amanda\UC Merced\Soc 211\IPUMS" 
use "usa_00002_modified.dta"
log using RA5.log


**Prep

gen amerind=.

recode amerind .=1 if racamind==2
recode amerind .=0 if racamind==1


label define amerind 0 "Not American Indian" 1 "American Indian"
label values amerind amerind

tab amerind 

gen r_hcovany=.

recode r_hcovany .=1 if hcovany==1
recode r_hcovany .=0 if hcovany==2


label define r_hcovany 0 "Have Health Coverage" 1 "No Health Coverage"
label values r_hcovany r_hcovany

tab r_hcovany 

tab amerind r_hcovany


**2

tab hcovany, nol

reg r_hcovany amerind educ ftotinc

logit r_hcovany amerind educ ftotinc 

display "OR for beta(r_hcovany) = e^.4803866 = " exp(.4803866)



*clearing old estimates*
eststo clear

*Base model
eststo m1: reg r_hcovany amerind educ ftotinc

**>Estimating model 2<**
eststo m2: logit r_hcovany amerind educ ftotinc 


esttab, stats(N, labels("N")) nobase noconstant cells(b(star fmt(2)) se(fmt(2) par)) legend starlevels(^ .1 * .05 ** .01 *** .001) mlabels("OLS" "MLE") title("Odds ratio of ") collabels(none) eform








