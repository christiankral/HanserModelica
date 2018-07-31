within HanserModelica.SynchronousMachines;
model SMEE_ShortCircuit2 "Two phase short-circuit of electrical excited synchronous machine "
  extends HanserModelica.SynchronousMachines.Templates.SMEE_ShortCircuit;
  extends Modelica.Icons.Example;
equation
  connect(pin1.pin_p, pin2.pin_p) annotation (Line(points={{-42,70},{-52,70},{-52,50},{-42,50}}, color={0,0,255}));
  annotation(experiment(StopTime=0.5,Interval=0.0001,Tolerance=1e-08), Documentation(info="<html>

<h4>Description</h4>

<p>
This example investigates a two-phase short-circuit of an electrical excited synchronous machine. 
The machine is operated at nominal speed. The short circuit is applied starting from a no load condition</p> 
</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>smee.is[1]</code>, <code>smee.is[2]</code>, <code>smee.is[3]</code>: stator currents of phase 1, 2 and 3</li>
<li><code>smee.ir[1]</code>, <code>smee.ir[2]</code>: d- and q-axis rotor current of damper cage</li>
<li><code>smee.ie</code>: excitation current</li>
</ul>
</html>"));
end SMEE_ShortCircuit2;
