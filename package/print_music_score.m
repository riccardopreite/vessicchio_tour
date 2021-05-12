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


Sharpize[n_]:=n;
Sharpize[n_/; StringTake[n, -1]=="b"] := StringJoin[$AmNatList[[Mod[Position[$AmNatList, StringTake[n, 1]][[1]][[1]]+5, 7]+1]], "#"];

NoteImg[n_/; !StringContainsQ[n,"#"] && !StringContainsQ[n,"b"], img_ :$note]:=ImageCompose[$blank, img, {119, 84.5}];
NoteImg[n_/;StringContainsQ[n, "#"] , img_ :$note] := ImageCompose[ImageCompose[$blank, $note, {119, 84.5}], $diesis, {70, 83}];
NoteImg[n_/;StringContainsQ[n, "b"] , img_ :$note] := ImageCompose[ImageCompose[$blank, $note, {119, 84.5}], $bemolle, {70, 100}];

NoteDistance[a_, b_:"C4"] := 12FromDigits[StringTake[a, -1]]- 12FromDigits[StringTake[b, -1]] +Position[$AmSharpList, Sharpize[StringTake[a, {1,-2}]]][[1]][[1]]- Position[$AmSharpList,Sharpize[StringTake[b, {1,-2}]]][[1]][[1]];

NoteSpaces[a_, b_:"C4"] := 7FromDigits[StringTake[a, -1]]- 7FromDigits[StringTake[b, -1]] +Position[$AmNatList, StringTake[a, 1]][[1]][[1]]- Position[$AmNatList, StringTake[b, 1]][[1]][[1]];

NotePreorderQ[a_, b_:"C4"] := NoteDistance[a, b]<=0;

NoteSpacesPreorderQ[a_, b_:"C4"] := NoteSpaces[a, b]<=0;

PrintNote[o_, n_/;NotePreorderQ[n, "G5"]&& !NotePreorderQ[n,"C4"], back_:$chiave]:=ImageCompose[back, NoteImg[n,$note],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }];
PrintNote[ o_, n_/;NotePreorderQ[n, "B3"]&& !NotePreorderQ[n,"E2"], back_:$chiave]:=ImageCompose[back, NoteImg[n,$note], {300+150*o,104+13.2*NoteSpaces[n, "F2"] }];
PrintNote[ o_, n_/;NotePreorderQ[n, "C4"]&& NotePreorderQ["C4",n], back_:$chiave]:=ImageCompose[back, NoteImg[n,$notebarra], {300+150*o,304}];

PrintNote[o_, n_/;NotePreorderQ["Ab5", n]&&Mod[NoteSpaces[n, "G5"], 2]==1, back_:$chiave]:=FoldList[
ImageCompose[#1, $barra,  {320+150*o,473.8+13.2*#2 }]&,
ImageCompose[back, NoteImg[n,$notebarra],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }],
Range[2, NoteSpaces[n, "F5"]-2, 2]][[-1]];

PrintNote[o_, n_/;NotePreorderQ["Ab5", n]&&Mod[NoteSpaces[n, "G5"], 2]==0, back_:$chiave]:=FoldList[
ImageCompose[#1, $barra,  {320+150*o,473.8+13.2*#2 }]&,
ImageCompose[back, NoteImg[n,$note],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }],
Range[2, NoteSpaces[n, "F5"], 2]][[-1]];

PrintNote[o_, n_/;NotePreorderQ[n, "Fb2"]&&Mod[NoteSpaces[n, "F2"], 2]==1, back_:$chiave]:=FoldList[
ImageCompose[#1, $barra,  {320+150*o,87-13.2*(#2-1) }]&,
ImageCompose[back, NoteImg[n,$notebarra],  {300+150*o,104-13.2*NoteSpaces["F2", n] }],
Range[2, NoteSpaces["F2", n], 2]][[-1]];

PrintNote[o_, n_/;NotePreorderQ[n, "Fb2"]&&Mod[NoteSpaces[n, "F2"], 2]==0, back_:$chiave]:=FoldList[
ImageCompose[#1, $barra,  {320+150*o,87-13.2*(#2-1) }]&,
ImageCompose[back, NoteImg[n,$note],  {300+150*o,104-13.2*NoteSpaces["F2", n] }],
Range[2, NoteSpaces["F2", n], 2]][[-1]];


PrintChord[o_, c_, back_:$chiave] :=Fold[PrintNote[o, #2, #1]&, back, c];
PrintPartPre[p_,o_:0, back_:$chiave] := Fold[{#1[[1]]+1, PrintChord[#1[[1]], #2, #1[[2]] ]}&, { 0, back}, p  ];


PrintPart[p_] := PrintPartPre[p, 0, $chiave][[2]];

End[]
EndPackage[]

