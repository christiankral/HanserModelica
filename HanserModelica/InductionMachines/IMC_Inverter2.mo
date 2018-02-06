within HanserModelica.InductionMachines;
model IMC_Inverter2 "Induction machine with squirrel cage and inverter, operated up to twice the nominal frequency"
  extends IMC_Inverter1(
                       f=2*fNominal, ramp(duration=2*tRamp),tStep=2.5,TLoad=161.4/2);
  annotation (experiment(StopTime=3.5,Interval=0.0001,Tolerance=1e-08));
end IMC_Inverter2;
