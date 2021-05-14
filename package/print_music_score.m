(* ::Package:: *)

(* :Title:MusicScore*)
(* :Context:MusicScore`*)
(* :Author:VT*)
(* :Summary:music score creator*)
(* :Copyright:*)
(* :Package Version:1,Maggio 2020*)
(* :Mathematica Version:11.2*)
(* :History:*)
(* :Sources:*)
(* :Limitations:*)(* :Discussion:*)



BeginPackage["MusicScore`"];

(*SetDirectory[StringReplace[NotebookDirectory[],"package\\" -> ""]];*)

PrintPart::usage="PrintPart [notesList_]
Create a music score from list notes in noteList, they have to be sub list with a number next to note e.g. {{notes..},{notes..}}." ;
AmNatList::usage ="List of notes in American notation, without sharp notes";
AmSharpList::usage = "List of notes in American notation, with sharp notes";
Sharpize ::usage ="Given a note name n that possibly contains a flat mark, it converts it in its equivalent note but with sharp. Eg. Sharpize[\"Bb\"] wil return \"A#\". ";
Bequadro::usage ="Given a note name n that can contain a flat mark or a sharp mark it computes the function off applying a bequadro to it, i.e. removing the alteration. For exaple Bequadro[\"C##4\"] will return \"C4\".";
AllNotes::usage="List of all 88 notes in american notation with octave index as trird elements. Eg. \"A#4\"";
NoteDistance::usage ="Given any two notes in American notation, possibly with flats and sharps, it returns their distance expressed in semitones";
NoteSpaces::usage="Given two notes in American notation, it returns their distance expressed in rows (spaces or rows) on the staff.";
NotePreorderQ::usage= "Given any two notes in American notation, it returns a true value if and only if the first is lower than the second. For example NotePreorderQ[\"C0\", \"D0\"] returns true" ;
NoteSpacesPreorderQ::usage= "Given any two notes in American notation, it returns a true value if and only if the number of spaceson the staff between the two notes il lower than 0. For example NotePreorderQ[\"C#5\", \"C0\"] returns true because the two notes are both placed between the same rows." ;
PrintPart::usage = "Given a list of lists of notes, it represents the notes that are in the same SUB-list vertically aligned (as a chord) horizontally separed by the other sublists. For example
PrintPart[{{\"D4\", \"F4\", \"G4\", \"B4\"}, {\"C4\", \"E4\", \"G4\", \"C4\"}}] will print a nice ending :-).";
IntervalSemitones::usage ="Given the name of an interval, it will return the distance, in semitones between the two notes of the interval. For example IntervalSemitones[\"P8\"] will return 12.";
AddInterval::usage = "Given a note, an interval and a sign (in {\"+\", \"-\"}), it will compute the result of adding the interval to the note. For example AddInterval[\"C4\", \"P8\", \"-\"] will return \"C3\".";

$path = StringReplace[NotebookDirectory[],"package\\" -> ""];
$chiave = Import[$path <>"immagini\\chiave.png"];
$note = Import[$path <>"immagini\\nota_senza_barra.png"];
$notebarra = Import[$path <>"immagini\\nota_barra.png"];
$barra = Import[$path <>"immagini\\barra.png"];
$blank = Import[$path <>"immagini\\blank.png"];
$diesis = Import[$path <>"immagini\\diesis.png"];
$bemolle =Import[$path <>"immagini\\bemolle.png"];

$AmNatList={"C","D","E", "F","G", "A","B"};
$AmSharpList ={"C","C#", "D", "D#",  "E", "F", "F#", "G", "G#",  "A", "A#",  "B"};

Begin["`Private`"];


AllNotes =Join[{"A0", "A#0","B0"},  Flatten[Table [StringJoin[note, IntegerString[number]],  {number, 1, 7, 1}, {note, $AmSharpList}]], {"C8"}];

AllIntervals=Flatten[Map[#[[1]]&, IntervalMap]];
AddInterval[n_, i_, a_]:=None; 
AddInterval[n_, i_/;ContainsAny[AllIntervals, {i}], a_/; a=="+" || a=="-"] := AllNotes[[Position[AllNotes, Sharpize[n]][[1]][[1]]+If[a!="-", IntervalSemitones[i], -IntervalSemitones[i]]]];

Bequadro[n_/; StringLength[n]>2]:= StringJoin[StringTake[n,{1, 1}], StringTake[n, -1]]; 
Bequadro[n_/; StringLength[n]<=2]:= n; 

NoteDistance[a_, b_:"C4"] := Position[AllNotes,Bequadro[a]][[1]][[1]]- Position[AllNotes,Bequadro[b]][[1]][[1]]+If[StringContainsQ[a, "#"] || StringContainsQ[b, "b"], 1, 0]+If[StringContainsQ[b, "#"] || StringContainsQ[a, "b"],- 1, 0];

Sharpize[n_]:=n;
Sharpize[n_/; n != "Cb" && n != "Fb" &&StringTake[n, -1]=="b"] := StringJoin[$AmNatList[[Mod[Position[$AmNatList, StringTake[n, 1]][[1]][[1]]+5, 7]+1]], "#"];
Sharpize[n_/; n=="Fb" ] := "E";
Sharpize[n_/; n=="Cb" ] := "B";

NoteImg[n_/; !StringContainsQ[n,"#"] && !StringContainsQ[n,"b"], img_ :$note]:=ImageCompose[$blank, img, {119, 84.5}];
NoteImg[n_/;StringContainsQ[n, "#"] , img_ :$note] := ImageCompose[ImageCompose[$blank, img, {119, 84.5}], $diesis, {70, 83}];
NoteImg[n_/;StringContainsQ[n, "b"] , img_ :$note] := ImageCompose[ImageCompose[$blank, img, {119, 84.5}], $bemolle, {70, 100}];

NoteSpaces[a_, b_:"C4"] := 7FromDigits[StringTake[a, -1]]- 7FromDigits[StringTake[b, -1]] +Position[$AmNatList, StringTake[a, 1]][[1]][[1]]- Position[$AmNatList, StringTake[b, 1]][[1]][[1]];
NotePreorderQ[a_, b_:"C4"] := NoteDistance[a, b]<=0;

NoteSpacesPreorderQ[a_, b_:"C4"] := NoteSpaces[a, b]<=0;

PrintNote[o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ[n, "G5"]&& !NoteSpacesPreorderQ[n,"C4"], back_:$chiave]:=ImageCompose[back, NoteImg[n,$note],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }];
PrintNote[ o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ[n, "B3"]&& !NoteSpacesPreorderQ[n,"E2"], back_:$chiave]:=ImageCompose[back, NoteImg[n,$note], {300+150*o,104+13.2*NoteSpaces[n, "F2"] }];
PrintNote[ o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ[n, "C4"]&& NoteSpacesPreorderQ["C4",n], back_:$chiave]:=ImageCompose[back, NoteImg[n,$notebarra], {300+150*o,304}];

PrintNote[o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ["Ab5", n]&&Mod[NoteSpaces[n, "G5"], 2]==1, back_:$chiave]:=FoldList[
ImageCompose[#1, $barra,  {320+150*o,473.8+13.2*#2 }]&,
ImageCompose[back, NoteImg[n,$notebarra],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }],
Range[2, NoteSpaces[n, "F5"]-2, 2]][[-1]];

PrintNote[o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ["Ab5", n]&&Mod[NoteSpaces[n, "G5"], 2]==0, back_:$chiave]:=FoldList[
ImageCompose[#1, $barra,  {320+150*o,473.8+13.2*#2 }]&,
ImageCompose[back, NoteImg[n,$note],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }],
Range[2, NoteSpaces[n, "F5"], 2]][[-1]];

PrintNote[o_, n_/;SameQ[n, None]==False && NoteSpacesPreorderQ[n, "Fb2"]&&Mod[NoteSpaces[n, "F2"], 2]==1, back_:$chiave]:=FoldList[
ImageCompose[#1, $barra,  {320+150*o,87-13.2*(#2-1) }]&,
ImageCompose[back, NoteImg[n,$notebarra ],  {300+150*o,104-13.2*NoteSpaces["F2", n] }],
Range[2, NoteSpaces["F2", n], 2]][[-1]];

PrintNote[o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ[n, "Fb2"]&&Mod[NoteSpaces[n, "F2"], 2]==0, back_:$chiave]:=FoldList[
ImageCompose[#1, $barra,  {320+150*o,87-13.2*(#2-1) }]&,
ImageCompose[back, NoteImg[n,$note],  {300+150*o,104-13.2*NoteSpaces["F2", n] }],
Range[2, NoteSpaces["F2", n], 2]][[-1]];

PrintNote[o_, n_/;SameQ[n, None], back_:$chiave]:=back;

PrintChord[o_, c_, back_:$chiave] :=Fold[PrintNote[o, #2, #1]&, back, c];
PrintPartPre[p_,o_:0, back_:$chiave] := Fold[{#1[[1]]+1, PrintChord[#1[[1]], #2, #1[[2]] ]}&, { 0, back}, p  ];
PrintPart[p_] := PrintPartPre[p, 0, $chiave][[2]];

IntervalMap={{"P1", 0}, {"m2", 1}, {"M2", 2}, {"m3", 3}, {"M3", 4}, {"P4", 5}, {"A4", 6}, {"d5", 6}, {"D5", 6}, {"P5", 7}, {"m6", 8}, {"A5", 8}, {"M6", 9}, {"m7", 10}, {"M7", 11}, {"P8", 12}};

IntervalSemitones[i_]:=IntervalMap[[Position[IntervalMap, {i, _}][[1]][[1]]]][[2]];


End[]
EndPackage[]

