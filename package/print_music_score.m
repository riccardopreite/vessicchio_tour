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
AddInterval::usage = "Given a note, an interval and a sign (in {\"+\", \"-\"}), it will compute the result of adding the interval to the note. For example AddInterval[\"C4\", \"P8\", \"-\"] will return \"C3\"."
AllIntervals::usage = "To Do";



pathNote = StringReplace[NotebookDirectory[],"package\\" -> ""];
chiave = Import[pathNote <>"immagini\\chiave.png"];
nota = Import[pathNote <>"immagini\\nota_senza_barra.png"];
notaBarra = Import[pathNote <>"immagini\\nota_barra.png"];
Print[notaBarra];
barra = Import[pathNote <>"immagini\\barra.png"];
blank = Import[pathNote <>"immagini\\blank.png"];
diesis = Import[pathNote <>"immagini\\diesis.png"];
bemolle =Import[pathNote <>"immagini\\bemolle.png"];

(*Lista delle note naturali*)
AmNatList={"C","D","E", "F","G", "A","B"};
(*Lista delle note naturali e alterate (solo #)*)
AmSharpList ={"C","C#", "D", "D#",  "E", "F", "F#", "G", "G#",  "A", "A#",  "B"};

Begin["`Private`"];


(*Mappa da nome dell'intervallo a numero di semitoni fra la prima e la seconda nota*)
IntervalMap={{"P1", 0}, {"m2", 1}, {"M2", 2}, {"m3", 3}, {"M3", 4}, {"P4", 5}, {"A4", 6}, {"d5", 6}, {"D5", 6}, {"P5", 7}, {"m6", 8}, {"A5", 8}, {"M6", 9}, {"m7", 10}, {"M7", 11}, {"P8", 12}};


(*Con la funzone Table generiamo la lista di tutte le note, iterando su AmNatList ed il numero di ottave sulla tastiera del pianoforte, 
poi aggiungiamo i primi tre tasti e l'ultimissimo do: C8*)
AllNotes =Join[{"A0", "A#0","B0"},  Flatten[Table [StringJoin[note, IntegerString[number]],  {number, 1, 7, 1}, {note, AmSharpList}]], {"C8"}];
(*AllIntervals viene generata mappando la relazione IntervalMap sulla prima proiezione*)
AllIntervals=Flatten[Map[#[[1]]&, IntervalMap]];

(*Di defalut il risultato \[EGrave] None, altrimenti, se il nome dell'intervallo esiste, ed il verso \[EGrave] ascendente o discendente, si prende la prima nota, la si rappresenta in forma # anzich\[EAcute] bemolle, 
la si cerca nella lista di tutte e note, sommando la differenza di semitoni espressa dall'intervallo in IntervalMap, o sottraendola, si ottiene la seconda nota*)
AddInterval[n_, i_, a_]:=None; 
AddInterval[n_, i_/;ContainsAny[AllIntervals, {i}], a_/; a=="+" || a=="-"] := AllNotes[[Position[AllNotes, Sharpize[n]][[1]][[1]]+If[a!="-", IntervalSemitones[i], -IntervalSemitones[i]]]];

(*Rimuove le alterazioni*)
Bequadro[n_/; StringLength[n]>2]:= StringJoin[StringTake[n,{1, 1}], StringTake[n, -1]]; 
Bequadro[n_/; StringLength[n]<=2]:= n; 

(*Distanza in semitoni fra due note: si cercano i valori dei bequadri nell lista di tutte le note, poi si agginge un offset che varia da 0 a 1 tono a seconda del fatto che le note di partenza fossero diesis o bemolle
Nono sono considerate le doppie alterazioni.*)
NoteDistance[a_, b_:"C4"] := Position[AllNotes,Bequadro[a]][[1]][[1]]- Position[AllNotes,Bequadro[b]][[1]][[1]]+If[StringContainsQ[a, "#"] || StringContainsQ[b, "b"], 1, 0]+If[StringContainsQ[b, "#"] || StringContainsQ[a, "b"],- 1, 0];

(*converte i diesis in bemolle, i casi di Cb E Fb non hanno un corrispondente diesis "degenere" nella nota precedente.*)
Sharpize[n_]:=n;
Sharpize[n_/; n != "Cb" && n != "Fb" &&StringTake[n, -1]=="b"] := StringJoin[AmNatList[[Mod[Position[AmNatList, StringTake[n, 1]][[1]][[1]]+5, 7]+1]], "#"];
Sharpize[n_/; n=="Fb" ] := "E";
Sharpize[n_/; n=="Cb" ] := "B";

(*In base al nome della nota, general l'immagine da mostrare sullo spartito: se non ci sono alterazioni inserisce solo l'immagine della nota in un rettangolo trasparente, 
se ci sono alterazioni, prima della nota viene inserita l'alterazione. In questo modo, sia note alterate che note naturali occupano lo stesso spazio *)
NoteImg[n_/; !StringContainsQ[n,"#"] && !StringContainsQ[n,"b"], img_ :nota]:=ImageCompose[blank, img, {119, 84.5}];
NoteImg[n_/;StringContainsQ[n, "#"] , img_ :nota] := ImageCompose[ImageCompose[blank, img, {119, 84.5}], diesis, {70, 83}];
NoteImg[n_/;StringContainsQ[n, "b"] , img_ :nota] := ImageCompose[ImageCompose[blank, img, {119, 84.5}], bemolle, {70, 100}];



(*Calcola il numero di spazi che separano due note sullo spartito: il secondo numero dell notazione americana esprime l'indice dell'ottava, 
dunque la prma differenza \[EGrave] la distanza dei due Do che si trovano alle ottave espresse dai nomi delle note, viene poi aggiunto l'offset della prima nota dal Do (in reat\[AGrave] dal La, ma \[EGrave] equivalente), poi sottratto l'offset della seconda.)*)
NoteSpaces[a_, b_:"C4"] := 7FromDigits[StringTake[a, -1]]- 7FromDigits[StringTake[b, -1]] +Position[AmNatList, StringTake[a, 1]][[1]][[1]]- Position[AmNatList, StringTake[b, 1]][[1]][[1]];

NotePreorderQ[a_, b_:"C4"] := NoteDistance[a, b]<=0;

NoteSpacesPreorderQ[a_, b_:"C4"] := NoteSpaces[a, b]<=0;

(*La PrintNote \[EGrave] il primo mattone per la stampa della nota, ha diverse definizioni a seconda del fatto che la nota sia o meno all'interno dello spartito
  e che sia con o senza barra. In generale funziona calcolando la posizion della nota all'iterno dello spartito in base alla sua altezza calcolata con NoteSpaces ed i suo offset da sinista, calcolato con il parametro o.
  L'immagine di sfondo \[EGrave] un aprametro facoltativo perch\[EAcute] permette in qusto modo definizioni pi\[UGrave] snelle delle funzoni successive, con Fold.*)
PrintNote[o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ[n, "G5"]&& !NoteSpacesPreorderQ[n,"C4"], back_:chiave]:=ImageCompose[back, NoteImg[n,nota],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }];
PrintNote[ o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ[n, "B3"]&& !NoteSpacesPreorderQ[n,"E2"], back_:chiave]:=ImageCompose[back, NoteImg[n,nota], {300+150*o,104+13.2*NoteSpaces[n, "F2"] }];
PrintNote[ o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ[n, "C4"]&& NoteSpacesPreorderQ["C4",n], back_:chiave]:=ImageCompose[back, NoteImg[n,notaBarra], {300+150*o,304}];

(*Le quattro definizioni successive, oltre che a stampare la nota sullo spartito, calcolano anche se la nota ha o non ha la barra (Mod[NoteSpaces[n, "G5"], 2]==1)
e per mezzo della Fold (che funziona come la reduce del lisp) stampano anche le barre sopra o sotto lo spartito.
ImageCompose[#1, barra, ...] \[EGrave] la funzione di riduzione applicata dalla reduce, che sull'immagine calcolata al passo precedente, 
all'inizio lo spartito con la nota, aggiunge le barre orizzontali ad un offset calcolato espresso lineare nel valore 
ridotto (la lista Range[...]).
*)
PrintNote[o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ["Ab5", n]&&Mod[NoteSpaces[n, "G5"], 2]==1, back_:chiave]:=FoldList[
ImageCompose[#1, barra,  {320+150*o,473.8+13.2*#2 }]&,
ImageCompose[back, NoteImg[n,notaBarra],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }],
Range[2, NoteSpaces[n, "F5"]-2, 2]][[-1]];

PrintNote[o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ["Ab5", n]&&Mod[NoteSpaces[n, "G5"], 2]==0, back_:chiave]:=FoldList[
ImageCompose[#1, barra,  {320+150*o,473.8+13.2*#2 }]&,
ImageCompose[back, NoteImg[n,nota],  {300+150*o,372+13.2*NoteSpaces[n, "D4"] }],
Range[2, NoteSpaces[n, "F5"], 2]][[-1]];

PrintNote[o_, n_/;SameQ[n, None]==False && NoteSpacesPreorderQ[n, "Fb2"]&&Mod[NoteSpaces[n, "F2"], 2]==1, back_:chiave]:=FoldList[
ImageCompose[#1, barra,  {320+150*o,87-13.2*(#2-1) }]&,
ImageCompose[back, NoteImg[n,notaBarra],  {300+150*o,104-13.2*NoteSpaces["F2", n] }],
Range[2, NoteSpaces["F2", n], 2]][[-1]];

PrintNote[o_, n_/;SameQ[n, None]==False &&NoteSpacesPreorderQ[n, "Fb2"]&&Mod[NoteSpaces[n, "F2"], 2]==0, back_:chiave]:=FoldList[
ImageCompose[#1, barra,  {320+150*o,87-13.2*(#2-1) }]&,
ImageCompose[back, NoteImg[n,nota],  {300+150*o,104-13.2*NoteSpaces["F2", n] }],
Range[2, NoteSpaces["F2", n], 2]][[-1]];

(*_In caso che ci sia da stampre una nota None (caso di errore), non viene effettuata alcuna stampa*)
PrintNote[o_, n_/;SameQ[n, None], back_:chiave]:=back;

(*Fold della print note, iterando sulla lista di note data in input*)
PrintChord[o_, c_, back_:chiave] :=Fold[PrintNote[o, #2, #1]&, back, c];

(*Caso generico della PrintPart in cui l'immagine di sfondo \[EGrave] arbitraria, in modo da poter permettere di fare Fold di print chord per scorrere la lista di note 
  orizzontalmente e passare l'immagine calcolata all'iterazine precedente come parametro.
  Ad ogni paso aumenta l'offset orizzontale dell'accordo, si socrre la lista di accordi da stampare (codificato dalla fold), e si aggiorna lo sfondo.
  Il return di una chiamata \[EGrave] una coppia \[LeftAngleBracket]offset, Img\[RightAngleBracket] in cui la prima proiezione \[EGrave] l'offset da sinistra della nota, la seconda \[EGrave] l'immagine calcolata*)
PrintPartPre[p_,o_:0, back_:chiave] := Fold[{#1[[1]]+1, PrintChord[#1[[1]], #2, #1[[2]] ]}&, { 0, back}, p  ];
(*Wrapper (Curry e Howard direbbero corollario) della funzione precedente in cuiil valore iniziale dell'immagine viene settato come lo spartito vuoto.*)
PrintPart[p_] := PrintPartPre[p, 0, chiave][[2]];

(*Cerca il nome dell'intervallo nella mappa IntervalMap e restituisce il valore in semitoni della distanza espressa dall'intervallo.*)
IntervalSemitones[i_]:=IntervalMap[[Position[IntervalMap, {i, _}][[1]][[1]]]][[2]];


End[]
EndPackage[]

