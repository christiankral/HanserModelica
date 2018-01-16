within HanserModelica.SynchronousMachines;
model SMEE_Slip3 "Electrical excited synchronous machine operating at small slip and Ie = 19A"
  extends SMEE_Slip0(rampCurrentQS(I=19));
  annotation (experiment(StopTime=30,Interval=1E-3,Tolerance=1e-06));
end SMEE_Slip3;
