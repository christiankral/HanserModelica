within HanserModelica.SynchronousMachines;
model SMEE_Slip4 "Electrical excited synchronous machine operating at small slip and Ie = 19A"
  extends SMEE_Slip1(Ie=19);
  annotation (experiment(StopTime=30,Interval=1E-3,Tolerance=1e-06));
end SMEE_Slip4;
