within HanserModelica.Electrical;
model QuasiStaticMultiPhase "Quasi static multi phase circuit"
  extends Modelica.Icons.Example;

  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor inductor(L=fill(0.0008, 3))
                                                                                   annotation (Placement(transformation(extent={{-2,10},{18,30}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor conductor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,0})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor mainInductor(L=fill(0.01, 3)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,0})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource(
    f=50,
    V=fill(100, 3),
    phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(3))
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,0})));
  MoveTo_Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor sensor annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Sources.Ramp ramp[3](
    height=fill(60, 3),
    duration=fill(1, 3),
    offset=fill(-30, 3)) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-80,-72},{-60,-52}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-30})));
equation
  connect(voltageSource.plug_p, sensor.pc) annotation (Line(points={{-70,10},{-70,20},{-50,20}}, color={85,170,255}));
  connect(sensor.nc, inductor.plug_p) annotation (Line(points={{-30,20},{-2,20}}, color={85,170,255}));
  connect(mainInductor.plug_p, inductor.plug_p) annotation (Line(points={{-20,10},{-20,20},{-2,20}}, color={85,170,255}));
  connect(sensor.pv, sensor.pc) annotation (Line(points={{-40,30},{-50,30},{-50,20}}, color={85,170,255}));
  connect(inductor.plug_n, conductor.plug_p) annotation (Line(points={{18,20},{30,20},{30,10}}, color={85,170,255}));
  connect(conductor.G_ref, ramp.y) annotation (Line(points={{41,0},{59,0}}, color={0,0,127}));
  connect(star.plug_p, voltageSource.plug_n) annotation (Line(points={{-70,-20},{-70,-10}}, color={85,170,255}));
  connect(star.plug_p, conductor.plug_n) annotation (Line(points={{-70,-20},{30,-20},{30,-10}}, color={85,170,255}));
  connect(mainInductor.plug_n, conductor.plug_n) annotation (Line(points={{-20,-10},{-20,-20},{30,-20},{30,-10}}, color={85,170,255}));
  connect(sensor.nv, star.plug_p) annotation (Line(points={{-40,10},{-40,-20},{-70,-20}}, color={85,170,255}));
  connect(star.pin_n, ground.pin) annotation (Line(points={{-70,-40},{-70,-52}}, color={85,170,255}));
  annotation (experiment(Interval=0.001, Tolerance=1e-06), Documentation(info="<html>
<h5>Plot the following variable(s)</h5>

<ul>
<li><code>sensor.apparentPowerTotal.re</code> versus <code>conductor.G_ref[1]</code>: 
total active power as a function of the variable conductance</li>
<li><code>sensor.abs_i[1]</code> versus <code>conductor.G_ref[1]</code>: 
RMS current of phase 1 as a function of the variable conductance</li>
<li><code>sensor.i[1].im</code> versus <code>sensor.i[1].re</code>: locus of phase current 1</li>
</ul>
</html>"));
end QuasiStaticMultiPhase;
