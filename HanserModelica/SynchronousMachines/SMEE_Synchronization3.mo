within HanserModelica.SynchronousMachines;
model SMEE_Synchronization3 "Synchronizazion of electrical excited synchronous machine with 10% higher excitation current"
  extends SMEE_Synchronization1(constantCurrent(I=1.15*smeeData.IeOpenCircuit));
  annotation (experiment(StopTime=0.3,Interval=0.0001,Tolerance=1e-08),
    Documentation(info="<html>
<p>Compare the simulation results of this simulation model with results calculated by 
<a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_Synchronization1\">SMEE_Synchronization1</a>.</p>
</html>"));
end SMEE_Synchronization3;
