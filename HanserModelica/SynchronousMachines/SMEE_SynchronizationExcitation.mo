within HanserModelica.SynchronousMachines;
model SMEE_SynchronizationExcitation "Synchronizazion of electrical excited synchronous machine with 10° voltage phase shift"
  extends SMEE_Synchronization(constantCurrent(I=1.10*smeeData.IeOpenCircuit));
  annotation (experiment(StopTime=0.3,Interval=0.0001,Tolerance=1e-08),
    Documentation(info="<html>
<p>An electrically excited synchronous machine is running with synchrous speed. 
The RMS values of the open circuit machine voltages and mains voltage are equal. 
Tha phase shift if the machine and mains voltages are euqal. However, the excitation current
is 5 percent greater than in 
<a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_Synchronization\">SMEE_Synchronization</a>. 
This causes the stator voltages to be 5 percent greater than the nominal voltage.</p>

<p>After 0.1 seconds the synchronization switch closes. As the machine and mains 
voltages show an equal phase shift in each phase, there occur electrical, magnetic and mechanical reactions
of the machine on the closing switch. The shaft of the synchronous
machine is not connected. Therefore, the rotor inertia heavily influences the overall behavior of the synchronous 
machine after the synchronization switch is closd.
</p>

<p>Simulate for 0.5 seconds and plot:</p>

<ul>
<li><code>smee.tauElectrical</code>: electric torque</li>
<li><code>smee.wMechanical</code>: mechanical speed</li>
<li><code>smee.is[1]</code>: stator phase current 1</li>
<li><code>smee.stator.abs_Phi</code>: magnitude of stator flux</li>
</ul>

<p>Default machine parameters are used.</p>

</html>"));
end SMEE_SynchronizationExcitation;
