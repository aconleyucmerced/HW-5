
clear

set more off

cd "C:\Users\Amanada Conley\Documents\Amanda\UC Merced\Soc 211\week12" 
use "gss93dd.dta"
log using PS5FINALA.log, replace



**Question #2

pwcorr lfegenes lfesocty lfehrdwk lfechnce, sig

tab1 lfegenes lfesocty lfehrdwk lfechnce, nol






**Creating a reverse of lfsocty_r and lfechnce_r so that they goes in the same direction where 4 is the highest level of individualism, will generate variable called revlfesocty_r, for instance

revrs lfesocty
tab revlfesocty, nol
tab lfesocty

revrs lfechnce
tab revlfechnce, nol
tab lfechnce

pwcorr lfegenes revlfesocty lfehrdwk revlfechnce, sig




**Question 3





factor lfegenes revlfesocty lfehrdwk revlfechnce
rotate, varimax
loadingplot


**Question 4


gen individualism=(lfegenes+revlfesocty+lfehrdwk+revlfechnce)/2

tab individualism


foreach var in individualism lfegenes revlfesocty lfehrdwk revlfechnce {
quietly replace `var'=`var'-1
quietly replace `var'=`var'/4 if `var'!=0
}
sum individualism lfegenes revlfesocty lfehrdwk revlfechnce


quietly {
est clear
eststo: regress prestg80 individualism, ro
eststo: regress prestg80 lfegenes revlfesocty lfehrdwk revlfechnce, r
}

eststo clear

*Base model
eststo m1: regress prestg80 individualism, ro

**>Estimating model 2<**
eststo m2: regress prestg80 lfegenes revlfesocty lfehrdwk revlfechnce, r


esttab, stats(N, labels("N")) nobase noconstant cells(b(star fmt(2)) se(fmt(2) par)) legend starlevels(^ .1 * .05 ** .01 *** .001) mlabels("Scale" "No Scale") title("Comparison") collabels(none)



