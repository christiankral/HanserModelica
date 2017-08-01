within HanserModelica.Classes;
partial model WavePartial "Partial parts of sine and cosine wave model"
  parameter Real A = 1 "Amplitude";
  parameter Modelica.SIunits.Frequency f = 1 "Frequency";
  Real wave "Variable of time domain wave form";
  annotation (Icon(graphics={                                             Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end WavePartial;
