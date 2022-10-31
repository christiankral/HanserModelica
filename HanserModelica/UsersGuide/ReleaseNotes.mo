within HanserModelica.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (
    preferredView = "info",
    Documentation(info="<html>

<h5>Version 2.0.0, 2022-10-31</h5>
<ul>
<li>Switch to Modelica Standard Library 4.0.0</li>
</ul>

<h5>Version 1.1.2, 2022-04-14</h5>
<ul>
<li>Add <code>final</code> attribute in <a href=\"modelica://HanserModelica.Machines.TestSingleLayer12over12\">TestSingleLayer12over12</a> to fix issue <a href=\"https://github.com/OpenModelica/OpenModelica/issues/8539\">OpenModelica#8539</a>, see
   <a href=\"https://github.com/christiankral/HanserModelica/pull/13\">#13</a></li>
</ul>

<h5>Version 1.1.1, 2020-08-24</h5>
<ul>
<li>Fix documentation, see
   <a href=\"https://github.com/christiankral/HanserModelica/issues/11\">#11</a></li>
</ul>

<h5>Version 1.1.0, 2019-03-24</h5>
<ul>
<li>Switch to Modelica Standard Library 3.2.3, see
   <a href=\"https://github.com/christiankral/HanserModelica/issues/9\">#9</a> and
   <a href=\"https://github.com/christiankral/HanserModelica/issues/10\">#10</a></li>
<li>Fix typos, see
   <a href=\"https://github.com/christiankral/HanserModelica/pull/7\">#7</a>
   and 
   <a href=\"https://github.com/christiankral/HanserModelica/issues/8\">#8</a></li>
</ul>

<h5>Version 1.0.2, 2019-02-14</h5>
<ul>
<li>Added missing <code>each</code> prefix to array modifiers
    <a href=\"https://github.com/christiankral/HanserModelica/pull/6\">#6</a></li>
</ul>

<h5>Version 1.0.1, 2018-08-22</h5>
<ul>
<li>Fix error in coordinates of annotation in
    <a href=\"modelica://HanserModelica.Rotational.TestDCPMMachine\">TestDCPMMachine</a></li>
</ul>

<h5>Version 1.0.0, 2018-08-01</h5>
<ul>
<li>Updated documentation</li>
<li>Unification of sensor instance names</li>
<li>Fully specify initial condition of simulation models</li>
</ul>

<h5>Version 0.10.0, 2018-07-01</h5>
<ul>
<li>Updated documentation</li>
<li>Removed <code>versionBuild</code> from library annotation</li>
<li>Added multi phase example <a href=\"modelica://HanserModelica.Electrical.StarPolygon\">StarPolygon</a>
<li>Improved
    <a href=\"modelica://HanserModelica.Machines.Records.Winding\">winding record</a> and
    <a href=\"modelica://HanserModelica.Machines.Functions.complexTurns\">calculation of complex number of turns</a></li>
<li>Updated parameters
    <a href=\"modelica://HanserModelica.SynchronousMachines.ParameterRecords.SMEE2\">SMEE1</a> and
    <a href=\"modelica://HanserModelica.SynchronousMachines.ParameterRecords.SMEE2\">SMEE2</a></li>
</ul>

<h5>Version 0.9.1, 2018-03-10</h5>
<ul>
<li>Removed obsolete file from package Depot</li>
<li>Added GitHub repository to
    <a href=\"modelica://HanserModelica.UsersGuide.Contact\">Contact</a></li>
</ul>

<h5>Version 0.9.0, 2018-03-05</h5>
<ul>
<li>Initial public version</li>
</ul>

</html>"));
end ReleaseNotes;
