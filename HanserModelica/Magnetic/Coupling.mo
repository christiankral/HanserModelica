within HanserModelica.Magnetic;
model Coupling "Electro-magnetic coupling"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Resistance R = 10 "Resistance";
  parameter Modelica.Units.SI.Inductance L = 2 "Inductance";
  parameter Integer N=1000 "Number of turns";
  parameter Modelica.Units.SI.Permeance G_m = L/N^2 "Permeance of the magnetic circuit";
  parameter Modelica.Units.SI.Voltage v = 20 "Total DC voltage";
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N=N, i(fixed=true, start=0))
                                                                            annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance permeance(G_m=G_m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,0})));
  Modelica.Magnetic.FluxTubes.Sensors.MagneticFluxSensor fluxSensor annotation (Placement(transformation(extent={{40,30},{60,10}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground groundMagnetic annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Electrical.Analog.Basic.Ground groundElectric annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=v) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.2) annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
equation
  connect(converter.port_p, fluxSensor.port_p) annotation (Line(points={{20,6},{
          20,20},{40,20}},                                                                       color={255,127,0}));
  connect(fluxSensor.port_n, permeance.port_p) annotation (Line(points={{60,20},{80,20},{80,10}}, color={255,127,0}));
  connect(converter.port_n, permeance.port_n) annotation (Line(points={{20,-6},
          {20,-20},{80,-20},{80,-10}},                                                                      color={255,127,0}));
  connect(groundMagnetic.port, converter.port_n) annotation (Line(points={{20,-30},
          {20,-6}},                                                                          color={255,127,0}));
  connect(constantVoltage.p, resistor.p) annotation (Line(points={{-80,10},{-80,20},{-60,20}}, color={0,0,255}));
  connect(resistor.n, switch.p) annotation (Line(points={{-40,20},{-30,20}}, color={0,0,255}));
  connect(switch.n, converter.p) annotation (Line(points={{-10,20},{0,20},{0,
          6}},                                                                    color={0,0,255}));
  connect(constantVoltage.n, groundElectric.p) annotation (Line(points={{-80,-10},{-80,-30}}, color={0,0,255}));
  connect(constantVoltage.n, converter.n) annotation (Line(points={{-80,-10},
          {-80,-20},{0,-20},{0,-6}},                                                                    color={0,0,255}));
  connect(booleanStep.y, switch.control) annotation (Line(points={{-69,40},{
          -20,40},{-20,27}},                                                                   color={255,0,255}));
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
      Documentation(info="<html>
<h4>Description</h4>

<p>This examples demonstrates electro-magnetic coupling.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>fluxSensor.Phi</code>: flux of the magnetic circuit</li>
</ul>
</html>"));
end Coupling;
