within HanserModelica.InductionMachines;
model IMS_Characteristics3 "Characteristic curves of induction machine with slip rings and Rr'=0.97"
  extends HanserModelica.InductionMachines.IMS_Characteristics1(Rr=0.97/imsData.turnsRatio^2);
end IMS_Characteristics3;
