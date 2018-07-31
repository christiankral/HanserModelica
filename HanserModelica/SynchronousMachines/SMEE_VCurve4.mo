within HanserModelica.SynchronousMachines;
model SMEE_VCurve4 "V curves of electrical excited synchronous machine operated as generator at Pmech = -SNominal*3/3"
  extends HanserModelica.SynchronousMachines.SMEE_VCurve1(constantTorque(tau_constant=tauMax));
  annotation (experiment(StopTime=200,Interval=0.1,Tolerance=1e-06), Documentation(info="<html>
<p>Compare the simulation results of this simulation model with results calculated by 
<a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_VCurve1\">SMEE_VCurve1</a>.</p>
</html>"));
end SMEE_VCurve4;
