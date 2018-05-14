within HanserModelica.MoveTo_Modelica.ComplexBlocks.ComplexMath;
block Division "Output first input divided by second input"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSI2SO;
equation
  y.re = (u1.re*u2.re + u1.im*u2.im) / (u2.re^2 + u2.im^2);
  y.im = (u1.im*u2.re - u1.re*u2.im) / (u2.re^2 + u2.im^2);
  annotation (
    Documentation(info="<html>
<p>
This block computes the output <code>y</code> (element-wise)
by <i>dividing</i> the corresponding elements of
the two inputs <code>u1</code> and <code>u2</code>. Optionally, either input <code>u1</code> or <code>u2</code> or both inputs can be processed conjugate complex, when parameters <code>useConjugateInput1</code> and <code>useConjugateInput2</code> are <code>true</code>, respectively. Depending on <code>useConjugateInput1</code> and <code>useConjugateInput2</code> the internal signals represent either the original or the conjugate complex input signal.
</p>
<pre>
    y = u1Internal / u2Internal;
</pre>

<p><b>Example:</b> If <code>useConjugateInput1 = true</code> and <code>useConjugateInput2 = false</code> the output signal <code>y = Modelica.ComplexMath.conj(u1) / u2</code>.</p>


</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{50,0},{100,0}}, color={0,0,
          127}),Line(points={{-30,0},{30,0}}),Ellipse(
              extent={{-5,20},{5,30}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-5,-20},{5,-30}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},
          lineColor={0,0,127}),Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),Line(points={{-100,60},{-66,60},{-40,30}},
          color={0,0,127}),Line(points={{-100,-60},{0,-60},{0,-50}}, color=
          {0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{50,0},{100,0}},
          color={0,0,255}),Line(points={{-30,0},{30,0}}),
          Ellipse(
              extent={{-5,20},{5,30}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-5,-20},{5,-30}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},
          lineColor={0,0,255}),Line(points={{-100,60},{-66,60},{-40,30}},
          color={0,0,255}),Line(points={{-100,-60},{0,-60},{0,-50}}, color=
          {0,0,255})}));
end Division;
