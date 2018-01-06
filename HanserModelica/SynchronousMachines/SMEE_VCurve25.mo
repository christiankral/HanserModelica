within HanserModelica.SynchronousMachines;
model SMEE_VCurve25 "V curves of electrical excited synchronous machine operated as generator at Pmech = -10 kW"
  extends HanserModelica.SynchronousMachines.SMEE_VCurve0(constantTorque(tau_constant=-tauMax/4));
  annotation (experiment(StopTime=200,Interval=0.001,Tolerance=1e-06));
end SMEE_VCurve25;
