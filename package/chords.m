(* ::Package:: *)

(* :Title:InstrumentQuiz*)
(* :Context:InstrumentQuiz`*)
(* :Author:VT*)
(* :Summary:instrument quiz package*)
(* :Copyright:*)
(* :Package Version:1,Maggio 2020*)
(* :Mathematica Version:11.2*)
(* :History:*)
(* :Sources:*)
(* :Limitations:*)(* :Discussion:*)


BeginPackage["chords`"];


pathChords = StringReplace[NotebookDirectory[],"package\\" -> ""];


(* in accordiMinori e accordiMaggiori ci sono tutti gli accordi minori e maggiori *)
accordiMinori = {{"C", "Eb", "G"},{"D", "F", "A"},{"E", "G","B" },{"F", "Ab", "C"},{"G", "Bb", "D"},{"A", "C", "E"},{"B", "D", "F#"}};
accordiMaggiori = {{"C", "E", "G"},{"D", "F#", "A"},{"E", "G#","B" },{"F", "A", "C"},{"G", "B", "D"},{"A", "C#", "E"},{"B", "D#", "F#"}};
(* numberOfChoords \[EGrave] il numero di accordi *)
numberOfChoords = 7;
(* notesEU contiene le note in formato europeo e non americano *)
notesEU = {"Do","Re","Mi","Fa","Sol","La","Si"};
(* noteInd contiene l'indice dell'accordo corrente *)
noteInd=1;
nextLabel = "Next";
prevLabel= "Prev";
instrument = "SteelGuitar";


playSong::usage = "Play a song with different instruments";
ChordsTheory::usage = "Theory about chords";
ChordsExercise::usage = "Simple exercise about chords";


Begin["Private`"];

ChordsExercise[] := Module[
{},
correzione = "";
(* accordi contiene tutti gli accordi. Nelle prime 7 posizioni ci sono gli accordi minori, nelle altre posizioni ci sono gli accordi maggiori*)
accordi = {
(* Minori *)
{"C", "Eb", "G"},{"D", "F", "A"},{"E", "G","B" },{"F", "Ab", "C"},{"G", "Bb", "D"},{"A", "C", "E"},{"B", "D", "F#"},
(* Maggiori *)
{"C", "E", "G"},{"D", "F#", "A"},{"E", "G#","B" },{"F", "A", "C"},{"G", "B", "D"},{"A", "C#", "E"},{"B", "D#", "F#"}
};
(* genera un numero da 1 a 14 random per scegliere quale accordo riprodurre. Se il numero generato \[EGrave] tra 1 e 7 compresi allora l'accordo \[EGrave] quello minore, altreimenti sar\[AGrave] un accordo maggiore*)
randomInteger = RandomInteger[{1, 14}];
Panel[
Column[{
Row[{
Style["Riconosciamo gli accordi! Maggiore o Minore?",TextAlignment -> Center, FontFamily->"Arial-Bold",16]
}],
Spacer[87 0.7],
Button["Play", EmitSound[Sound[SoundNote[accordi[[randomInteger]],1,"Piano" ]]]],
Spacer[87 0.7],

Row[{
RadioButtonBar[Dynamic[x], {"Maggiore", "Minore"}],
Spacer[87 0.7],
Button["Correggi",

{If[ x == "Minore" && randomInteger >7 , 
correzione = "Sbagliato!"; 
],
If[ x == "Maggiore" && randomInteger <8 , 
correzione = "Sbagliato!"; 
],
If[ x == "Maggiore" && randomInteger >7 , 
correzione = "Corretto!"; 
],
If[ x == "Minore" && randomInteger <8 , 
correzione = "Corretto!"; 
]}
],
Spacer[87 0.7],
Dynamic[correzione]
}],

Spacer[50 0.7],
Row[{
Button["Next", randomInteger = RandomInteger[{1, 14}]]
}]
}]
]

]

ChordsTheory[] := Module[
{},
Panel[
Row[{
Spacer[72 0.7],Column[{
Row[{

Button[prevLabel, If[noteInd > 1,
noteInd-= 1; 
]
],
Spacer[174 0.7],
Style[Dynamic[notesEU[[noteInd]]],FontFamily->"Arial-Bold",16],
Spacer[174 0.7],

Button[nextLabel,
If[ noteInd < numberOfChoords ,
noteInd+=1;
]
]

}],
Spacer[87  0.7]
}],

Spacer[87  0.7],


Column[{
PopupMenu[Dynamic[instrument], {"SteelGuitar","Piano"}],
Spacer[87 0.7],

Button["Play Maggiore",EmitSound[Sound[SoundNote[accordiMaggiori[[noteInd]],1,instrument ]]]],
    Spacer[50 0.7],

    Button["Play Minore",EmitSound[Sound[SoundNote[accordiMinori[[noteInd]],1,instrument ]]]]

}]


}]
]
]


playSong[] := Module[
{},
img = Import[pathChords <> "immagini/shared/spartito.jpg"];
Panel[
Row[{
Column[{Magnify[img,6]}],
Spacer[120 0.7],
Column[{Row[
{Text["Seleziona lo strumento ed ascolta la canzone!"]}
],
Spacer[50 0.7],
Row[
{

PopupMenu[Dynamic[strumento], {"SteelGuitar","BaritoneSax","Trumpet","Piano","Cello"}],
Spacer[120 0.7],
(* canzone del sole *)
Button["Play",EmitSound[Sound[
{
SoundNote[None, 0.25, strumento],
SoundNote["C4", 0.25,strumento], SoundNote["A4", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["F4", 0.25, strumento], SoundNote["F4", 0.25, strumento], SoundNote["G4", 0.50, strumento], SoundNote[None, 0.50, strumento], SoundNote[None, 0.25, strumento],SoundNote["C4", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["F4", 0.25, strumento], SoundNote["F4", 0.25, strumento], SoundNote[None, 1, strumento],
SoundNote[None, 0.25, strumento],
SoundNote["C4", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["F4", 0.25, strumento], SoundNote["F4", 0.25, strumento], SoundNote["G4", 0.50, strumento], SoundNote[None, 0.50, strumento], SoundNote[None, 0.25, strumento],SoundNote["C4", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["F4", 0.25, strumento], SoundNote["F4", 0.25, strumento], SoundNote[None, 1, strumento],
SoundNote[None, 0.25, strumento],
SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento],SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento],SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento],SoundNote["A4", 0.25, strumento], SoundNote["Bb4", 0.25, strumento], SoundNote["Bb4", 0.25, strumento], SoundNote["C5", 0.50, strumento],SoundNote[None, 0.50, strumento],SoundNote[None, 0.25, strumento],SoundNote["A4", 0.25, strumento],SoundNote["C5", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento], SoundNote["C5", 0.25, strumento], SoundNote["Bb4", 0.25, strumento],SoundNote["Bb4", 0.25, strumento], SoundNote[None, 1, strumento],
SoundNote[None, 0.25, strumento],
SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento],SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento],SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento],SoundNote["A4", 0.25, strumento], SoundNote["Bb4", 0.25, strumento], SoundNote["Bb4", 0.25, strumento], SoundNote["C5", 0.25, strumento],SoundNote[None, 0.25, strumento],SoundNote["A4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["F4", 0.25, strumento], SoundNote[None, 0.25, strumento],
SoundNote["A4", 0.25, strumento],SoundNote["C5", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento], SoundNote["A4", 0.25, strumento], SoundNote["C5", 0.25, strumento],SoundNote["Bb4", 0.25, strumento],SoundNote["Bb4", 0.25, strumento],SoundNote["Bb4", 0.25, strumento], SoundNote[None, 1, strumento],
SoundNote[None, 0.25, strumento],
SoundNote["A4", 0.25, strumento], SoundNote["A4", 0.25, strumento],SoundNote["G4", 0.25, strumento], SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["F4", 0.25, strumento], SoundNote["G4", 0.25, strumento],SoundNote[None, 0.25, strumento], SoundNote["F4", 0.25, strumento], SoundNote["G4", 0.25, strumento], SoundNote["A4", 0.5, strumento],SoundNote["A4", 1, strumento],SoundNote["A4", 0.5, strumento],SoundNote[None, 0.5, strumento],SoundNote[None, 1, strumento],
SoundNote[None, 0.25, strumento],SoundNote["A4", 0.25, strumento],SoundNote["G4", 0.50, strumento],SoundNote[None, 0.25, strumento],SoundNote["A4", 0.25, strumento], SoundNote["A4", 0.25, strumento],SoundNote["G4", 0.25, strumento], SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["F4", 0.25, strumento], SoundNote["A4", 0.5, strumento],SoundNote[None, 0.25, strumento],
SoundNote["C4", 0.25, strumento],SoundNote["D4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["C4", 0.25, strumento],SoundNote["D4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["C4", 0.25, strumento],SoundNote["D4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["Bb4", 0.25,strumento],SoundNote["C4", 0.25, strumento],SoundNote["D4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["Bb4", 0.25,strumento],SoundNote["G4", 0.25,strumento],SoundNote["Bb4", 0.25,strumento],
SoundNote["A4", 0.5,strumento],SoundNote["C4", 0.25, strumento],SoundNote["D4", 0.25, strumento],

SoundNote["F4", 0.25, strumento],SoundNote["G4", 0.25, strumento],SoundNote["C4", 0.25, strumento],SoundNote["D4", 0.25, strumento],SoundNote["F4", 0.25, strumento],SoundNote["Bb4", 0.25, strumento],SoundNote["Bb4", 0.25, strumento],SoundNote["A4", 0.25, strumento],SoundNote["F4", 0.5, strumento],SoundNote["C4", 0.25, strumento],SoundNote["D4", 0.25, strumento],SoundNote["F4", 0.25, strumento]
}
]] 
], 
Button["Stop", EmitSound[Sound[SoundNote["C4",SoundVolume->0]]]],
Spacer[120 0.7]
}
]}]
}]
]

]
End[];
EndPackage[];
