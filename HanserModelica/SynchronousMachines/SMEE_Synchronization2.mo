within HanserModelica.SynchronousMachines;
model SMEE_Synchronization2 "Synchronizazion of electrical excited synchronous machine with 10° voltage phase shift"
  extends SMEE_Synchronization1(phi=Modelica.SIunits.Conversions.from_deg(10));
  annotation (experiment(StopTime=0.3,Interval=0.0001,Tolerance=1e-08),
    Documentation(info="<html>
<p>Compare the simulation results of this simulation model with results calculated by 
<a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_Synchronization1\">SMEE_Synchronization1</a>.</p>
</html>"));
end SMEE_Synchronization2;
