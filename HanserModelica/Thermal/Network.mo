within HanserModelica.Thermal;
model Network "Thermal network"
  extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor1(R=0.04) annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor2(R=0.04) annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1500, T(start=293.15)) annotation (Placement(transformation(extent={{0,0},{20,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(displayUnit="degC") = 293.15) annotation (Placement(transformation(extent={{90,10},{70,30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=1000) annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,0})));
equation
  connect(fixedHeatFlow.port, thermalResistor1.port_a) annotation (Line(points={{-70,20},{-30,20}}, color={191,0,0}));
  connect(thermalResistor1.port_b, thermalResistor2.port_a) annotation (Line(points={{-10,20},{30,20}}, color={191,0,0}));
  connect(thermalResistor2.port_b, fixedTemperature.port) annotation (Line(points={{50,20},{70,20}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalResistor2.port_a) annotation (Line(points={{10,0},{10,20},{30,20}}, color={191,0,0}));
  connect(temperatureSensor.port, thermalResistor1.port_a) annotation (Line(points={{-50,10},{-50,20},{-30,20}}, color={191,0,0}));
  annotation (experiment(StopTime=400,Interval=0.1,Tolerance=1e-06),
      Documentation(info="<html>
<h4>Plot the following variable(s)</h4>

<ul>
<li><code>temperatureSensor.T</code>: temperature of heat source</li>
<li><code>heatCapacitor.T</code>: temperature of heat capacitor</li>
</ul>
</html>"));
end Network;
