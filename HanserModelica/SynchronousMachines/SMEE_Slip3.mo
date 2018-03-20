within HanserModelica.SynchronousMachines;
model SMEE_Slip3 "Electrical excited synchronous machine operating at small slip and ie = 10A"
  extends SMEE_Slip1(ie=10);
  annotation (experiment(StopTime=30,Interval=1E-3,Tolerance=1e-06));
end SMEE_Slip3;
