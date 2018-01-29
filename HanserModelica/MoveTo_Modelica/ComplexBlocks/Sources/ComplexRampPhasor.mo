within HanserModelica.MoveTo_Modelica.ComplexBlocks.Sources;
block ComplexRampPhasor "Generate a phasor with ramped magnitude and constant angle"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
  import Modelica.Constants.eps;
  parameter Real magnitude1(final min=eps,start=1) "Magnitude of complex phasor at startTime"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasor.png"));
  parameter Real magnitude2(final min=eps,start=1) "Magnitude of complex phasor at startTime+duration";
  parameter Boolean useLogRamp = false "Ramp appears linear on a logarithmic scale, if true";
  parameter Modelica.SIunits.Angle phi(start=0) "Angle of complex phasor";
  parameter Modelica.SIunits.Time startTime=0 "Start time of frequency sweep";
  parameter Modelica.SIunits.Time duration(min=0.0, start=1) "Duration of ramp (= 0.0 gives a Step)";
  Real magnitude "Actual magntiude of complex phasor";
equation

  magnitude = if not useLogRamp then
    magnitude1 + (if time < startTime then
      0 else
      if time < (startTime + max(duration,eps)) then
        (time - startTime)*(magnitude2-magnitude1)/max(duration,eps)
      else
      magnitude2-magnitude1)
  else
    if time < startTime then magnitude1 else
    if time < (startTime + max(duration,eps)) then
      10^(log10(magnitude1) + (log10(magnitude2) - log10(magnitude1))*min(1, (time-startTime)/max(duration,eps)))
    else
      magnitude2;

  y = magnitude*Modelica.ComplexMath.exp(Complex(0, phi));

  annotation (defaultComponentName="complexRamp",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Polygon(
              points={{-10,90},{-16,68},{-4,68},{-10,90}},
              lineColor={192,192,192},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(points={{-10,68},{-10,-90}},
          color={95,95,95}),Line(points={{-90,0},{82,0}}, color={95,95,95}),
          Polygon(
              points={{90,0},{68,6},{68,-6},{90,0}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-10,-10},{14,10}},
              color={0,0,255}),
                             Polygon(
              points={{28,22},{7,13},{16,2},{28,22}},
              lineColor={95,95,95},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),Line(
              points={{-10,6},{50,56}},
              color={0,0,255}),
                             Polygon(
              points={{66,70},{45,61},{54,50},{66,70}},
              lineColor={95,95,95},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
The output y is a complex phasor with constant angle and a ramped magnitude.
</p>

<p>
In case of <code>useLogRamp == false</code> the magnitude ramp is linear:
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasorLinear.png\"
     alt=\"ComplexRampPhasorLinear.png\">
</p>

<p>
In case of <code>useLogRamp == true</code> the magnitude ramp appears linear on a logarithmic scale:
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasorLog.png\"
     alt=\"ComplexRampPhasorLog.png\">
</p>

</html>"));
end ComplexRampPhasor;
