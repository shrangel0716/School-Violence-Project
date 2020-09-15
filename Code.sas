Libname School "C:\Users\jisbsr1\Desktop\Personal\School\BAN 5753\SAS Symposium";

Proc contents data = School.School_violence_dataset;
run;

Proc print data = School.School_violence_dataset (obs=50);
run;

/*VARIABLE GROUPING:
  From Variable order 122 -> 180 (in Table B-1. Variable List)

1. From Order 122 - 134: 13 variables 
   (C0280, C0282, C0284, C0286, C0288, C0290, C0292, C0294, C0296, C0298, C0300, C0302, C0304)
   These variables indicate the extent of the impact of different factors (13 factors) that limit school's efforts
   to reduce or prevent crime, for example: lack of teacher training, lack of parent support, inadequate funds, etc.

   They are ORDINAL variables with 3 levels: 1 = Limits in major way; 2 = Limits in minor way; 3 = Does not limit
   -> KEEP THEM AS ORIGINAL.

2. Order 135: C0306 (Any school deaths from homicides?): 	BINARY (1=Y,2=N) -> KEEP IT AS ORIGINAL
   Order 136: C0308 (Any school shooting incidents?):		BINARY (1=Y,2=N) -> KEEP IT AS ORIGINAL

3. Order 137: C0688_R (Number of arrests at school): already grouped as ORDINAL variable with 4 levels 
   			  (1 = 'None'; 2 = '1-5'; 3 = '6-10';  4 = '11 or more')
   -> KEEP IT AS ORIGINAL

4. Order 138: C0690_R (Any hate crimes): BINARY (1=Y,2=N) -> KEEP IT AS ORIGINAL

5. From order 139 - 150: 12 variables
   (C0374, C0376, C0378, C0380, C0381, C0382, C0383, C0384, C0386, C0389, C0391, C0393)
   These variables indicate the frequency of different types of problems occur at school 
   (bullying, sexual harassment, cyberbullying, verbal abuse, etc)

   They are ORDINAL variables with 5 levels: 
		1 = Happens daily; 			2 = Happens at least once a week ; 3 = Happens at least once a month 
		4 = Happens on occasion ; 	5 = Never happens 
   -> KEEP THEM AS ORIGINAL.
 
6. From order 151 - 184: 34 variables (C0390 - C0456) to indicate the presence of different disciplinary actions at school 
   and whether they are used -> can be grouped into 17 pairs

   For each pair, the 1st question asks if a specific disciplinary action is present (1=Y, 2=N); and
                  the 2nd question asks if it is present (Y), is it used (1=Y, 2=N, -1=Legitimate skip)
   The number of obs for (2=N) in 1st question will be equal to the number of obs for (-1 = Legitimate skip) in 2nd question.
   (i.e., if the disciplinary action is NOT PRESENT at school, then the 2nd question will be not applicable, then the 
    2nd question can be skipped)
   -> 3 possible values when combining each pair:
   			1 + 1 = 2 (present and used)
   			1 + 2 = 3 (present and not used)
   			2 + (-1) = 1 (not present and thus skip)
    -> CODE to combine these 34 variables in to 17 new ORDINAL variables with 3 levels:   
*/


Data School.Subset;
   Set School.School_violence_dataset (Drop= REPFWT: IC:);

     Removal_No_Services = sum(C0390 + C0392);
	 Removal_Tutoring = sum(C0394 + C0396);
	 Transfer_Specialize = sum(C0398 + C0400);
	 Transfer_Regular = sum(C0402 + C0404);
	 Outside_Suspend_No_Services = sum(C0406 + C0408);
	 Outside_Suspend_With_Services = sum(C0410 + C0412);
	 Inside_Suspend_No_Services = sum(C0414 + C0416);
	 Inside_Suspend_With_Services = sum(C0418 + C0420);
     Referral_School_Counselor  = sum(C0422 + C0424);
	 Inside_Disciplinary_Plan = sum(C0426 + C0428);
     Outside_Disciplinary_Plan = sum(C0430 + C0432);
	 BusPrivilege_Loss_Misbehavior = sum(C0434 + C0436);
	 Corporal_Punishment = sum(C0438 + C0440);
	 School_Probation = sum(C0442 + C0444);
	 Detention_Saturday_School = sum(C0446 + C0448);
	 Student_Privileges_Loss = sum(C0450 + C0452);
	 Require_Community_Service = sum(C0454 + C0456);

	 Drop C0390-C0456;
run;

Proc contents data=School.Subset;
run;

Proc print data=School.Subset (obs=50);
run;

   
