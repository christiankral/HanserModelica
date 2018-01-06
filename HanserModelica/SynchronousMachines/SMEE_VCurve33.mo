within HanserModelica.SynchronousMachines;
model SMEE_VCurve33 "V curves of electrical excited synchronous machine operated as generator at Pmech = -SNominal/3"
  extends HanserModelica.SynchronousMachines.SMEE_VCurve0(constantTorque(tau_constant=-tauMax/3));
  annotation (experiment(StopTime=200,Interval=0.001,Tolerance=1e-06));
end SMEE_VCurve33;
