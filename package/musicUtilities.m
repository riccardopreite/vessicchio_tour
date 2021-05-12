(* ::Package:: *)

(* :Title:MusicPlayUtilities*)
(* :Context:MusicPlayUtilities`*)
(* :Author:VT*)
(* :Summary:music play utilities*)
(* :Copyright:*)
(* :Package Version:1,Maggio 2020*)
(* :Mathematica Version:11.2*)
(* :History:*)
(* :Sources:*)
(* :Limitations:*)
(* :Discussion:*)


BeginPackage["MusicPlayUtilities`"];

$pathPlay = StringReplace[NotebookDirectory[],"package\\" -> ""];
Needs["MusicScore`",$pathPlay <>"package/print_music_score.m"];
Needs["MusicUtilities`",$pathPlay <>"package/utilities.m"];
simpleScale = {"C4","D4","E4","F4","G4","A4","B4"};


showNotes::usage="showNotes []
Show a simple music score with notes in noteList and play that with button to navigate in notesList.";


Begin["`Private`"];


showNotes[]:= DynamicModule[
{list = simpleScale,  prevLabel = "--", nextLabel = "--",instrument = "SteelGuitar"},
spartitoList = createSpartitoList[list];
spartito = PrintPart[spartitoList];
noteInd = 1;
labelList = {};
euList = {};
usList = {};
euList = toLabelList[list,{},"e"];
usList = list;
labelList = euList;
labelList = removeBrackets[labelList];
nextLabel = Dynamic[labelList[[noteInd+1]]];
panel = Panel[Row[
{
EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]],Spacer[72 0.7],Column[{
Row[{

Button[Dynamic[prevLabel], 
If[noteInd > 2,
nextLabel =labelList[[noteInd]];

EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]];noteInd-= 1; prevLabel = Dynamic[labelList[[noteInd-1]]],
If[noteInd > 1,
nextLabel = Dynamic[labelList[[noteInd+1]]];EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]]; noteInd-= 1;  prevLabel = "--"
]
]
],
Spacer[174 0.7],
Style[Dynamic[  labelList[[noteInd]]]  ,FontFamily->"Arial-Bold",14],
Spacer[174 0.7],

Button[Dynamic[nextLabel],
If[ noteInd < Length[list] -1 ,
prevLabel = labelList[[noteInd]];noteInd+=1;
EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]];
nextLabel = Dynamic[labelList[[noteInd +1]]],

If[noteInd < Length[list],
prevLabel = Dynamic[labelList[[noteInd-1]]];noteInd+=1; EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]]; nextLabel = "--"
]
]
]

}],
Spacer[87  0.7],
Row[{Magnify[Dynamic[spartito],4]}]
}],

Spacer[87  0.7],


Column[{
PopupMenu[Dynamic[instrument],{"SteelGuitar","Banjo","Contrabass","Oboe","Piano","SopranoSax","Clarinet"}],
Spacer[87 0.7],

Button["Play",EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]]],
    Spacer[50 0.7],

    Button["Next Lesson",Print["To do refresh panel for next lesson"]]
 ,Spacer[50 0.7],
RadioButtonBar[Dynamic[labelList],{removeBrackets[euList]->"EU notes",removeBrackets[usList]->"US notes"}] 

}] 


}],ImageSize->700]
]

End[]
EndPackage[]

