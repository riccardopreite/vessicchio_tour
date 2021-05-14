(* ::Package:: *)

(* ::Input:: *)
(*(* :Title:IntervalTheoryAndExercises*)*)
(*(* :Context:IntervalTheoryAndExercises`*)*)
(*(* :Author:DD*)*)
(*(* :Summary: Exercises, theory and tests for learning musical intervals*)*)
(*(* :Copyright:*)*)
(*(* :Package Version:1,Maggio 2021*)*)
(*(* :Mathematica Version:11.2*)*)
(*(* :History:*)*)
(*(* :Sources:*)*)
(*(* :Limitations:*)(* :Discussion:*)*)


BeginPackage["IntervalTheoryAndExercises`"];

$pathPlay = StringReplace[NotebookDirectory[],"package\\" -> ""];
Needs["MusicScore`",$pathPlay <>"package/print_music_score.m"];

IntervalTheory::usage ="Prints a panel containing a short tutorial on musical intervals";
InteractiveInterval::usage ="Displays a tool that allows the user to listen and visualize the notes comoning any interval. It also allows the user to specify the starting interval, by using its name as argument.";
IntervalExercise::usage="Called without argumets, it displays an exercise in which the user has to listen an interval and guess its name.";
IntevalTheory[] :=DynamicModule[{intervals, images, captions, buttons, y},
intervals = {"Prima", "Seconda", "Terza", "Quarta", "Quinta", "Sesta", "Settima", "Ottava"};
images = {PrintPart[{{"C4"}, {"C4"}}],  PrintPart[{{"C4"}, {"D4"}}], PrintPart[{{"C4"}, {"E4"}}], PrintPart[{{"C4"}, {"F4"}}], PrintPart[{{"C4"}, {"G4"}}], PrintPart[{{"C4"}, {"A4"}}], PrintPart[{{"C4"}, {"B4"}}], PrintPart[{{"C4"}, {"C5"}}]};

buttons={{Button["Riproduci unisono", EmitSound[Sound[{SoundNote["C4"], SoundNote["C4"]}]]]},

 {Button["Riproduci M2", EmitSound[Sound[{SoundNote["C4"], SoundNote["D4"]}]]], Button["Riproduci m2", EmitSound[Sound[{SoundNote["C4"], SoundNote["Db4"]}]]]}, 
 
{Button["Riproduci M3", EmitSound[Sound[{SoundNote["C4"], SoundNote["E4"]}]]], Button["Riproduci m3", EmitSound[Sound[{SoundNote["C4"], SoundNote["Eb4"]}]]]}, 

{Button["Riproduci P4", EmitSound[Sound[{SoundNote["C4"], SoundNote["F4"]}]]], Button["Riproduci A4", EmitSound[Sound[{SoundNote["C4"], SoundNote["F#4"]}]]]}, 

{Button["Riproduci P5", EmitSound[Sound[{SoundNote["C4"], SoundNote["G4"]}]]], Button["Riproduci d5", EmitSound[Sound[{SoundNote["C4"], SoundNote["Gb4"]}]]]}, 

{Button["Riproduci M6", EmitSound[Sound[{SoundNote["C4"], SoundNote["A4"]}]]], Button["Riproduci m6", EmitSound[Sound[{SoundNote["C4"], SoundNote["Ab4"]}]]]}, 

{Button["Riproduci M7", EmitSound[Sound[{SoundNote["C4"], SoundNote["B4"]}]]], Button["Riproduci m7", EmitSound[Sound[{SoundNote["C4"], SoundNote["Bb4"]}]]]}, 

{Button["Riproduci P8", EmitSound[Sound[{SoundNote["C4"], SoundNote["C5"]}]]]} 

};
captions = {"L'intervallo pi\[UGrave] semplice \[EGrave] detto \"unisono\" ed \[EGrave] quello che intercorre fra due note che hanno lo stesso nome,come,ad esempio,due Do.
Questo intervallo \[EGrave] un intervallo perfetto,per cui la sua sigla \[EGrave] \"P1\"",

"Il secondo intervallo, in ordine di distanza, \[EGrave] detto \"seconda\", esistono due specie di intervalli di seconda: 

- Maggiore, \"M2\" (come fra un Do ed un Re della scala maggiore).
- Minore, \"m2\" (come fra un Do ed un Re bemolle o un Do diesis).",

"Anche l'intervallo di terza esiste in due specie: maggiore o minore. La terza maggiore, \"M3\", \[EGrave] l'intervallo che c'\[EGrave] fra un Do ed un Mi (o fra un Sol ed un Si, per esempio). La terza minore, \"m3\" \[EGrave] l'intervallo che c'\[EGrave] fra un Do ed un Mi bemolle (o fra un Re ed un Fa, od un La ed un Do, per esempio).",
 "L'intervallo di quarta esiste in una sola specie: la quarta perfetta (o giusta), che si rappresenta con la sigla \"P4\". Sulla scala di Do, l'intervallo di quarta perfetta \[EGrave] quello che c'\[EGrave] fra il Do ed il Fa. L'intervallo di quarta diminuita \"d4\", coicide con l'intervallo di terza maggiore, per cui, se non necessario per ragioni armoniche, non viene quasi mai utilizzato. Invece, l'intervallo di quarta aumentata, \"A4\", invece esiste ed \[EGrave] il cosiddetto \"tritono\", un intervallo a lungo avversato e quasi demonizzato per secoli a causa della sua fortissima dissonanza. Sulla scala di Do, l'intervallo di quarta aumentata \[EGrave], ad esempio, l'intervallo fra il Do ed il Fa#, oppure quello fra il Si ed il Fa.",
 "Anche l'intervallo di quinta \[EGrave] perfetto: la sua sigla \[EGrave] \"P5\". Nella scala di Do, l'intervallo di quinta \[EGrave] quello che c'\[EGrave] fra il Do ed il Sol, o fra il Re ed il La, eccetera. \[CapitalEGrave] caratterizzato da una fortissima consonanza. L'intervallo di quinta diminuita, \"d5\" chiaramente coincide con quello di quarta aumentata, mentre l'intervallo di quinta aumentata, \"A5\", coincide con quello di sesta minore \"m6\", ed \[EGrave] caratterizzato da una fortissima dissonanza.",

"L'intervallo di sesta pu\[OGrave] essere maggiore o minore. La sesta maggiore, \"M6\" \[EGrave] un intervallo molto consonante e brillante, mentre la sesta minore \"m6\" (che coincide con la quinta aumentata \"A5\") \[EGrave] un intervallo molto cupo e dissonante. Sulla scala di Do, l'intervallo di sesta maggiore si trova fra il Do ed il La.",
"L'intervallo di settima pu\[OGrave] essere maggiore o minore. La settima maggiore, \"M7\", \[EGrave] anche detto \"sensibile\" perch\[EAcute] trasmette un forte senso di precariet\[AGrave] ed una ceta dissonanza poich\[EAcute] \[EGrave] molto vicino all'intervallo di ottava. Sulla scala di Do, l'intervallo di sesta \[EGrave] quello fra il Do ed il Si. La settima minore, invece trasmette un senso di risoluzione imminente. Sulla scala di Do, \[EGrave] la distanza fra il Do ed il Si bemolle.",
"L'intervallo di ottava \[EGrave] un intervallo perfetto e si indica con la sigla \"P8\". In ogni scala \[EGrave] l'intrvallo fra due note consecutive con lo stesso nome. 
L'intervallo di ottava diminuita \"d8\" coincide con l'intervallo di settima maggiore \"M7\"."

};

(*Manipulate[Part[instruments,n], {n, 1, 5, 1}];
Manipulate[ActionMenu["click",{"one"\[RuleDelayed]( Print[instruments[[1]]]),"two"\[RuleDelayed](x=2)},Appearance\[Rule]stru],{stru,{Automatic,"PopupMenu","Button","Framed",None}}];*)
Column[{
Panel[Row[{SetterBar[Dynamic[y], intervals ]}],Alignment-> Center, ImageSize->{Full, Automatic} ],
Panel[Dynamic[GraphicsRow[{Magnify[images[[First[First[Position[intervals,y]]]]], 1], Column[{Text[Style[captions[[First[First[Position[intervals,y]]]]], LineIndent-> 0, FontFamily->"Arial", FontSize->16]], GraphicsRow[buttons[[First[First[Position[intervals,y]]]]]]}]}, ImageSize->{Full, Automatic}]],FrameMargins->50, ImageSize->{Full, Automatic}]}
]
]

InteractiveInterval[aa_/; ContainsAny[AllIntervals, {aa}]]:= DynamicModule[{interval, basenote, sign, allnotes},
allnotes=Take[AllNotes, {24, -24}];
basenote=RandomChoice[allnotes];
interval=aa;
sign="+";
Panel[Column[{
Dynamic[Magnify[PrintPart[{{basenote}, {AddInterval[basenote, interval, sign]}}], 4]],
Row[{TextCell["Intervallo: "], InputField[Dynamic[interval], String], Button["Randomize", interval=RandomChoice[AllIntervals]]}],
Row[{TextCell["Nota base: "],InputField[Dynamic[basenote], String], Button["Randomize", basenote = RandomChoice[allnotes]]}],
Row[{TextCell["Verso (+/-): "],InputField[Dynamic[sign], String], Button["Randomize", sign = RandomChoice[{"+", "-"}]]}],
Row[{Button["Play", EmitSound[Sound[{SoundNote[basenote], SoundNote[AddInterval[basenote, interval, sign]]}]]]}]
}
]]
]

IntervalExercise[]:= DynamicModule[{interval, basenote, sign, allnotes, guessedinterval, msg, part, cintervals , mMintervals, simpleintervals},
allnotes=Take[AllNotes, {24, -24}];
allnotes=Select[allnotes, StringContainsQ[#, "#"]==False&];
basenote=RandomChoice[allnotes];
mMintervals=Select[AllIntervals,(Characters[#][[1]]=="m" || Characters[#][[1]]=="M" ||  Characters[#][[1]]=="P")&];
Dynamic[msg];
msg="";
Dynamic[guessedinterval];
simpleintervals={"M2", "M3", "M4", "P5", "P1", "P8"};
cintervals=simpleintervals;
interval=RandomChoice[cintervals];
sign=RandomChoice[{"+", "-"}];
part=PrintPart[{{basenote}}];

Panel[Column[{
Row[{TextCell["Difficolt\[AGrave]: "], PopupMenu[Dynamic[cintervals],{
simpleintervals-> "Facile",
simpleintervals-> "Intermedio",
simpleintervals-> "Difficile" }]}],
Dynamic[Magnify[part, 4]],
Row[{TextCell["Intervallo: "], InputField[Dynamic[guessedinterval], String], 
Button["Controlla", 
If[guessedinterval==  interval, msg="Risposta corretta";part=PrintPart[{{basenote}, {AddInterval[basenote, interval, sign]}}];,msg="Risposta errata"; ];
]}],
Row[{Button["Play", EmitSound[Sound[{SoundNote[basenote], SoundNote[AddInterval[basenote, interval, sign]]}]]], 
Button["Nuovo esercizio", basenote=RandomChoice[allnotes];
interval=RandomChoice[cintervals];
sign=RandomChoice[{"+", "-"}];
part=PrintPart[{{basenote}}]; 
msg=""; ]}],
Row[{TextCell[Dynamic[msg]]}]
}
]]
]
End[]
EndPackage[]


(* ::Input:: *)
(**)
