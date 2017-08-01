within HanserModelica.Classes;
model CosineWave "Time domain cosine wave"
  extends HanserModelica.Classes.WavePartial;
equation
  wave = A*cos(2*Modelica.Constants.pi*f*time);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},
              {-48.6,26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},
              {-4.42,-78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,-60.6},
              {24.5,-45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,
              73.4},{75.2,78.6},{80,80}})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end CosineWave;
