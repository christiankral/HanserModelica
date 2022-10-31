within HanserModelica.FirstSteps;
model Electrical4 "R-L series circuit, graphical implementation"
  extends Modelica.Icons.Example;
  // Parameters are constant variables
  parameter Modelica.Units.SI.Resistance R=10 "Resistance";
  parameter Modelica.Units.SI.Inductance L=2 "Inductance";
  parameter Modelica.Units.SI.Voltage v=20 "Total DC voltage";
  // Alias variables to simplify result access
  Modelica.Units.SI.Voltage vR=resistor.v "Voltage drop of resistor";
  Modelica.Units.SI.Voltage vL=inductor.v "Voltage drop of inductor";
  Modelica.Units.SI.Current i=resistor.i "Current";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=v) annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={-40,20})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L) annotation (Placement(transformation(extent={{20,30},{40,50}})));
initial equation
  inductor.i = 0;
equation
  connect(constantVoltage.n, ground.p) annotation (Line(points={{-40,10},{-40,0}}, color={0,0,255}));
  connect(constantVoltage.p, resistor.p) annotation (Line(points={{-40,30},{-40,40},{-20,40}}, color={0,0,255}));
  connect(resistor.n, inductor.p) annotation (Line(points={{0,40},{20,40}}, color={0,0,255}));
  connect(inductor.n, ground.p) annotation (Line(points={{40,40},{60,40},{60,0},{-40,0}}, color={0,0,255}));
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Documentation(info="<html>
<h4>Description</h4>

<p>This is a graphical -- the fourth -- implementation of an R-L series circuit in Modelica.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>vR</code>: voltage drop of resistor</li>
<li><code>vL</code>: voltage drop of inductor</li>
</ul>
</html>"));
end Electrical4;
