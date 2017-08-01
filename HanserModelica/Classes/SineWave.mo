within HanserModelica.Classes;
model SineWave "Time domain sine wave"
  extends HanserModelica.Classes.WavePartial;
equation
  wave = A*sin(2*Modelica.Constants.pi*f*time);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},
              {-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},
              {-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},
              {29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{
              57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end SineWave;
