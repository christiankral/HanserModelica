within HanserModelica.MoveTo_Modelica.Electrical.QuasiStationary.MultiPhase.Sensors;
model CurrentQuasiRMSSensor "Continuous quasi current RMS sensor for multi phase system"
  extends Modelica.Icons.RotationalSensor;
  extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug;
  parameter Integer m(min=1) = 3 "Number of phases";
  Modelica.Blocks.Interfaces.RealOutput I
    "Continuous quasi average RMS of current" annotation (Placement(
        transformation(
        origin={0,-100},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
    currentSensor[m] annotation (Placement(transformation(extent={{-10,-10},
            {10,10}})));
  MoveTo_Modelica.Electrical.QuasiStationary.MultiPhase.Blocks.QuasiRMS quasiRMS(final m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-50})));
equation
  connect(quasiRMS.y, I) annotation (Line(
      points={{0,-61},{0,-100}}, color={0,0,127}));
  connect(plugToPins_p.pin_p, currentSensor.pin_p) annotation (Line(
      points={{-68,0},{-10,0}}, color={85,170,255}));
  connect(currentSensor.pin_n, plugToPins_n.pin_n) annotation (Line(
      points={{10,0},{68,0}}, color={85,170,255}));
  connect(currentSensor.y, quasiRMS.u) annotation (Line(
      points={{0,-11},{0,-38}}, color={85,170,255}));
  annotation (defaultComponentName="currentRMSSensor",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-90,0},{-70,0}}, color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Line(points={{0,-70},{0,-100}}, color={85,170,255}),
        Text(
          extent={{150,-100},{-150,-70}},
          textString="m=%m"),
        Text(
          lineColor={0,0,255},
          extent={{-150,80},{150,120}},
          textString="%name")}),
    Documentation(revisions="<html>
</html>",
      info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> 
value of a multi phase current system, by averaging the phase RMS current phasors <code>i</code>.
</p>
<pre>
  I = sum({'abs'(i[k]) for k in 1:m})/m
</pre>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>
</html>"));
end CurrentQuasiRMSSensor;
