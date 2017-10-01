within HanserModelica.InductionMachines;
model IMC_Inverter2 "Induction machine with squirrel cage and inverter, operated up to twice the nominal frequency"
  extends IMC_Inverter(f=2*fNominal, ramp(duration=2*tRamp),tStep=2.4,TLoad=161.4/2);
  annotation (experiment(StopTime=3,Interval=0.0001,Tolerance=1e-06));
end IMC_Inverter2;
