within HanserModelica.InductionMachines;
model IMC_Inverter2 "Induction machine with squirrel cage and inverter, operated up to twice the nominal frequency"
  extends IMC_Inverter1(f=2*fsNominal, ramp(duration=2*tRamp),tStep=2.5,TLoad=161.4/2);
  annotation (experiment(StopTime=3.5,Interval=0.0001,Tolerance=1e-08), Documentation(info="<html>

<h4>Description</h4>

<p>Compared to 
<a href=\"\">IMC_Inverter1</a> in this example frequency is raised by a ramp up to double the nominal frequency in double the time. 
At time <code>tStep</code> a load step is applied.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>fActual</code>: actual supply frequency</li>
<li><code>voltageRMSSensor.V</code>: quasi RMS stator voltage</li>
<li><code>imc.stator.abs_Phi</code>: magnitude of stator flux</li>
<li><code>imc.tauElectrical</code>: electromagnetic torque</li>
<li><code>imc.wMechanical</code>: speed</li>
<li><code>currentRMSSensor.I</code>: quasi RMS stator current</li>
</ul>

</html>"));
end IMC_Inverter2;
