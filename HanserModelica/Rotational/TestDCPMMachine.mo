within HanserModelica.Rotational;
model TestDCPMMachine "Test model of DCPMMachine"
  extends Modelica.Icons.Example;
  Components.DCPMMachine machine(J=0.2,Ra=0.22,k=2,La=0.004) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque load(
    tau_nominal=-100,TorqueDirection=false,w(displayUnit="rpm"),
    w_nominal(displayUnit="rpm") = 104.71975511966)
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.2) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(V=220,startTime=0.2,duration=0.4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,30})));
equation
  connect(machine.flange, inertia.flange_a) annotation (Line(points={{-40,0},{0,0}}, color={0,0,0}));
  connect(inertia.flange_b, load.flange) annotation (Line(points={{20,0},{30,0}}, color={0,0,0}));
  connect(rampVoltage.n, machine.pin_an) annotation (Line(points={{-40,30},{-30,30},{-30,10.2},{-44,10.2}},
                                                                                                            color={0,0,255}));
  connect(machine.pin_an, ground.p) annotation (Line(points={{-44,10.2},{-30,10.2},{-30,30},{-10,30}},
                                                                                                   color={0,0,255}));
  connect(rampVoltage.p, machine.pin_ap) annotation (Line(points={{-60,30},{-70,30},{-70,10},{-56,10}}, color={0,0,255}));
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06));
end TestDCPMMachine;
