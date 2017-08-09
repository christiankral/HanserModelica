within HanserModelica.Electrical;
model QuasiStatic "Quasi static single phase circuit"
  extends Modelica.Icons.Example;
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor(L=0.0008) annotation (Placement(transformation(extent={{-2,10},{18,30}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor conductor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor magetizingInductor(L=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(
    f=50,V=100,phi=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor sensor annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Sources.Ramp ramp(duration=1,height=60,offset=-30) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation
  connect(ground.pin, voltageSource.pin_n) annotation (Line(points={{-70,-20},{-70,-10}}, color={85,170,255}));
  connect(voltageSource.pin_p, sensor.pc) annotation (Line(points={{-70,10},{-70,20},{-50,20}}, color={85,170,255}));
  connect(sensor.nc, inductor.pin_p) annotation (Line(points={{-30,20},{-2,20}}, color={85,170,255}));
  connect(magetizingInductor.pin_p, inductor.pin_p) annotation (Line(points={{-20,10},{-20,20},{-2,20}}, color={85,170,255}));
  connect(sensor.pv, sensor.pc) annotation (Line(points={{-40,30},{-50,30},{-50,20}}, color={85,170,255}));
  connect(sensor.nv, ground.pin) annotation (Line(points={{-40,10},{-40,-20},{-70,-20}}, color={85,170,255}));
  connect(magetizingInductor.pin_n, ground.pin) annotation (Line(points={{-20,-10},{-20,-20},{-70,-20}}, color={85,170,255}));
  connect(inductor.pin_n, conductor.pin_p) annotation (Line(points={{18,20},{30,20},{30,10}}, color={85,170,255}));
  connect(conductor.pin_n, ground.pin) annotation (Line(points={{30,-10},{30,-20},{-70,-20}}, color={85,170,255}));
  connect(conductor.G_ref, ramp.y) annotation (Line(points={{42,0},{59,0}}, color={0,0,127}));
  annotation (experiment(Interval=0.001, Tolerance=1e-06));
end QuasiStatic;
