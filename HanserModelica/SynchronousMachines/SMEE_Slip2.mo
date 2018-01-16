within HanserModelica.SynchronousMachines;
model SMEE_Slip2 "Electrical excited synchronous machine operating at small slip and Ie = 10A"
  extends SMEE_Slip0(rampCurrentQS(I=10));
  annotation (experiment(StopTime=30,Interval=1E-3,Tolerance=1e-06));
end SMEE_Slip2;
